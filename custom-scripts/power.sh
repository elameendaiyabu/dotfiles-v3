#!/bin/bash

# Define the options
options="Sleep\nReboot\nShutdown"

# Use rofi to display the menu and get user selection
selected=$(echo -e "$options" | rofi -dmenu -i -p "Power Menu " -dpi 1)

# Process the selection
case $selected in
    Sleep)
        # Replace with your preferred screen locker command
        systemctl suspend
        ;;
    Reboot)
        shutdown --reboot now
        ;;
    Shutdown)
        shutdown --poweroff now
        ;;
esac
