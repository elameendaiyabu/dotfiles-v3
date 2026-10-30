#!/usr/bin/env bash
# clipboard-menu — themed rofi front-end for clipcat history.
#
#   Enter          paste into the focused window (copy only if xdotool is missing)
#   Alt+Enter      copy only
#   Shift+Delete   delete entry
#   Alt+e          edit entry in nvim
#   Alt+p          open image entry in a viewer
#   Alt+x          clear all history
#
#   clipboard-menu.sh --toggle   pause / resume recording (incognito)
#   clipboard-menu.sh --status   icon for polybar
set -uo pipefail

theme="$HOME/.config/rofi/clipmenu.rasi"

case "${1:-}" in
--toggle)
	clipcatctl toggle-watcher >/dev/null
	if clipcatctl get-watcher-state | grep -q 'is watching'; then
		notify-send -a clipboard -i edit-paste "Clipboard" "Recording resumed"
	else
		notify-send -a clipboard -i edit-paste "Clipboard" "Recording paused — copies won't be saved"
	fi
	exit 0
	;;
--status)
	muted=$(awk -F' = ' '$1=="muted"{print $2}' "$HOME/.config/themes/current/polybar.ini" 2>/dev/null)
	if clipcatctl get-watcher-state 2>/dev/null | grep -q 'is watching'; then echo "󰅍"; else echo "%{F${muted:-#888888}}󰅛%{F-}"; fi
	exit 0
	;;
esac

# pretty one-line label for a clip preview
label() {
	local text=$1
	if [[ $text =~ ^\[image/([a-z]+)\ ([0-9.]+\ [KMG]?i?B)\ ([0-9-]+)T([0-9]{2}:[0-9]{2}) ]]; then
		printf '󰋩  Image · %s · %s · %s' "${BASH_REMATCH[1]^^}" "${BASH_REMATCH[2]}" "${BASH_REMATCH[4]}"
		return
	fi
	local icon="󰅍"
	if [[ $text =~ ^(https?|ftp|chrome|file)://[^[:space:]]+$ ]]; then icon="󰖟"
	elif [[ $text =~ ^#[0-9a-fA-F]{3,8}$ ]]; then icon="󰏘"
	elif [[ $text =~ ^[~/.][^[:space:]]*$ ]]; then icon="󰉋"
	elif [[ $text == *'\n'* ]]; then icon="󰅩"
	fi
	text=${text//\\n/ ↵ }
	text=${text//\\t/ }
	text=$(tr -s ' ' <<<"$text")
	printf '%s  %s' "$icon" "${text# }"
}

paste_into_focus() {
	command -v xdotool >/dev/null || return 0
	local class
	sleep 0.12 # let rofi release focus first
	class=$(xdotool getactivewindow getwindowclassname 2>/dev/null || true)
	case ${class,,} in
	kitty | *ghostty* | alacritty | xterm | urxvt | foot | wezterm* | org.wezfurlong.wezterm)
		xdotool key --clearmodifiers ctrl+shift+v ;;
	*) xdotool key --clearmodifiers ctrl+v ;;
	esac
}

row=0
while true; do
	mapfile -t lines < <(clipcatctl list 2>/dev/null)
	if ((${#lines[@]} == 0)); then
		rofi -e "Clipboard history is empty" -theme "$theme"
		exit 0
	fi

	ids=() labels=()
	for l in "${lines[@]}"; do
		ids+=("${l%%:*}")
		labels+=("$(label "${l#*: }")")
	done

	state="󰅍"
	clipcatctl get-watcher-state | grep -q 'is watching' || state="󰅛 paused"
	hint="<b>⏎</b> paste   <b>Alt+⏎</b> copy   <b>Shift+Del</b> delete   <b>Alt+e</b> edit   <b>Alt+p</b> view image   <b>Alt+x</b> clear"
	command -v xdotool >/dev/null || hint=${hint/<b>⏎<\/b> paste/<b>⏎<\/b> copy}

	idx=$(printf '%s\n' "${labels[@]}" | rofi -dmenu -i -format i -no-custom \
		-p "$state ${#ids[@]}" -mesg "$hint" -selected-row "$row" \
		-theme "$theme" \
		-kb-delete-entry "" -kb-accept-alt "" \
		-kb-custom-1 "Shift+Delete" -kb-custom-2 "Alt+Return" \
		-kb-custom-3 "Alt+e" -kb-custom-4 "Alt+p" -kb-custom-5 "Alt+x")
	rc=$?
	((rc == 1)) && exit 0 # Escape
	id=${ids[$idx]:-}
	row=${idx:-0}

	case $rc in
	0) clipcatctl promote "$id" >/dev/null && paste_into_focus; exit 0 ;;
	10) clipcatctl remove "$id" >/dev/null; ((row >= ${#ids[@]} - 1 && row > 0)) && ((row--)); continue ;;
	11) clipcatctl promote "$id" >/dev/null; exit 0 ;;
	12) exec kitty --class floating-editor -e clipcatctl edit "$id" ;;
	13)
		if [[ ${lines[$idx]#*: } == \[image/* ]]; then
			tmp=$(mktemp --suffix=.png)
			clipcatctl promote "$id" >/dev/null && sleep 0.1
			xclip -selection clipboard -t image/png -o >"$tmp" 2>/dev/null && setsid -f feh --scale-down --title "clipboard image" "$tmp"
			exit 0
		fi
		continue ;;
	14)
		[[ $(printf '󰄬  Yes, clear everything\n󰅖  No\n' | rofi -dmenu -i -p "Clear history? " -theme "$HOME/.config/rofi/powermenu.rasi" -selected-row 1) == *Yes* ]] &&
			clipcatctl clear >/dev/null
		exit 0 ;;
	*) exit 0 ;;
	esac
done
