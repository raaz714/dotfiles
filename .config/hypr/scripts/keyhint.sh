#!/bin/bash
# Minimalist Keybinding Hint Script

# Get the path to your keybindings file
BIND_FILE="$HOME/.config/hypr/keybindings.conf"

# Extract lines that start with 'bind' and have a comment '#'
# Then format them for Rofi
grep "^bind" "$BIND_FILE" | sed 's/bind = //g' | sed 's/bindm = //g' | awk -F, '{print $1 " + " $2 " ➜ " $NF}' | column -t -s '➜' | rofi -dmenu -i -p "󰌌 Keybinds" -theme-str 'window {width: 50%;}'
