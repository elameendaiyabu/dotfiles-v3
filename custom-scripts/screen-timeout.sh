#!/usr/bin/env bash
# screen-timeout — X idle timeout via xset. When it fires, xss-lock locks the
# screen; the display powers off (DPMS) two minutes later. Choice persists.
#   --status  print bar label    --menu  rofi picker     --restore  apply saved
#   --next / --prev  cycle presets
state="${XDG_STATE_HOME:-$HOME/.local/state}/screen-timeout"
presets=(0 1 2 5 10 15 30 60)

current() { cat "$state" 2>/dev/null || echo 0; }
label() { (($1 == 0)) && echo "off" || { (($1 < 60)) && echo "${1}m" || echo "$(($1 / 60))h"; }; }

apply() {
	local min=$1 secs=$(($1 * 60))
	mkdir -p "${state%/*}" && echo "$min" >"$state"
	if ((min == 0)); then
		xset s off -dpms
	else
		xset s "$secs" "$secs" +dpms dpms 0 0 $((secs + 120))
	fi
	polybar-msg action screen-timeout hook 0 >/dev/null 2>&1
}

cycle() {
	local cur i n=${#presets[@]}
	cur=$(current)
	for i in "${!presets[@]}"; do [[ ${presets[i]} == "$cur" ]] && break; done
	apply "${presets[((i + $1 + n) % n)]}"
}

case $1 in
--status) echo "$(label "$(current)")" ;;
--restore) apply "$(current)" ;;
--next) cycle 1 ;;
--prev) cycle -1 ;;
--menu | "")
	cur=$(current)
	choice=$(for p in "${presets[@]}"; do
		[[ $p == "$cur" ]] && mark="󰄬" || mark=" "
		echo "$mark  $(label "$p")"
	done | rofi -dmenu -i -p "󰔛 " -mesg "Screen timeout (lock + display off)" \
		-theme "$HOME/.config/rofi/powermenu.rasi" -theme-str "listview { lines: 8; }") || exit 0
	choice=${choice##* }
	for p in "${presets[@]}"; do [[ $(label "$p") == "$choice" ]] && apply "$p"; done
	;;
esac
