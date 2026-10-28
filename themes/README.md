# System themes

One palette → every app. Switch with **Alt+Y** (picker), **Alt+Shift+Y** (next theme),
**Alt+Ctrl+Y** (next wallpaper), or the 󰏘 icon in polybar (click / right-click / scroll).

    bin/theme-switch <name> | --next | --prev | --wall next|prev | --restore | --list

Themes: `<name>/palette.sh` + `<name>/wallpapers/*.jpg`. To add one, copy a folder,
edit the palette, drop in wallpapers. `current/` is generated — don't edit it.

Covers: i3 borders, polybar, picom (theme-agnostic), rofi, dunst, kitty, ghostty, tmux,
starship, btop, neovim (live, via file watcher), fzf, Xresources, GTK, i3lock-color.
Backup of the pre-theme configs: ~/config-backup-2026-10-28/configs.tar.gz
