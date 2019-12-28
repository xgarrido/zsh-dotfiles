# -*- mode: shell-script; -*-
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# if [ -f /etc/profile ]; then
#     source /etc/profile
# fi
# # Source global definitions
# if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
# fi

# # bash completion definitions
# if [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
# fi

if [ "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

function generate_256color_palette ()
{
    for f in `seq 0 255`; do
        echo -e  "\e[38;5;${f}m$f Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
    done
}

function get_color ()
{
    if [ "$TERM" != "xterm-256color" ]; then
        echo "Terminal does not support 256 colors !"
        return
    fi

    if [ "$1" == "" ]; then
        echo "Missing color value in [0:255] range"
        return
    else
        echo '\033[m\033[38;5;'$1'm'
    fi

}


function set_prompt_color ()
{
    # for 16 colors terminal
    local txtblk='\033[m\033[0;30m' # Black - Regular
    local txtred='\033[m\033[0;31m' # Red
    local txtgrn='\033[m\033[0;32m' # Green
    local txtylw='\033[m\033[0;33m' # Yellow
    local txtblu='\033[m\033[0;34m' # Blue
    local txtpur='\033[m\033[0;35m' # Purple
    local txtcyn='\033[m\033[0;36m' # Cyan
    local txtwht='\033[m\033[0;37m' # White
    local bldblk='\033[m\033[1;30m' # Black - Bold
    local bldred='\033[m\033[1;31m' # Red
    local bldgrn='\033[m\033[1;32m' # Green
    local bldylw='\033[m\033[1;33m' # Yellow
    local bldblu='\033[m\033[1;34m' # Blue
    local bldpur='\033[m\033[1;35m' # Purple
    local bldcyn='\033[m\033[1;36m' # Cyan
    local bldwht='\033[m\033[1;37m' # White
    local unkblk='\033[m\033[4;30m' # Black - Underline
    local undred='\033[m\033[4;31m' # Red
    local undgrn='\033[m\033[4;32m' # Green
    local undylw='\033[m\033[4;33m' # Yellow
    local undblu='\033[m\033[4;34m' # Blue
    local undpur='\033[m\033[4;35m' # Purple
    local undcyn='\033[m\033[4;36m' # Cyan
    local undwht='\033[m\033[4;37m' # White
    local bakblk='\033[m\033[40m'   # Black - Background
    local bakred='\033[m\033[41m'   # Red
    local badgrn='\033[m\033[42m'   # Green
    local bakylw='\033[m\033[43m'   # Yellow
    local bakblu='\033[m\033[44m'   # Blue
    local bakpur='\033[m\033[45m'   # Purple
    local bakcyn='\033[m\033[46m'   # Cyan
    local bakwht='\033[m\033[47m'   # White
    local txtrst='\033[m\033[00m'   # Text Reset

    case "$HOSTNAME" in
        r17187.ovh.net)
            PS1='\[\033[01;36m\]\t \[\033[00m\]\[\033[01;32m\]\w\[\033[00m\]\n$ '
            ;;
        nemo*.lal.in2p3.fr|lx3.lal.in2p3.fr|auger*.lal.in2p3.fr)
            PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]\n\$ '
            ;;
        lxplus*.cern.ch)
            PS1='\[\033[01;33m\]\u@\h\[\033[00m\] \[\033[01;36m\]\w\[\033[00m\]\n\$ '
            ;;
        mac-garrido)
            PS1="${bldpur}\t ${bldblu}\w${txtrst}\n$ "
            ;;
        garrido-laptop)
            if [ "$TERM" != "xterm-256color" ]; then
                PS1="${txtred}\t ${txtpur}\w${txtrst}\n$ "
            else
                PS1="`get_color 2`\t `get_color 3`\w\033[m\n$ "
            fi
            ;;
        pc-91089)
            if [ "$TERM" != "xterm-256color" ]; then
                PS1="${bldred}\t ${bldpur}\w${txtrst}\n$ "
            else
                PS1="`get_color 88`\t `get_color 208`\w\033[m\n$ "
            fi
            ;;
	SynoServer)
            PS1="${bldred}\t ${bldcyn}\h ${bldpur}\w${txtrst}\n$ "
	    ;;
        ccige*)
            PS1="${bldred}\t ${bldblue}\h ${bldpur}\w${txtrst}\n$ "
            ;;
        *)
            PS1="${bldred}\t ${bldpur}\w${txtrst}\n$ "
    esac

}

### Emacs daemon stuff
function run_emacs_daemon ()
{
    pid=$(ps -edf | grep garrido | grep emacs| grep daemon | gawk '{print $2}')
    if [ "${pid}" == "" ]; then
        emacs --daemon > /dev/null 2>&1
    fi
}

function relaunch_emacs_daemon ()
{
    pid=$(ps -edf | grep garrido | grep emacs| grep daemon | gawk '{print $2}')
    if [ "${pid}" != "" ]; then
        kill -9 ${pid}
    fi

    run_emacs_daemon
}
###

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

## shopt options
shopt -s checkwinsize   # check the window size after each command and, if necessary,
                        # update the values of LINES and COLUMNS.
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite
shopt -s dotglob        # files beginning with . to be returned
                        # in the results of path-name expansion.
shopt -s nocaseglob     # directories are case insensitive
shopt -s extglob        # Programmable completion : see
                        # http://stackoverflow.com/questions/216995/how-can-i-use-negative-wildcards-in-a-unix-linux-shell
complete -cf sudo       # Tab complete for sudo

# History option
# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
export HISTCONTROL=erasedups
export HISTSIZE=10000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
set_prompt_color

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    if [ "$HOSTNAME" == "mac-garrido" ]; then
        alias ls='ls -G'
    else
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
    fi
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# User functions
#===============
# EVO meeting using koala app
function koala ()
{
    /usr/lib/jvm/java-6-sun-1.6.0.24/bin/javaws /home/garrido/.KoalaNext/koala.jnlp
}
# Connection to LAL machines
function connect ()
{
    if [ "$1" == "" ]; then
	echo "Missing the name of machine to connect !"
        echo ""
        echo "Machines can be :"
        echo "       fzk : FZK machines (deprecated)"
        echo "      cern : CERN machines"
        echo "      lyon : CC Lyon"
        echo "       ovh : OVH server (thanks to Jérémie )"
        echo "        pc : PC @ LAL"
        echo "    laptop : Laptop @ LAL"
        echo "       mac : Mac @ home"
        echo "      syno : Synology @ home"
        echo "    debian : Debian @ home"
        echo ""
        echo " Nemo computers :"
        echo "     nemo* : nemo machines"
        echo "  daq-nemo : DAQ pc-nemo12 (salle blanche)"
        echo "   daq-lsm : DAQ lsmlx5 (interface computer @ Modane)"
        echo ""
        echo " LAL/Auger computers :"
        echo " lx*, auger* ... : connect to LAL machine"
        echo ""
    elif [ "$1" == "fzk" ]; then
        ssh -Y -p 24 augerlogin.fzk.de
    elif [ "$1" == "cern" ]; then
	ssh -Y xgarrido@lxplus.cern.ch
    elif [ "$1" == "lyon" ]; then
        ssh -Y garrido@ccige.in2p3.fr
    elif [[ $1 == ccige* ]]; then
        ssh -Y garrido@$1.in2p3.fr
    elif [[ $1 == ccage* ]]; then
        ssh -Y garrido@$1.in2p3.fr
   elif [ "$1" == "ovh" ]; then
        ssh -Y -p 1234 garrido@r17187.ovh.net
    elif [ "$1" == "pc" ]; then
        ssh -Y garrido@pc-91089.lal.in2p3.fr
    elif [ "$1" == "laptop" ]; then
        ssh -Y garrido@nb-76121.lal.in2p3.fr
    elif [ "$1" == "mac" ]; then
        ssh -Y -p 24 garrido@xgarrido.dyndns.org
    elif [ "$1" == "syno" ]; then
        echo "Connecting via telnet ..."
        telnet -l garrido xgarrido.dyndns.org
    elif [ "$1" == "debian" ]; then
        ssh -Y debian@xgarrido.dyndns.org
    elif [ "$1" == "daq-nemo" ]; then
        ssh -Y bipolal@pc-nemo12.lal.in2p3.fr
    elif [ "$1" == "daq-lsm" ]; then
        ssh -Y nemoacq@lsmlx5.in2p3.fr
    else
	ssh -Y $1.lal.in2p3.fr
    fi
}

# google translate
function translate ()
{
    if [ "$1" == "" ]; then
        echo "Missing argument !!"
        echo " translate \"<phrase>\" <source-langage> <output-langage>"
        echo " example : translate \"Hello my friend\" en fr => Bonjour mon ami"
        echo " see http://en.wikipedia.org/wiki/List_of_ISO_639-1_codes for code language"
    else
        wget -qO- "http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=$1&langpair=$2|${3:-en}" | sed 's/.*"translatedText":"\([^"]*\)".*}/\1\n/';
    fi
}


# mount with sshfs remote disk
function mountDisk ()
{
    if [ "$1" == "" ]; then
        echo "Missing the name of the remote disk !"
    elif [ "$1" == "auger" ]; then
        if [ -d /tmp/auger ]; then
            fusermount -u /tmp/auger
            rm -rf /tmp/auger
        fi
        mkdir /tmp/auger
        echo "sshfs garrido@lx3.lal.in2p3.fr:/exp/auger/xavier /tmp/auger"
        sshfs garrido@lx3.lal.in2p3.fr:/exp/auger/xavier /tmp/auger
    fi
}

function umountDisk ()
{
    if [ "$1" == "" ]; then
        echo "Missing the name of the remote disk !"
    elif [ "$1" == "auger" ]; then
        echo "fusermount -u /tmp/auger"
        fusermount -u /tmp/auger
        rm -rf /tmp/auger
    fi
}

# Dexter java applet
function dexter ()
{
    if [ "$1" == "" ]; then
	echo "Missing the name of image file !"
    else
	java -jar /home/garrido/Workdir/Development/java/dexter/Debuxter.jar $1
    fi
}

# # obsolete !!
# # Jaxodraw java applet
# jaxodraw(){
#     java -jar /home/garrido/Workdir/Development/java/jaxodraw/current/jaxodraw-1.3-2.jar
# }

# # Jabref java applet for bibliography
# jabref(){
#     java -jar /home/garrido/Workdir/Development/java/jabref/current/JabRef-2.2.jar
# }

# Print manual page of command
# this use mpage command to put the result in 2 columns
# if it doesn't exist use the ps2ps command
function man2ps ()
{
    if [ "$1" == "" ]; then
	echo "Missing the name of the command !"
    else
	man -t $1 | mpage -bA4 -f -2 > $1.ps
    fi
}
function man2pdf ()
{
    if [ "$1" == "" ]; then
	echo "Missing the name of the command !"
    else
	man -t $1 | mpage -bA4 -f -2 > $1.ps && ps2pdf $1.ps $1.pdf && rm -f $1.ps
    fi
}

# Print ps -edf command
# for a defined program
# nothing more than ps -edf | grep $1
function psgrep ()
{
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

function hgrep ()
{
    if [ ! -z $1 ] ; then
        echo "Grepping for command matching $1..."
        history | grep $1
    else
        echo "!! Need name to grep for"
    fi
}

function extract ()
{
    if [ -f "$1" ] ; then
        case "$1" in
            *.tar.bz2) tar xjvf "$1";;
            *.tar.gz)  tar xzvf "$1";;
            *.bz2)     bunzip2 "$1";;
            *.rar)     rar x "$1";;
            *.gz)      gunzip "$1";;
            *.tar)     tar xvf "$1";;
            *.tbz2)    tar xjvf "$1";;
            *.tgz)     tar xzvf "$1";;
            *.zip)     unzip "$1";;
            *.Z)       uncompress "$1";;
            *.jar)     jar xf "$1";;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


# bash calculator
function calc ()
{
    echo "$*" | bc -l;
}

# remove trailing whitespace for a given file
function remove_trailing_whitespace ()
{
    if [ "$1" == "" ]; then
	echo "Missing the directory !"
    else
        find $1 -type f -exec sed -i 's/ *$//' '{}' ';'
    fi
}

# grab video from mms link
function grab_video ()
{
    if [ ! -z $1 ] ; then
        echo "Grabing video from $1 link and saving it to /tmp/dump_video.avi..."
        mplayer -dumpstream $1 -dumpfile /tmp/dump_video.avi
    else
        echo "!! Need mms link"
    fi
}

# wake pc through LAN
function wake ()
{
  wakeonlan 00:14:22:2e:dc:9c
}

function shutdown_pc ()
{
  sudo shutdown -h now
}
#=======================================================================

# Aliases
alias ll='ls -ltrh'
alias la='ls -rtha'
alias lsd='ls -l | grep ^d'
alias tx='LANG=de_DE.ISO-8859-15 nedit'
alias root='root -l'
alias cl='clear'
alias h='history'
alias vi='vim'
alias grep='grep --color=auto'
alias ack='ack-grep'
alias gv='gv -noantialias'

alias ve='\emacs -nw'

export PAGER=less
export SVN_EDITOR='\emacs -nw'

linux_distrib=$(cat /etc/issue | cut -d' ' -f1)

if [ "${linux_distrib}" == "Ubuntu" -o "${linux_distrib}" == "Debian" ];then
    apt_fast_cmd="apt-get"
    if [ -f /usr/bin/apt-fast ]; then
        apt_fast_cmd="apt-fast"
    fi
    alias install='sudo ${apt_fast_cmd} -y install'
    alias search='apt-cache search'
    alias purge='sudo ${apt_fast_cmd} purge'
    alias upgrade='sudo ${apt_fast_cmd} update && sudo ${apt_fast_cmd} upgrade'
    alias distupgrade='sudo ${apt_fast_cmd} update && sudo ${apt_fast_cmd} dist-upgrade'
    alias remove='sudo apt-get remove'
    alias autoremove='sudo apt-get autoremove'
fi

#=======================================================================
# function do_nemo_setup ()
# {
#     local tmp_file_name=/tmp/bash.log
#     if [ -f ${tmp_file_name} ]; then
#         rm ${tmp_file_name}
#     fi

#     local set_tools=
#     local set_notification=
#     local nemo_base_dir=
#     case "$HOSTNAME" in
#         pc-91089)
#             nemo_base_dir="/data/workdir/nemo/development"
#             set_tools=0
#             set_notification=0
#             ;;
#         garrido-laptop)
#             nemo_base_dir="/home/garrido/Workdir/NEMO/development"
#             set_tools=1
#             set_notification=1
#             ;;
#         lx3.lal.in2p3.fr|nemo*.lal.in2p3.fr)
#             nemo_base_dir="/exp/nemo/snsw"
#             set_tools=0
#             set_notification=0
#             ;;
#         *)
#             ;;
#     esac

#     #********************************************************************************
#     if [ ${set_tools} -eq 1 ]; then
#         local nemo_tool_base_dir=/home/garrido/Workdir/NEMO/tools

#         # pkgtools
#         source ${nemo_tool_base_dir}/pkgtools/pkgtools.sh

#         # MakePackage
#         export MAKEPACKAGE_INSTALL_PREFIX=${nemo_tool_base_dir}/make_package/install
#         export PATH=${MAKEPACKAGE_INSTALL_PREFIX}/bin:${PATH}
#         source ${MAKEPACKAGE_INSTALL_PREFIX}/etc/make_package.conf

#         # MakeMemo
#         export MAKEMEMO_ROOT=${nemo_tool_base_dir}/make_memo/trunk
#         export PATH=${MAKEMEMO_ROOT}/scripts:${PATH}
#     fi
#     #********************************************************************************

#     if [ "x${nemo_base_dir}" != "x" ]; then
#         # CMake package
#         local cadfael_version=""
#         local bayeux_version="trunk"
#         local falaise_version="trunk"

#         local cadfael_setup_file="${nemo_base_dir}/cadfael/install/${cadfael_version}/etc/cadfael_setup.sh"
#         local bayeux_setup_file="${nemo_base_dir}/bayeux/install/${bayeux_version}/etc/bayeux_setup.sh"
#         local falaise_setup_file="${nemo_base_dir}/falaise/install/${falaise_version}/etc/falaise_setup.sh"

#         # Non integrated package
#         local channel_version="trunk"
#         local trackfit_setup_file="${nemo_base_dir}/channel/install/${channel_version}/etc/trackfit_setup.sh"

#         source ${cadfael_setup_file}  >> ${tmp_file_name} 2>&1 && do_cadfael_all_setup >> ${tmp_file_name} 2>&1
#         source ${bayeux_setup_file}   >> ${tmp_file_name} 2>&1 && do_bayeux_all_setup  >> ${tmp_file_name} 2>&1
#         source ${falaise_setup_file}  >> ${tmp_file_name} 2>&1 && do_falaise_all_setup >> ${tmp_file_name} 2>&1
#         source ${trackfit_setup_file} >> ${tmp_file_name} 2>&1 && do_trackfit_setup    >> ${tmp_file_name} 2>&1

#         # Grep errors
#         local loading_error=$(cat ${tmp_file_name} | grep ERROR:)

#         if [ "x${loading_error}" != "x" ]; then
#             echo "${loading_error}"
#             return 1
#         fi

#         # Add additionnal env variable
#         export CADFAEL_SRC_DIR=${nemo_base_dir}/cadfael/build/${cadfael_version}/Source
#         export BAYEUX_SRC_DIR=${nemo_base_dir}/bayeux/build/${bayeux_version}/Source
#         export FALAISE_SRC_DIR=${nemo_base_dir}/falaise/build/${falaise_version}/Source
#         export CHANNEL_SRC_DIR=${nemo_base_dir}/channel/build/Source
#     fi
#     #********************************************************************************

#     # Use gnome notification system
#     if [ ${set_notification} = 0 ]; then
#         return 0
#     fi

#     if [ -f ${tmp_file_name} ]; then
#         notify-send -t 2000 -i bash "SuperNEMO settings:" \
#             "`cat ${tmp_file_name} | grep "Sourcing" | awk '{print $3,$4,$5,$6,$7}'`"
#     fi

#     return 0
# }
#=======================================================================

case "$HOSTNAME" in
    garrido-laptop|pc-91089)
        # Load RVM function (Ruby manager)
        #[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

        # specific aliases
        alias open='gnome-open'
        alias preview='gloobus-preview'
        alias mplayer='gnome-mplayer'
        alias emacs='emacsclient -c -n'

        # set HOST
        export HOST=${HOSTNAME}
        # search proxies (quite obsolete ...)
        setting_proxy=0
        if [ ${setting_proxy} = 1 ]; then
            DOMAIN=`cat /etc/resolv.conf | grep domain | awk '{print $2}'`
            SUBDOMAIN=`echo $DOMAIN | sed 's/ka/proxy/'`
            if [ "$DOMAIN" == "auger.org.ar" ] ; then
                export http_proxy=http://proxy.$DOMAIN:8080
                export ftp_proxy=http://proxy.$DOMAIN:8080
            elif [ "$SUBDOMAIN" == "proxy.fzk.de" ]; then
                export http_proxy=http://$SUBDOMAIN:8000
                export ftp_proxy=http://$SUBDOMAIN:8000
            else
                http_proxy="no proxy found !"
            fi
        fi

        # env. variables
        # export CDPATH=$HOME:$HOME/Workdir:$HOME/Workdir/NEMO:$HOME/Teachdir
        export WORKDIR=~/Workdir

        set_idl=0
        set_na61=0
        set_nemo=0
        set_pao=0
        set_pao_simu=0
        set_cflag=0
        set_ccache=0

        set_notification=1
        if [ "x${HOSTNAME}" == "xpc-91089" ]; then
            set_notification=0
        fi

        tmp_file_name=/tmp/bash.log

        if [ ${set_idl} = 1 ]; then
            . $WORKDIR/PAO/DPA/External/IDL/idlenv
        fi

        if [ ${set_na61} = 1 ]; then
            . $WORKDIR/NA61/na61env
        fi

        if [ ${set_nemo} = 1 ]; then
            . $WORKDIR/NEMO/nemo.sh > ${tmp_file_name} 2>&1
        fi

        if [ ${set_pao} = 1 ]; then
            . $WORKDIR/PAO/DPA/adm/userenv
        fi

        if [ ${set_pao_simu} = 1 ]; then
            . $WORKDIR/Simulation/adm/userenv
        fi

        if [ ${set_cflag} = 1 ]; then
            . $WORKDIR/PAO/DPA/adm/cflagenv
        fi

        if [ ${set_ccache} = 1 ]; then
            . $WORKDIR/PAO/DPA/adm/ccacheenv
        fi

        if [ ${set_notification} = 1 ]; then
            if [ -f ${tmp_file_name} ]; then
                info=`echo -e "Proxy settings : ${http_proxy}\n Env. settings : NEMO set"`
                notify-send -t 1000 -i bash "Session settings:" \
                     "`cat ${tmp_file_name} | grep "Package" | awk '{print $2,$3,$4") set up"}'`"
                rm -f /tmp/bash.log
            fi
        fi

        # run emacs daemon in case it is not already running
	#run_emacs_daemon

        if [ "$TERM" != "/bin/zsh" ]; then
            # run zshell
            zsh
        fi
        ;;

    lx3.lal.in2p3.fr|nemo*.lal.in2p3.fr)
        umask 022
        export WORKDIR=/exp/nemo/garrido
        export PATH=/exp/nemo/garrido/software/bin:/exp/nemo/install/bin:${PATH}
        # Add TeXLive 2011
        export PATH=/exp/nemo/garrido/software/texlive/2011/bin/x86_64-linux:${PATH}
        unset TEXMFCNF
        unset TETEXDIR
        export LD_LIBRARY_PATH=/exp/nemo/garrido/software/lib:/exp/nemo/install/lib:${LD_LIBRARY_PATH}

        if [ "$HOSTNAME" != "lx3.lal.in2p3.fr" ]; then
            export SW_BASE_DIR=/scratch/garrido/sw
            source ${SW_BASE_DIR}/pkgtools/trunk/pkgtools.sh

            source ${SW_BASE_DIR}/nemo_core_sw.sh
            source ${SW_BASE_DIR}/nemo_base_sw.sh
            source ${SW_BASE_DIR}/nemo_snemo_sw.sh
            # do_nemo_core_sw_setup
            # do_nemo_base_sw_setup trunk
            # do_nemo_snemo_sw_setup trunk
        fi
        ;;
    auger*.lal.in2p3.fr)
        umask 022
        export WORDKDIR=/exp/auger/xavier
        # DPA Variables
        # . $AUGERDIR/workdir/PAO/DPA/adm/userenv
        # CFLAG env
        #. $AUGERDIR/Workdir/PAO/DPA/adm/cflagenv
        ;;
    mac-garrido)
        # add Mac ports binaries
        export PATH=$PATH:/opt/local/bin
        ;;
    ccige*|ccage*)
        export PATH=~/Development/zsh/bin:$PATH
        # obsolete
        # source ${GROUP_DIR}/sw/pkgtools/trunk/pkgtools.sh

        # export SW_BASE_DIR=${GROUP_DIR}/sw
        # source ${SW_BASE_DIR}/nemo_basics_sw.sh
        # source ${SW_BASE_DIR}/nemo_core_sw.sh
        # source ${SW_BASE_DIR}/nemo_base_sw.sh
        # source ${SW_BASE_DIR}/nemo_snemo_sw.sh
        # do_nemo_basics_sw_setup
        # do_nemo_core_sw_setup
        # do_nemo_base_sw_setup trunk
        # do_nemo_snemo_sw_setup trunk
	;;
    SynoServer)
        ;;
    *)
        ;;
esac

# end of .bashrc
