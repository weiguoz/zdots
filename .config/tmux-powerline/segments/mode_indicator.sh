#!/usr/bin/env bash

run_segment() {
    local pane_id=$(tmux display-message -p "#{pane_id}")
    local in_copy_mode=$(tmux list-panes -F "#{pane_id} #{pane_in_mode}" | grep "^$pane_id 1")
    local prefix_flag=$(tmux display -p "#{client_prefix}")

    if [[ -n "$in_copy_mode" ]]; then
        echo "#[fg=red]ℰ"
    elif [[ "$prefix_flag" == "1" ]]; then
        echo "#[fg=yellow]Ω"
    else
        echo "#[fg=green]ℕ"
    fi
    return 0
}
