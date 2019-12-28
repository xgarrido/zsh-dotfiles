# -*- mode: shell-script; -*-
#
# Copyright (C) 2019 Xavier Garrido
#
# Author: garrido@lal.in2p3.fr
# Keywords: dotfiles manager
# Requirements: pkgtools
# Status: not intended to be distributed yet

# Add completion
fpath=(${ADOTDIR}/bundles/xgarrido/zsh-dotfiles/completions $fpath)

dotfiles_dir=$(dirname $0)

function dotfiles()
{
    pkgtools::default_values
    pkgtools::at_function_enter dotfiles

    local dotfiles_dir=${dotfiles_dir}/dotfiles

    local fcns=(list update install uninstall)

    local mode
    local append_list_of_options_arg

    while [ -n "$1" ]; do
        local token="$1"
        if [ ${token[0,1]} = - ]; then
            local opt=${token}
            if [[ ${opt} = -h || ${opt} = --help ]]; then
                echo "dotfiles [mode]\n"
                echo "Modes can be:"
                echo "list      Show dot files in this repo"
                echo "update    Update for this repo"
                echo "install   Install dot files"
                echo "uninstall Remove the dot files"
                return 0
            elif [[ ${opt} = -d || ${opt} = --debug ]]; then
                pkgtools::msg_using_debug
                append_list_of_options_arg+="${opt} "
            elif [[ ${opt} = -D || ${opt} = --devel ]]; then
                pkgtools::msg_using_devel
                append_list_of_options_arg+="${opt} "
            elif [[ ${opt} = -v || ${opt} = --verbose ]]; then
                pkgtools::msg_using_verbose
                append_list_of_options_arg+="${opt} "
            elif [[ ${opt} = -q || ${opt} = --quiet ]]; then
                pkgtools::msg_using_quiet
            elif [[ ${opt} = -W || ${opt} = --no-warning ]]; then
                pkgtools::msg_not_using_warning
            else
                append_list_of_options_arg+="${opt} "
            fi
        else
            if (( ${fcns[(I)${token}]} )); then
                pkgtools::msg_devel "Mode ${token} exists !"
                mode=${token}
            else
                pkgtools::msg_error "Mode '${token}' does not exist !"
                pkgtools::at_function_exit
                return 1
            fi
        fi
        shift 1
    done
    # Remove last space
    append_list_of_options_arg=${append_list_of_options_arg%?}

    pkgtools::msg_devel "mode=${mode}"
    pkgtools::msg_devel "append_list_of_options_arg=${append_list_of_options_arg}"

    (
        cd ${dotfiles_dir}
        make ${mode}
        if $(pkgtools::last_command_fails); then
            pkgtools::msg_error "The command 'make ${mode} fails!"
            pkgtools::at_function_exit
            return 1
    )

    pkgtools::at_function_exit
    return 0
}
