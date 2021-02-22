#!/bin/bash

### invoked by .zshenv

solrversion2date() {
    if [ $# -eq 1 ]; then
        date -r `expr $1 / 1024 / 1024 / 1000`
    fi
}

cs() {
    builtin cd "$1" && ls -lh
}

tellme() {
    # brew install terminal-notifier
    msg="NULL"
    if [ $# -ne 0 ]; then
        msg=$1
    fi
    terminal-notifier -title "weiguo" -message "$msg"
}

# funny for my little son
wgg() {
    LOOP=1
    if [ $# -gt 0 ]; then
        LOOP=$1
    fi
    while [ ${LOOP} -gt 0 ]; do
        sl -a
        sl -l
        sl -F
        sl -c
        LOOP=$[${LOOP}-1]
    done
}

pc() {
    pc_usage() { echo "pc -p {pane} -c {command}" >&2; }

    local OPTIND
    while getopts ":p:c:" opt; do
        case "${opt}" in
            p ) # pane
                p="$OPTARG"
                ;;
            c )
                c="$OPTARG"
                ;;
            \? )
                echo "Invalid option: -$OPTARG" >&2
                ;;
            : )
                pc_usage
        esac
    done
    shift $((OPTIND-1))

    if [ -z "$p" -o -z "$c" ]; then
        pc_usage
    else
        tmux send-keys -t$p "$c" enter
    fi
}

# Control the pip version in virtualenv
# https://stackoverflow.com/a/58775012
ve() {
    local py="python3"
    if [ ! -d ./.venv ]; then
        echo "creating venv..."
        if ! $py -m venv .venv --prompt=$(basename $PWD) --without-pip; then
            echo "ERROR: Problem creating venv" >&2
            return 1
        else
            local whl=$($py -c "import pathlib, ensurepip; [whl] = pathlib.Path(ensurepip.__path__[0]).glob('_bundled/pip*.whl'); print(whl)")
            echo "boostrapping pip using $whl"
            .venv/bin/python $whl/pip install --upgrade pip setuptools wheel
            source .venv/bin/activate
        fi
    else
        source .venv/bin/activate
    fi
}
