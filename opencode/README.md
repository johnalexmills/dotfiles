## opencode

Global opencode config, instructions and plugins.

### Layout

```
.config/opencode/opencode.jsonc          — global config
.config/opencode/instructions/caveman.md — always-on output style
.config/opencode/instructions/general.md — misc standing rules
.config/opencode/plugins/caveman.ts      — re-asserts caveman last in the prompt
scripts/check-upstream.sh                — upstream drift check for caveman.md
```

### Caveman

Terse output, ~65-75% fewer tokens. **Always on** — not a mode, no trigger
phrase. Turn it off for a session with "stop caveman" or "normal mode".

It is enforced in two places, deliberately:

1. `instructions/caveman.md` is listed in `opencode.jsonc` and lands near the
   top of the system prompt.
2. `plugins/caveman.ts` appends the same text again as the **last** system
   entry, via the `experimental.chat.system.transform` hook.

The second exists because position matters. On its own, a short style directive
near the top of a long system prompt loses to the thoroughness guidance that
follows it — in practice it was being ignored on longer tasks such as audits and
multi-step refactors. The plugin reads `caveman.md` at runtime rather than
restating it, so the two cannot drift.

It was previously also registered as a skill. That was removed: a skill's
`description` advertises trigger phrases, which framed caveman as opt-in and
contradicted the "always on" instruction.

### Plugins

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

### Maintenance

`instructions/caveman.md` is derived from
[JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman), which ships it
as a skill. We keep only the prose and skip the Node plugins/hooks, and have
diverged deliberately: the always-on framing and the narrowed exception list are
local changes.

Check for upstream changes:

```bash
opencode/scripts/check-upstream.sh
```

Reports drift against the pinned SHA in the file's header comment. Expect the
diff to be large — upstream is a skill with frontmatter and multiple levels,
ours is a single always-on instruction. Review for wording worth porting, then
bump the pinned SHA. Run quarterly.
