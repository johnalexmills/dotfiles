#!/usr/bin/env bash
hyprctl devices -j | python3 -c "
import sys, json
data = json.load(sys.stdin)
for kb in data.get('keyboards', []):
    if kb.get('main', False):
        name = kb.get('active_keymap', '??')
        if '(' in name:
            name = name.split('(')[-1].rstrip(')')
        print(name)
        break
"
