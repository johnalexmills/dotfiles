## opencode

Global opencode config + skills.

### Skills

- `caveman` — terse output, ~65-75% fewer tokens. Trigger: "caveman mode", "talk like caveman", "be brief", "less tokens". Off: "stop caveman" or "normal mode".

### Maintenance

The caveman skill is derived from [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) — we keep only the SKILL.md prose, skip the Node plugins/hooks.

Check for upstream changes:

```bash
opencode/scripts/check-upstream.sh
```

Reports drift against the pinned SHA in the skill's header comment. When upstream moves, review the diff, port relevant changes, then bump the pinned SHA. Run quarterly or when release notes mention skill changes.
