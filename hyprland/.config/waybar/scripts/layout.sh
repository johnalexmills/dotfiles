#!/usr/bin/env bash
# Show active keyboard layout variant via hyprctl
data=$(hyprctl devices -j)
idx=$(echo "$data" | jq -r '.keyboards[0].active_layout_index')
variant=$(echo "$data" | jq -r '.keyboards[0].variant | split(",")[$idx]' --argjson idx "$idx")

if [ "$variant" = "colemak" ]; then
  text="Colemak"
else
  text="US"
fi

cat <<EOF
{"text": "$text", "alt": "$text", "tooltip": "Layout: $text"}
EOF
