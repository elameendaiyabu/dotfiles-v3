#!/usr/bin/env bash
STATE_FILE="/tmp/i3-zen-state"

if [ -f "$STATE_FILE" ]; then
    # Restore
    polybar-msg cmd toggle
    i3-msg "gaps inner all set 10; gaps outer all set 8; gaps top all set 36"
    rm "$STATE_FILE"
else
    # Zen mode
    polybar-msg cmd toggle
    i3-msg "gaps inner all set 0; gaps outer all set 0; gaps top all set 0"
    touch "$STATE_FILE"
fi
