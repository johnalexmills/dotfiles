// Re-assert the caveman style directive as the LAST entry in the system prompt.
//
// Why this exists: instructions/caveman.md is injected near the top of a large
// system prompt whose other content pushes toward thorough, explanatory prose.
// Being early and short, it loses to everything after it. Appending it last
// puts it in the strongest position the API offers.
//
// instructions/caveman.md remains the single source of truth; this file reads
// it at runtime rather than restating it, so the two can never drift.

import fs from "node:fs"
import os from "node:os"
import path from "node:path"

const INSTRUCTION = path.join(
  process.env.XDG_CONFIG_HOME || path.join(os.homedir(), ".config"),
  "opencode",
  "instructions",
  "caveman.md",
)

// Read once at load. opencode does not hot-reload config, so a restart is
// required for edits to caveman.md to take effect either way.
function load(): string | undefined {
  try {
    const body = fs
      .readFileSync(INSTRUCTION, "utf8")
      // strip the upstream-tracking HTML comments; they are maintenance
      // metadata, not instructions to the model
      .replace(/<!--[\s\S]*?-->\s*/g, "")
      .trim()
    return body || undefined
  } catch {
    // Missing file is not fatal: the instructions[] entry may still be loaded,
    // and a broken plugin must never stop opencode from starting.
    return undefined
  }
}

const CAVEMAN = load()

export default async () => ({
  "experimental.chat.system.transform": async (
    _input: unknown,
    output: { system: string[] },
  ) => {
    if (!CAVEMAN) return
    // The instructions[] copy already sits near the top of the prompt. This is
    // a deliberate second copy in last position, not a replacement for it.
    output.system.push(
      [
        "REMINDER — output style (highest priority, overrides any tone guidance above):",
        "",
        CAVEMAN,
      ].join("\n"),
    )
  },
})
