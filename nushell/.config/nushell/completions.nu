# Nushell Custom Completions
# Enhanced completions for better UX

# Git branch completion for checkout
extern "git checkout" [
    branch?: string@git_branches
]

def git_branches [] {
    git branch --all | lines | each { |line| $line | str trim | str replace '* ' '' | str replace 'remotes/origin/' '' } | uniq | where $it !~ '^\s*$'
}

# Docker container completion
extern "docker exec" [
    container: string@docker_containers
    --interactive(-i)
    --tty(-t)
    command?: string
]

def docker_containers [] {
    if (which docker | is-not-empty) {
        docker ps --format "table {{.Names}}\t{{.Status}}" | lines | skip 1 | each { |line| ($line | split column "\t").0 }
    } else {
        []
    }
}

# SSH host completion from ~/.ssh/config
extern "ssh" [
    host?: string@ssh_hosts
]

def ssh_hosts [] {
    if ("~/.ssh/config" | path expand | path exists) {
        open ~/.ssh/config 
        | lines 
        | where $it =~ "^Host "
        | each { |line| $line | str replace "Host " "" | str trim }
        | where $it != "*"
    } else {
        []
    }
}

# Package manager completions (Arch Linux)
extern "pacman" [
    --sync(-S)
    --remove(-R)
    --query(-Q)
    --upgrade(-U)
    package?: string@pacman_packages
]

def pacman_packages [] {
    if (which pacman | is-not-empty) {
        pacman -Ss | lines | where $it =~ "^[^\\s]" | each { |line| ($line | split column "/").1 | split column " " | get 0 }
    } else {
        []
    }
}

# Systemctl service completion
extern "systemctl" [
    action: string@systemctl_actions
    service?: string@systemctl_services
]

def systemctl_actions [] {
    ["start", "stop", "restart", "reload", "enable", "disable", "status", "is-active", "is-enabled"]
}

def systemctl_services [] {
    if (which systemctl | is-not-empty) {
        systemctl list-units --type=service --all --no-legend | lines | each { |line| ($line | split column " ").0 | str replace ".service" "" }
    } else {
        []
    }
}

# Cargo subcommand completion
extern "cargo" [
    command: string@cargo_commands
]

def cargo_commands [] {
    [
        "build", "check", "clean", "doc", "new", "init", "add", "remove", 
        "run", "test", "bench", "update", "search", "publish", "install", 
        "uninstall", "tree", "fmt", "clippy"
    ]
}

# NPM script completion
extern "npm" [
    command: string@npm_commands
    script?: string@npm_scripts
]

def npm_commands [] {
    [
        "install", "i", "run", "start", "test", "build", "dev", "update", 
        "uninstall", "publish", "init", "audit", "outdated", "ls", "link"
    ]
}

def npm_scripts [] {
    if ("package.json" | path exists) {
        open package.json | get scripts? | default {} | columns
    } else {
        []
    }
}