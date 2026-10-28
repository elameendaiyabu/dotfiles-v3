asusctl profile get 2>/dev/null | awk '/Active profile/ {print $NF; exit}'
