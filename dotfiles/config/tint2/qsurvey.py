#!/usr/bin/env python
import os
import subprocess
import tempfile

import yaml

cwd = os.path.dirname(os.path.realpath(__file__))


def send_notification(msg):
    cmd = f"notify-send -i gnome-todo 'qsurvey' '{msg}'"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, check=True)


def parse_squeue(result):
    r, qw = 0, 0
    for line in result:
        fields = line.strip().split()
        if fields[4] == "R":
            r += 1
        elif "PD" in fields[4]:
            qw += 1
    return r, qw, r + qw


def parse_condor(result):
    r, qw = 0, 0
    status_map = {
        1: "Idle",
        2: "Running",
        3: "Removed",
        4: "Completed",
        5: "Held",
        6: "Transferring",
        7: "Suspended",
    }
    for status in result:
        try:
            status = int(status)
        except:
            continue
        if status == 2:
            r += 1
        elif status in [1, 5]:
            qw += 1
    return r, qw, r + qw


def main():
    with open(os.path.join(cwd, "servers.yml")) as f:
        servers = yaml.safe_load(f)

    servers = {
        "livingston": {
            "machine": "ldas-grid.ligo-la.caltech.edu",
            "login": "xavier.garrido",
            "cmd": "condor_q -autoformat JobStatus",
        }
    }

    summary = []
    for server, meta in servers.items():
        cmd = "ssh {login}@{machine} {cmd}".format(**meta)
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, check=True)
        if not result:
            continue

        function = parse_squeue if "squeue" in meta.get("cmd") else parse_condor
        r, qw, total = function(result.stdout)
        new_state = f"{r}/{qw}/{total - r - qw}"
        meta.update(running=r, idle=qw, total=total, state=new_state)

        log_file = os.path.join(tempfile.gettempdir(), f"qsurvey_{server}.log")
        old_state = "0/0/0"
        if os.path.exists(log_file):
            old_state = open(log_file).read()

        # Write state in tmp file
        with open(log_file, "w") as f:
            f.write(new_state)

        # Send notification
        if old_state != new_state:
            old = old_state.split("/")
            new = new_state.split("/")
            if old[0] < new[0]:
                send_notification(f"{new[0] - old[0]} jobs started @ {server}")
            if old[0] > new[0]:
                send_notification(f"{old[0]- new[0]} jobs stopped @ {server}")
            if new[1] > 0:
                send_notification(f"{new[1]} jobs currently waiting @ {server}")

        if total:
            summary += [f"{server}\n{new_state}"]

    if summary:
        icon_path = os.path.join(cwd, "qsurvey.svg")
        print(icon_path)
        print(" | ".join(summary))


if __name__ == "__main__":
    main()
