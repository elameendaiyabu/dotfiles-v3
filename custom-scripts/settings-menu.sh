#!/usr/bin/env bash
# settings-menu — themed rofi launcher for system settings.
wifi="󰤨  Wi-Fi" audio="󰕾  Audio" display="󰍹  Displays" timeout="󰔛  Screen timeout"
bt="󰂯  Bluetooth" theme="󰏘  Theme" power="󱪈  Power profile" all="  All settings"
gnome() { XDG_CURRENT_DESKTOP=GNOME gnome-control-center "$@" & }

choice=$(printf '%s\n' "$wifi" "$audio" "$display" "$timeout" "$bt" "$theme" "$power" "$all" |
	rofi -dmenu -i -p " " -theme "$HOME/.config/rofi/powermenu.rasi" -theme-str "listview { lines: 8; }") || exit 0
s="$HOME/.config/custom-scripts"
case $choice in
"$wifi") exec "$s/wifi-popup.sh" ;;
"$audio") exec pavucontrol ;;
"$display") exec arandr ;;
"$timeout") exec "$s/screen-timeout.sh" --menu ;;
"$bt") gnome bluetooth ;;
"$theme") exec "$HOME/.config/themes/bin/theme-picker" ;;
"$power") exec rog-control-center ;;
"$all") gnome ;;
esac
