## opencode

Global opencode config and instructions.

### Layout

```
.config/opencode/opencode.jsonc          — global config
.config/opencode/instructions/general.md — misc standing rules
```

### Plugins

None currently, so the directory does not exist in this repo — git cannot track
an empty one. To add a plugin, create
`opencode/.config/opencode/plugins/<name>.ts` and re-run the module install
script so stow links it.

opencode auto-discovers every `.ts`/`.js` file in `~/.config/opencode/plugins/`
— no `plugin` key is needed in `opencode.jsonc`. Confirm what actually loaded
with:

```bash
opencode debug config
```

Config is read once at startup and is not hot-reloaded. **Restart opencode after
changing anything here.**

### Skills

None currently. opencode's built-in skills load regardless. To add one, create
`~/.config/opencode/skills/<name>/SKILL.md` and add to `opencode.jsonc`:

```jsonc
"skills": { "paths": ["~/.config/opencode/skills"] }
```

### Cost

Session cost is dominated by context, not by how much the model writes. Measured
across a 101-message session (`~/.local/share/opencode/storage/`):

| line | share of cost |
|------|---------------|
| cache write | 62.5% |
| cache read | 29.8% |
| output (reasoning + prose + code) | 7.6% |

Tool results were 85% of everything written into context, and context is resent
every turn. So the levers that matter are, in order: a cheaper model, then
`compaction.prune` and `tool_output` caps to keep tool results from accumulating,
then routing searches through subagents. Trimming prose style is worth about 1%
and is not worth doing.
