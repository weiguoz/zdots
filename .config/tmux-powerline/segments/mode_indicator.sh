#!/usr/bin/env bash

prefix_icon=${TMUX_MODE_INDICATOR_PREFIX_ICON:-"Ω"}
copy_icon=${TMUX_MODE_INDICATOR_COPY_ICON:-"📋"}

run_segment() {
    local pane_id=$(tmux display-message -p "#{pane_id}")
    local in_copy_mode=$(tmux list-panes -F "#{pane_id} #{pane_in_mode}" | grep "^$pane_id 1")
    local prefix_flag=$(tmux display -p "#{client_prefix}")

    if [[ -n "$in_copy_mode" ]]; then
        echo "#[fg=white]${copy_icon}"
    elif [[ "$prefix_flag" == "1" ]]; then
        echo "#[fg=yellow]${prefix_icon}"
    fi
    return 0
}
