#!/usr/bin/env bash
# wifi-popup — wifitui in a centered floating kitty window (toggle).
if xdotool search --class '^wifi-popup$' >/dev/null 2>&1; then
	i3-msg -q '[class="^wifi-popup$"] kill'
	exit 0
fi
exec kitty --class wifi-popup --title "Wi-Fi" \
	-o background_opacity=0.97 -o window_padding_width=16 -o confirm_os_window_close=0 \
	-e "$HOME/.cargo/bin/wifitui"
