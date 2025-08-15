# ═══════════════════════════════════════════════════════════════
# Oh My Zsh Configuration
# ═══════════════════════════════════════════════════════════════
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"  # Will be overridden by Starship

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
    fast-syntax-highlighting
    zsh-vi-mode
    docker
    docker-compose
    kubectl
    terraform
    aws
    npm
    yarn
    python
    pip
    golang
    rust
    fzf
    tmux
    macos
    vscode
    gh
    z
    colored-man-pages
    command-not-found
    extract
    sudo
    web-search
    jsontools
    urltools
    copypath
    copyfile
    copybuffer
    dirhistory
    history
    aliases
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ═══════════════════════════════════════════════════════════════
# Environment Variables
# ═══════════════════════════════════════════════════════════════
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-R"
export TERM="xterm-256color"

# Development paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

# Java
if [ -f "$HOME/.java_home" ]; then
    source "$HOME/.java_home"
fi

# Python
export PYTHONDONTWRITEBYTECODE=1
export PIPENV_VENV_IN_PROJECT=1
export POETRY_VIRTUALENVS_IN_PROJECT=true

# ═══════════════════════════════════════════════════════════════
# Aliases - Modern CLI replacements
# ═══════════════════════════════════════════════════════════════
# Core replacements
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first --git"
alias la="eza -a --icons --group-directories-first"
alias l="eza -l --icons --group-directories-first --git"
alias lt="eza --tree --icons --level=2"
alias lt3="eza --tree --icons --level=3"
alias tree="eza --tree --icons"

alias cat="bat --style=plain --paging=never"
alias less="bat --style=plain"
alias grep="rg"
alias find="fd"
alias df="duf"
alias du="dust"
alias top="htop"
alias ps="procs"
alias sed="sd"

# Git aliases
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline --graph --decorate"
alias gla="git log --oneline --graph --decorate --all"
alias lg="lazygit"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"
alias -- -="cd -"

# Development
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias nv="nvim"
alias code.="code ."
alias zj="zellij"
alias zja="zellij attach"
alias zjl="zellij list-sessions"
alias zjk="zellij kill-session"
alias zjka="zellij kill-all-sessions"

# Python
alias py="python3"
alias pip="pip3"
alias pya="source venv/bin/activate 2>/dev/null || source .venv/bin/activate 2>/dev/null || python3 -m venv venv && source venv/bin/activate"
alias pyd="deactivate"
alias pyi="pip install -r requirements.txt"
alias pyf="pip freeze > requirements.txt"
alias pyt="pytest"
alias pytv="pytest -v"
alias pytc="pytest --cov"
alias jl="jupyter lab"
alias jn="jupyter notebook"

# Java
alias javac="javac -encoding UTF-8"
alias java="java -Dfile.encoding=UTF-8"
alias mvn="mvn -Dfile.encoding=UTF-8"
alias mvnc="mvn clean"
alias mvnp="mvn package"
alias mvni="mvn install"
alias mvnt="mvn test"
alias mvnr="mvn spring-boot:run"

# C/C++
alias gpp="g++ -std=c++17 -Wall -Wextra -O2"
alias gccc="gcc -std=c11 -Wall -Wextra -O2"
alias make="make -j$(nproc)"
alias cmake="cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dps="docker ps"
alias dpsa="docker ps -a"
alias di="docker images"
alias dex="docker exec -it"
alias dlog="docker logs -f"
alias dprune="docker system prune -a"
alias ld="lazydocker"

# Kubernetes
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"
alias kaf="kubectl apply -f"
alias kdel="kubectl delete"
alias klog="kubectl logs -f"
alias kex="kubectl exec -it"

# System
alias reload="source ~/.zshrc"
alias path='echo -e ${PATH//:/\\n}'
alias myip="curl -s https://api.ipify.org && echo"
alias localip="ipconfig getifaddr en0"
alias flushdns="sudo dscacheutil -flushcache"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"
alias update="brew update && brew upgrade && brew cleanup"

# Quick edits
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.lua"
alias gitconfig="nvim ~/.gitconfig"
alias sshconfig="nvim ~/.ssh/config"
alias hosts="sudo nvim /etc/hosts"
alias starshiprc="nvim ~/.config/starship.toml"
alias zellijrc="nvim ~/.config/zellij/config.kdl"
alias weztermrc="nvim ~/.config/wezterm/wezterm.lua"
alias aerospacerc="nvim ~/.config/aerospace/aerospace.toml"

# Quick access
alias dev="cd ~/Developer"
alias docs="cd ~/Documents"
alias downloads="cd ~/Downloads"
alias desktop="cd ~/Desktop"

# Modern tools shortcuts
alias lsd="eza -la --tree --level=2"
alias cat-less="bat --paging=always"
alias json="fx"
alias weather="curl wttr.in"
alias myip-full="curl -s http://ipinfo.io/json | fx"
alias ports="lsof -iTCP -sTCP:LISTEN -n -P"
alias ram="ps aux | sort -nr -k 4"
alias cpu="ps aux | sort -nr -k 3"

# Docker shortcuts
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcr="docker-compose restart"
alias dcl="docker-compose logs -f"
alias dps-format="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"

# Kubernetes shortcuts
alias kx="kubectl exec -it"
alias kd="kubectl describe"
alias kg="kubectl get"
alias kctx="kubectl config current-context"
alias kns="kubectl config view --minify --output 'jsonpath={..namespace}'"

# Git extended
alias gac="git add -A && git commit -m"
alias gpo="git push origin"
alias gpu="git push upstream"
alias gst="git stash"
alias gsp="git stash pop"
alias gsl="git stash list"
alias grh="git reset --hard"
alias gcp="git cherry-pick"
alias gmt="git mergetool"
alias gdt="git difftool"

# Productivity
alias reload-dns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias finder="open ."
alias preview="open -a Preview"
alias chrome="open -a 'Google Chrome'"
alias firefox="open -a Firefox"
alias safari="open -a Safari"

# ═══════════════════════════════════════════════════════════════
# Functions
# ═══════════════════════════════════════════════════════════════
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract any archive
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)     echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Quick Python HTTP server
server() {
    local port="${1:-8000}"
    python3 -m http.server "$port"
}

# Git commit with message
gcam() {
    git add . && git commit -m "$1"
}

# Git commit and push
gcamp() {
    git add . && git commit -m "$1" && git push
}

# Search and replace in files
replace() {
    if [ $# -ne 3 ]; then
        echo "Usage: replace <find> <replace> <file_pattern>"
        return 1
    fi
    fd "$3" -x sd "$1" "$2" {}
}

# Quick compile and run for different languages
run() {
    file="$1"
    case "$file" in
        *.c)
            echo "Compiling C: $file"
            gcc -Wall -Wextra -std=c11 -o "${file%.c}" "$file" && "./${file%.c}"
            ;;
        *.cpp|*.cc)
            echo "Compiling C++: $file"
            g++ -Wall -Wextra -std=c++17 -o "${file%.*}" "$file" && "./${file%.*}"
            ;;
        *.java)
            echo "Compiling Java: $file"
            javac -encoding UTF-8 "$file" && java -Dfile.encoding=UTF-8 "${file%.java}"
            ;;
        *.py)
            echo "Running Python: $file"
            python3 "$file"
            ;;
        *.js)
            echo "Running JavaScript: $file"
            node "$file"
            ;;
        *.ts)
            echo "Running TypeScript: $file"
            ts-node "$file"
            ;;
        *.go)
            echo "Running Go: $file"
            go run "$file"
            ;;
        *.rs)
            echo "Compiling Rust: $file"
            rustc "$file" && "./${file%.rs}"
            ;;
        *.sh)
            echo "Running Shell Script: $file"
            bash "$file"
            ;;
        *)
            echo "Unsupported file type: $file"
            echo "Supported: .c .cpp .java .py .js .ts .go .rs .sh"
            ;;
    esac
}

# Find and kill process by name
killp() {
    if [ -z "$1" ]; then
        echo "Usage: killp <process_name>"
        return 1
    fi
    ps aux | grep -v grep | grep "$1" | awk '{print $2}' | xargs kill -9
}

# Create a backup of a file
backup() {
    if [ -z "$1" ]; then
        echo "Usage: backup <file>"
        return 1
    fi
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backup created: $1.backup.$(date +%Y%m%d_%H%M%S)"
}

# Quick project setup
init-project() {
    project_name="$1"
    project_type="${2:-basic}"
    
    if [ -z "$project_name" ]; then
        echo "Usage: init-project <name> [type]"
        echo "Types: python, node, go, rust, java, basic"
        return 1
    fi
    
    mkdir -p "$project_name" && cd "$project_name"
    
    case "$project_type" in
        python)
            echo "# $project_name" > README.md
            echo "*.pyc\n__pycache__/\nvenv/\n.env" > .gitignore
            python3 -m venv venv
            echo "Python project initialized"
            ;;
        node)
            npm init -y
            echo "node_modules/\n.env\ndist/" > .gitignore
            echo "# $project_name" > README.md
            echo "Node.js project initialized"
            ;;
        go)
            go mod init "$project_name"
            echo "# $project_name" > README.md
            echo "package main\n\nimport \"fmt\"\n\nfunc main() {\n\tfmt.Println(\"Hello, World!\")\n}" > main.go
            echo "Go project initialized"
            ;;
        rust)
            cargo init --name "$project_name"
            echo "Rust project initialized"
            ;;
        java)
            mkdir -p src/main/java src/test/java
            echo "# $project_name" > README.md
            echo "*.class\ntarget/\n.idea/" > .gitignore
            echo "Java project initialized"
            ;;
        *)
            echo "# $project_name" > README.md
            touch .gitignore
            echo "Basic project initialized"
            ;;
    esac
    
    git init
    git add .
    git commit -m "Initial commit"
}

# Quick file search and edit
fe() {
    local file
    file=$(fd --type f --hidden --follow --exclude .git | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
    [ -n "$file" ] && nvim "$file"
}

# Quick directory navigation with fzf
fd-cd() {
    local dir
    dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --icons --level=2 {}')
    [ -n "$dir" ] && cd "$dir"
}

# Git log with fzf
fzf-git-log() {
    git log --oneline --color=always | fzf --ansi --preview 'git show --color=always {1}'
}

# Process finder with kill option
pf() {
    local pid
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    if [ "x$pid" != "x" ]; then
        echo $pid | xargs kill -${1:-9}
    fi
}

# Docker container management
docker-clean() {
    echo "Cleaning up Docker..."
    docker container prune -f
    docker image prune -f
    docker volume prune -f
    docker network prune -f
    echo "Docker cleanup complete"
}

# System info
sysinfo() {
    echo "System Information:"
    echo "=================="
    echo "OS: $(sw_vers -productName) $(sw_vers -productVersion)"
    echo "Kernel: $(uname -r)"
    echo "Shell: $SHELL"
    echo "Terminal: $TERM"
    echo "CPU: $(sysctl -n machdep.cpu.brand_string)"
    echo "Memory: $(system_profiler SPHardwareDataType | grep "Memory:" | awk '{print $2 " " $3}')"
    echo "Disk Usage:"
    df -h | head -2
}

# ═══════════════════════════════════════════════════════════════
# Key Bindings (Vi mode enhancements)
# ═══════════════════════════════════════════════════════════════
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^k' kill-line
bindkey '^u' kill-whole-line
bindkey '^y' yank
bindkey '^[f' forward-word
bindkey '^[b' backward-word

# ═══════════════════════════════════════════════════════════════
# FZF Configuration
# ═══════════════════════════════════════════════════════════════
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='
    --height 40% 
    --layout=reverse 
    --border 
    --preview "bat --style=numbers --color=always --line-range :500 {}"
    --preview-window=right:60%:wrap
    --bind "ctrl-/:toggle-preview"
    --bind "ctrl-y:execute-silent(echo {} | pbcopy)+abort"
'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --level=2 {}'"

# fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ═══════════════════════════════════════════════════════════════
# Zoxide Configuration
# ═══════════════════════════════════════════════════════════════
eval "$(zoxide init zsh)"
alias cd="z"
alias cdi="zi"

# ═══════════════════════════════════════════════════════════════
# Starship Prompt
# ═══════════════════════════════════════════════════════════════
eval "$(starship init zsh)"

# ═══════════════════════════════════════════════════════════════
# Load local configuration if exists
# ═══════════════════════════════════════════════════════════════
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# ═══════════════════════════════════════════════════════════════
# Auto-suggestions configuration
# ═══════════════════════════════════════════════════════════════
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# ═══════════════════════════════════════════════════════════════
# History Configuration
# ═══════════════════════════════════════════════════════════════
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
