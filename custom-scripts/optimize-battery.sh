#!/bin/bash

echo "🛠️ Optimizing startup for better battery life..."

# 1. Kill duplicate picom if any
echo "🔁 Killing existing picom instances..."
killall -q picom

# 2. Relaunch picom cleanly
echo "✨ Starting picom..."
picom --experimental-backends --config ~/.config/picom/picom.conf &

# 3. Set CPU to power-saving governor
echo "🌡️ Setting CPU governor to powersave..."
for cpu in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo powersave | sudo tee $cpu >/dev/null
done

# 4. Disable unused services (optional: asusd, etc.)
echo "🔧 Disabling asusd temporarily (optional)..."
sudo systemctl mask asusd.service
sudo systemctl stop asusd.service

# 5. Disable annoying sensors or ACPI devices (careful!)
# echo "⚠️ Disabling AMD I2C device (risky - only test mode)"
# echo "disable" > /sys/bus/acpi/devices/AMDI0010:03/status

# 6. Optionally reduce wakeups from terminal emulators or polybar
echo "🐢 Limiting wakeups from polybar and terminal..."
renice -n 10 -p $(pgrep polybar)
renice -n 10 -p $(pgrep kitty)

# 7. Tune kernel timer tick (advanced users)
# echo "🔕 Reducing timer tick frequency..."
# echo 1 > /sys/devices/system/cpu/nohz_full

echo "✅ Done. Battery should now last longer!"
