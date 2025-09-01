# Nushell Configuration File
# This file is used to configure nushell

# Hide startup banner
$env.config = ($env.config | upsert show_banner false)

# set default editor to neovim btw
$env.config.buffer_editor = "nvim"

# Source aliases and completions
source aliases.nu
source completions.nu
source catppuccin_mocha.nu

# Third-party integrations
# Starship prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Zoxide integration (smart cd)
source ~/.zoxide.nu
