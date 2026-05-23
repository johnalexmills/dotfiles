#!/usr/bin/env bash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/waybar-caffeine"

if [[ "$1" == "--toggle" ]]; then
    if [[ -f "$STATE_FILE" ]]; then
        rm "$STATE_FILE"
        killall -s CONT hypridle 2>/dev/null || hypridle &
    else
        touch "$STATE_FILE"
        killall -s STOP hypridle 2>/dev/null || true
    fi
fi

if [[ -f "$STATE_FILE" ]]; then
    echo '{"text": " ", "class": "on", "tooltip": "Idle inhibit ON"}'
else
    echo '{"text": " ", "class": "off", "tooltip": "Idle inhibit OFF"}'
fi
