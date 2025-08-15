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
            gcc -o "${file%.c}" "$file" && "./${file%.c}"
            ;;
        *.cpp|*.cc)
            g++ -o "${file%.*}" "$file" && "./${file%.*}"
            ;;
        *.java)
            javac "$file" && java "${file%.java}"
            ;;
        *.py)
            python3 "$file"
            ;;
        *.js)
            node "$file"
            ;;
        *.ts)
            ts-node "$file"
            ;;
        *.go)
            go run "$file"
            ;;
        *.rs)
            rustc "$file" && "./${file%.rs}"
            ;;
        *.sh)
            bash "$file"
            ;;
        *)
            echo "Unsupported file type: $file"
            ;;
    esac
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

# Create .zshenv
cat > $REPO_NAME/dotfiles/zsh/.zshenv << 'EOF'
# ═══════════════════════════════════════════════════════════════
# Zsh Environment Variables (loaded for all shells)
# ═══════════════════════════════════════════════════════════════

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set PATH
path=(
    $HOME/.local/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    $path
)

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
