#!/usr/bin/env bash

if ! command -v checkupdates &>/dev/null; then
    echo '{"text": "", "class": "hidden"}'
    exit 0
fi

updates=$(checkupdates 2>/dev/null | wc -l)
if [[ "$updates" -gt 0 ]]; then
    echo "{\"text\": \" $updates\", \"class\": \"has-updates\", \"tooltip\": \"$updates updates available\"}"
else
    echo '{"text": "", "class": "hidden"}'
fi
