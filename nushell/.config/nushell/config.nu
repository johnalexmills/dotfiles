# Nushell Configuration File
# This file is used to configure nushell

# Hide startup banner
$env.config = ($env.config | upsert show_banner false)

# Source aliases and completions
source aliases.nu
source completions.nu

# Third-party integrations
# Starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
use ~/.cache/starship/init.nu

# Zoxide integration (smart cd)
if (which zoxide | is-not-empty) {
    # Note: You'll need to run `zoxide init nushell | save ~/.cache/zoxide/init.nu` first
    if ($"($nu.home-path)/.cache/zoxide/init.nu" | path exists) {
        source ~/.cache/zoxide/init.nu
    }
}
