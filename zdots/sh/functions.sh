#!/bin/bash

### invoked by .zshenv

tellme() {
    ## brew install terminal-notifier
    local msg="NULL"
    if [ $# -ne 0 ]; then
        msg=$1
    fi
    terminal-notifier -title `whoami` -message "$msg"
}

## funny for my kids
wgg() {
    local LOOP=1
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

## Control the pip version in virtualenv
## https://stackoverflow.com/a/58775012
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

## used in export.sh. The order must be kept
uniq_csv() {
    echo "$1" | awk -v RS=':' '!a[$1]++ { if (NR > 1) printf RS; printf $1 }'
    # awk '!seen[$0]++' # deduplicate lines and keep the order
}

# ## used as alias. upgrade to using fd
# ff () {
#     if [ $# -eq 0 ]; then
#         find . -type f 2> /dev/null
#     else
#         find . -type f \( $(printf '! -name %q -o ' "$@") -false \) 2> /dev/null
#     fi
# }
fid() {
  if [ $# -ne 2 ]; then
    echo "grep <search-string> [<directory-name>]/* Usage: fid <directory-name> <search-string>"
    return 1
  fi
  # fd -t d remote -x rg --color=always -n 'WithdrawEntrust' {}
  fd -t d "$1" -x rg --color=always -n "$2" {}
}

mysqlc() {
    mysql_config_editor print --all | awk '
/^\[/ {
    if (section != "" && host != "") {
        port = (port == "") ? "3306" : port
        gsub(/^\[/, "", section)
        gsub(/\]$/, "", section)
        printf "%s|addr=\"%s:%s\"|user=\"%s\"\n", section, host, port, user
    }
    section=$0
    user=host=port=""
    next
}

/user *=/ {
    split($0, a, "=")
    user=a[2]
    gsub(/[" ]/, "", user)
}
/host *=/ {
    split($0, a, "=")
    host=a[2]
    gsub(/[" ]/, "", host)
}
/port *=/ {
    split($0, a, "=")
    port=a[2]
    gsub(/[" ]/, "", port)
}

END {
    if (section != "" && host != "") {
        port = (port == "") ? "3306" : port
        gsub(/^\[/, "", section)
        gsub(/\]$/, "", section)
        printf "%s|addr=\"%s:%s\"|user=\"%s\"\n", section, host, port, user
    }
}
' | sort | awk -F'\\|' '
BEGIN {
    colors[0]  = "\033[1;34m"  # bright red
    colors[1] = "\033[1;32m"   # bright gray
    colors[2]  = "\033[1;33m"  # bright yellow
    colors[3]  = "\033[1;31m"  # bright blue
    colors[4]  = "\033[1;35m"  # bright magenta
    colors[5]  = "\033[1;36m"  # bright cyan
    colors[6]  = "\033[0;31m"  # red
    colors[7] = "\033[1;94m"   # bright light blue
    colors[8]  = "\033[0;33m"  # yellow
    colors[9]  = "\033[0;34m"  # blue
    colors[10] = "\033[0;35m"  # magenta
    colors[11] = "\033[0;36m"  # cyan

    defaultColor = "\033[0m"
    valColor = "\033[1;90m"
    reset = "\033[0m"
}
{
    sectionName = $1
    split(sectionName, parts, ".")
    prefix = (length(parts) > 1) ? parts[1] : "_no_prefix_"

    if (!(prefix in prefixColorMap)) {
        prefixColorMap[prefix] = (prefix == "_no_prefix_") ? defaultColor : colors[colorIndex++ % length(colors)]
    }

    color = prefixColorMap[prefix]
    section = "[" color sectionName reset "]"

    gsub(/addr=/, valColor "addr=" reset)
    gsub(/user=/, valColor "user=" reset)

    print section "\t" $2 ",\t" $3
}
'
}


# lsofx - 按命令行匹配进程，递归收集所有后代，用 lsof 查看它们的资源
# 用法: lsofx <进程匹配> [lsof 参数...]
#   lsofx "go run"                     # 全部资源
#   lsofx "go run" -i                  # 只看网络
#   lsofx "go run" -iTCP -sTCP:LISTEN  # 只看监听 TCP
lsofx() {
  if [ $# -lt 1 ]; then
    cat <<'USAGE'
用法: lsofx <进程匹配> [lsof 参数...]

示例:
  lsofx "go run"
  lsofx "go run" -i
  lsofx "go run" -iTCP -sTCP:LISTEN
  lsofx nginx -iUDP
USAGE
    return 1
  fi

  local pattern=$1
  shift

  # 递归收集一个 PID 及其所有后代
  local gather
  gather() {
    echo "$1"
    local c
    for c in $(pgrep -P "$1" 2>/dev/null); do
      gather "$c"
    done
  }

  # 找根进程，过滤掉自身 / pgrep / lsofx
  local self=$$ roots="" p args
  while read -r p; do
    [ -z "$p" ] && continue
    [ "$p" = "$self" ] && continue
    args=$(ps -p "$p" -o args= 2>/dev/null) || continue
    case "$args" in
      *lsofx*|*pgrep*) continue ;;
    esac
    roots="$roots $p"
  done < <(pgrep -f "$pattern" 2>/dev/null)

  roots=$(echo $roots | tr ' ' '\n' | sort -un)

  if [ -z "$roots" ]; then
    echo "lsofx: 没有匹配 '$pattern' 的进程" >&2
    return 1
  fi

  # 收集所有 PID（含后代），拼成逗号列表
  local pids
  pids=$(
    local r
    for r in $roots; do
      gather "$r"
    done | sort -un | paste -sd, -
  )

  # 进程树打到 stderr，便于对照
  echo "lsofx: 匹配到的进程树 (PID PPID ARGS):" >&2
  ps -o pid,ppid,args -p "$pids" 2>/dev/null >&2
  echo >&2

  # 调用 lsof
  sudo lsof -nP -a -p "$pids" "$@"
}
