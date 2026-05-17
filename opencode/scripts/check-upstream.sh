#!/usr/bin/env bash
# Check our caveman SKILL.md against upstream JuliusBrussee/caveman.
# Reports new upstream commits since our pinned SHA and shows content diff.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../../scripts/helpers.sh
source "$SCRIPT_DIR/../../scripts/helpers.sh"

LOCAL_SKILL="$SCRIPT_DIR/../.config/opencode/skills/caveman/SKILL.md"
UPSTREAM_REPO="JuliusBrussee/caveman"
UPSTREAM_PATH="skills/caveman/SKILL.md"
UPSTREAM_RAW="https://raw.githubusercontent.com/$UPSTREAM_REPO/main/$UPSTREAM_PATH"
UPSTREAM_API="https://api.github.com/repos/$UPSTREAM_REPO/commits?path=$UPSTREAM_PATH&per_page=1"

# --- Read pinned SHA from local file ---

pinned_sha() {
    grep -oE 'upstream:.*@ [0-9a-f]{40}' "$LOCAL_SKILL" \
        | grep -oE '[0-9a-f]{40}$' \
        | head -1
}

# --- Fetch latest upstream SHA touching SKILL.md ---

latest_sha() {
    curl -fsSL "$UPSTREAM_API" \
        | grep -oE '"sha": *"[0-9a-f]{40}"' \
        | head -1 \
        | grep -oE '[0-9a-f]{40}'
}

# --- Main ---

main() {
    local pinned latest
    pinned="$(pinned_sha)"
    [ -z "$pinned" ] && err "no pinned SHA found in $LOCAL_SKILL"

    info "pinned:  $pinned"
    latest="$(latest_sha)" || err "failed to fetch upstream SHA"
    info "latest:  $latest"

    if [ "$pinned" = "$latest" ]; then
        ok "up to date — no upstream changes since pin"
        exit 0
    fi

    warn "upstream moved — review changes:"
    echo "  https://github.com/$UPSTREAM_REPO/commits/main/$UPSTREAM_PATH"
    echo "  https://github.com/$UPSTREAM_REPO/compare/$pinned...$latest"
    echo

    info "content diff (upstream → local):"
    echo "---"
    local tmp
    tmp="$(mktemp)"
    # shellcheck disable=SC2064
    trap "rm -f '$tmp'" EXIT
    curl -fsSL "$UPSTREAM_RAW" >"$tmp"
    diff -u "$tmp" "$LOCAL_SKILL" || true
    echo "---"
    echo
    info "to sync: port relevant changes manually, then update pinned SHA to: $latest"
}

main
