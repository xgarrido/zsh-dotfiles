"""
tab_color_by_host.py — Terminator plugin
Colors the active tab based on the hostname in the terminal title.

Install:
  mkdir -p ~/.config/terminator/plugins
  cp tab_color_by_host.py ~/.config/terminator/plugins/

Then restart Terminator, open Preferences → Plugins, and enable
"TabColorByHost".

Configuration:
  Edit HOST_COLORS below. Keys are substrings matched against the
  terminal title (case-insensitive). The first match wins.
  Values are CSS color strings (hex, rgb(), named colors, etc.).
"""

import terminatorlib.plugin as plugin
from gi.repository import Gdk, GLib, Gtk
from terminatorlib.util import dbg, err

AVAILABLE = ["TabColorByHost"]

# --- Configure your hostname → color mapping here ---
HOST_COLORS = {
    "ldas-grid.ligo.caltech.edu": ("#4C72B0", "Caltech"),
    "ldas-grid.ligo-la.caltech.edu": ("#DD8452", "Livingston"),
    "ldas-grid.ligo-wa.caltech.edu": ("#55A868", "Handford"),
    "perlmutter": ("#C44E52", "NERSC"),
    "cca": ("#8172B3", "CCIN2P3"),
}

# Fallback color when no hostname matches (your default active tab color)
DEFAULT_COLOR = "#5294E2"

# -------------------------------------------------------


def _color_from_title(title):
    title_lower = (title or "").lower()
    for pattern, (color, shortname) in HOST_COLORS.items():
        if pattern.lower() in title_lower:
            return color, shortname
    return None


def _apply_color_to_tab(notebook, page_index, color):
    page = notebook.get_nth_page(page_index)
    tab_label = notebook.get_tab_label(page)
    if tab_label is None:
        return

    # Give this tab label a unique GTK widget name
    widget_name = "tab-host-%d" % page_index
    tab_label.set_name(widget_name)

    # Also color the label widget directly as fallback
    rgba = Gdk.RGBA()
    rgba.parse(color)

    def apply_rgba(widget, rgba):
        widget.override_background_color(Gtk.StateFlags.NORMAL, rgba)
        widget.override_background_color(Gtk.StateFlags.ACTIVE, rgba)
        widget.override_background_color(Gtk.StateFlags.SELECTED, rgba)
        widget.override_background_color(Gtk.StateFlags.PRELIGHT, rgba)
        widget.override_background_color(Gtk.StateFlags.CHECKED, rgba)
        if hasattr(widget, "get_children"):
            for child in widget.get_children():
                apply_rgba(child, rgba)

    apply_rgba(tab_label, rgba)


class TabColorByHost(plugin.Plugin):
    """Color notebook tabs by hostname detected in the terminal title."""

    capabilities = ["terminal_title_change_watch"]

    def __init__(self):
        super().__init__()
        self._watched = set()
        # Stores the last matched color per terminal (keyed by id(terminal))
        # so that subsequent title changes from the remote prompt don't revert
        # the color back to default.
        self._terminal_colors = {}
        self._schedule_watch()

    # ------------------------------------------------------------------
    # Watching for new terminals
    # ------------------------------------------------------------------

    def _schedule_watch(self):
        GLib.timeout_add(500, self._watch_terminals)

    def _watch_terminals(self):
        try:
            from terminatorlib.terminator import Terminator as Term

            instance = Term()
            for terminal in instance.terminals:
                if id(terminal) not in self._watched:
                    self._watched.add(id(terminal))
                    terminal.connect("title-change", self._on_title_change)
                    # Also watch the notebook for tab switches
                    notebook = self._get_notebook(terminal)
                    if notebook is not None and id(notebook) not in self._watched:
                        self._watched.add(id(notebook))
                        notebook.connect("switch-page", self._on_switch_page)
        except Exception as e:
            err("TabColorByHost: _watch_terminals exception: %s" % e)
        return True

    def _on_switch_page(self, notebook, page, page_num):
        """Reapply all known colors when the user switches tabs."""
        err("TabColorByHost: switch-page fired, page_num=%d" % page_num)
        try:
            from terminatorlib.terminator import Terminator as Term

            instance = Term()
            for terminal in instance.terminals:
                tid = id(terminal)
                if tid not in self._terminal_colors:
                    continue
                nb = self._get_notebook(terminal)
                if nb is not notebook:
                    continue
                page_index = self._get_page_index(nb, terminal)
                if page_index < 0:
                    continue
                color = self._terminal_colors[tid]
                err("TabColorByHost: switch-page reapply %s to page %d" % (color, page_index))
                _apply_color_to_tab(nb, page_index, color)
        except Exception as e:
            err("TabColorByHost: _on_switch_page error: %s" % e)

    # ------------------------------------------------------------------
    # Title-change handler
    # ------------------------------------------------------------------

    def _on_title_change(self, terminal, title):
        try:
            match = _color_from_title(title)
            if match is not None:
                color, shortname = match
                self._terminal_colors[id(terminal)] = color
                err(
                    "TabColorByHost: stored %s / %s for terminal %d"
                    % (color, shortname, id(terminal))
                )
                notebook = self._get_notebook(terminal)
                if notebook is not None:
                    page_index = self._get_page_index(notebook, terminal)
                    if page_index >= 0:
                        tab_label = notebook.get_tab_label(notebook.get_nth_page(page_index))
                        tab_label.set_custom_label(shortname)
                        _apply_color_to_tab(notebook, page_index, color)
        except Exception as e:
            err("TabColorByHost: _on_title_change error: %s" % e)

    # ------------------------------------------------------------------
    # Helpers to navigate the widget tree
    # ------------------------------------------------------------------
    @staticmethod
    def _get_notebook(terminal):
        widget = terminal.vte
        for i in range(15):
            widget = widget.get_parent()
            if widget is None:
                err("TabColorByHost: ran out of parents after %d steps" % i)
                return None
            err("TabColorByHost: step %d: %s" % (i, type(widget).__name__))
            if isinstance(widget, Gtk.Notebook):
                return widget
            # Terminator's Window — we've gone too far, no notebook exists
            # (single-tab mode: Terminator removes the Notebook entirely)
            if isinstance(widget, Gtk.Window):
                err("TabColorByHost: reached Window without finding Notebook (single tab mode?)")
                return None
        return None

    @staticmethod
    def _get_page_index(notebook, terminal):
        """Return the notebook page index that contains terminal, or -1."""
        for i in range(notebook.get_n_pages()):
            page = notebook.get_nth_page(i)
            if TabColorByHost._widget_contains(page, terminal.vte):
                return i
        return -1

    @staticmethod
    def _widget_contains(parent, target):
        """Recursively check whether target is a descendant of parent."""
        if parent is target:
            return True
        if hasattr(parent, "get_children"):
            for child in parent.get_children():
                if TabColorByHost._widget_contains(child, target):
                    return True
        return False
