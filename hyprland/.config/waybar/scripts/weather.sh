#!/usr/bin/env bash

data=$(curl -s --max-time 5 "wttr.in?format=%c%t" 2>/dev/null)
if [[ -n "$data" && "$data" != *"Unknown"* ]]; then
    echo "{\"text\": \"$data\", \"tooltip\": \"$(curl -s --max-time 3 wttr.in?format=%C 2>/dev/null)\"}"
else
    echo '{"text": "", "class": "hidden"}'
fi
