# ═══════════════════════════════════════════════════════════════
# ZSH Configuration with LazyVim and Nerd Font Support
# ═══════════════════════════════════════════════════════════════

# Enable Nerd Font support
export TERM="xterm-256color"
export LC_ALL="en_US.UTF-8"

# Path to oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration (Powerlevel10k with Nerd Font support)
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  zsh-vi-mode
  fzf
  docker
  kubectl
  rust
  golang
  python
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ═══════════════════════════════════════════════════════════════
# Environment Variables
# ═══════════════════════════════════════════════════════════════

# Editor preference - LazyVim
export EDITOR='nvim'
export VISUAL='nvim'

# Language
export LANG=en_US.UTF-8

# Homebrew
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Python
export PYTHONDONTWRITEBYTECODE=1

# Java
[ -f "$HOME/.java_home" ] && source "$HOME/.java_home"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Local bin
export PATH=$HOME/.local/bin:$PATH

# Node
export PATH=$HOME/.npm-global/bin:$PATH

# ═══════════════════════════════════════════════════════════════
# Aliases
# ═══════════════════════════════════════════════════════════════

# LazyVim aliases
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Modern alternatives with Nerd Font icons
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias la='eza -a --icons --group-directories-first'
alias tree='eza --tree --icons'
alias cat='bat --style=numbers,changes --theme=TwoDark'
alias find='fd'
alias grep='rg'

# Git aliases
alias g='git'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git pull'
alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'
alias lg='lazygit'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# System
alias h='history'
alias j='jobs'
alias c='clear'
alias q='exit'

# Development shortcuts
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'
alias json='python3 -m json.tool'

# Zellij with LazyVim integration
alias z='zellij'
alias zd='zellij -l dev'
alias zm='zellij -l minimal'
alias zp='zellij -l python'
alias zr='zellij -l rust'
alias zg='zellij -l go'
alias zj='zellij -l java'
alias zc='zellij -l c'

# ═══════════════════════════════════════════════════════════════
# Functions
# ═══════════════════════════════════════════════════════════════

# Fuzzy find and edit with LazyVim
fe() {
  local file
  file=$(fzf --preview 'bat --style=numbers --color=always --theme=TwoDark {}' --preview-window 'right:60%') && nvim "$file"
}

# Fuzzy directory change
fd-cd() {
  local dir
  dir=$(fd --type d --hidden --follow --exclude .git | fzf --preview 'eza --tree --level=2 --icons {}' --preview-window 'right:50%') && cd "$dir"
}

# Git log with fzf
fzf-git-log() {
  git log --oneline --color=always | fzf --ansi --preview 'git show --color=always {1}' --preview-window 'right:60%'
}

# Process finder
pf() {
  ps aux | fzf --header-lines=1 --preview 'echo {}' --preview-window down:3:wrap
}

# Quick project initialization
init-project() {
  local name="$1"
  local type="${2:-basic}"
  
  if [[ -z "$name" ]]; then
    echo "Usage: init-project <name> [python|node|go|rust|java]"
    return 1
  fi
  
  mkdir -p "$HOME/Developer/projects/$name"
  cd "$HOME/Developer/projects/$name"
  
  case "$type" in
    python)
      python3 -m venv venv
      source venv/bin/activate
      echo "Flask==2.3.2\nrequests==2.31.0" > requirements.txt
      echo "# $name\n\nPython project" > README.md
      ;;
    node)
      npm init -y
      echo "# $name\n\nNode.js project" > README.md
      ;;
    go)
      go mod init "$name"
      echo "# $name\n\nGo project" > README.md
      ;;
    rust)
      cargo init .
      ;;
    java)
      mkdir -p src/main/java src/test/java
      echo "# $name\n\nJava project" > README.md
      ;;
    *)
      echo "# $name\n\nBasic project" > README.md
      ;;
  esac
  
  nvim .
}

# Quick compile and run
run() {
  local file="$1"
  if [[ -z "$file" ]]; then
    echo "Usage: run <filename>"
    return 1
  fi
  
  case "${file##*.}" in
    py) python3 "$file" ;;
    js) node "$file" ;;
    ts) ts-node "$file" ;;
    go) go run "$file" ;;
    rs) rustc "$file" && ./"${file%.*}" ;;
    c) gcc -o "${file%.*}" "$file" && ./"${file%.*}" ;;
    cpp) g++ -o "${file%.*}" "$file" && ./"${file%.*}" ;;
    java) javac "$file" && java "${file%.*}" ;;
    *) echo "Unsupported file type: ${file##*.}" ;;
  esac
}

# System information
sysinfo() {
  echo "📊 === System Information ==="
  echo "OS: $(uname -s)"
  echo "Architecture: $(uname -m)"
  echo "Hostname: $(hostname)"
  echo "Uptime: $(uptime | awk '{print $3,$4}' | sed 's/,//')"
  echo "Memory: $(free -h 2>/dev/null || vm_stat | head -5)"
  echo "Disk: $(df -h / | tail -1)"
  echo ""
  echo "🔧 === Development Tools ==="
  command -v nvim >/dev/null && echo "Neovim: $(nvim --version | head -1)"
  command -v python3 >/dev/null && echo "Python: $(python3 --version)"
  command -v node >/dev/null && echo "Node.js: $(node --version)"
  command -v go >/dev/null && echo "Go: $(go version | awk '{print $3}')"
  command -v rustc >/dev/null && echo "Rust: $(rustc --version | awk '{print $2}')"
  command -v java >/dev/null && echo "Java: $(java -version 2>&1 | head -1)"
}

# ═══════════════════════════════════════════════════════════════
# Tool Initializations
# ═══════════════════════════════════════════════════════════════

# Starship prompt (fallback if powerlevel10k fails)
if command -v starship >/dev/null 2>&1; then
  # Only use starship if powerlevel10k isn't working
  [[ "$ZSH_THEME" != "powerlevel10k/powerlevel10k" ]] && eval "$(starship init zsh)"
fi

# Zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

# FZF integration with Tokyo Night theme
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  # FZF colors (Tokyo Night theme matching LazyVim)
  export FZF_DEFAULT_OPTS="--color=fg:#a9b1d6,bg:#1a1b26,hl:#7aa2f7 --color=fg+:#c0caf5,bg+:#283457,hl+:#7dcfff --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a --border=rounded --height=40% --layout=reverse --preview-window=right:60%"
fi

# pipx completions
if command -v pipx >/dev/null 2>&1; then
  eval "$(register-python-argcomplete pipx)"
fi

# ═══════════════════════════════════════════════════════════════
# ZSH Vi Mode Configuration (to avoid conflicts)
# ═══════════════════════════════════════════════════════════════

# Set vi mode cursor styles
zvm_config() {
  ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_VI_HIGHLIGHT_BACKGROUND=#283457
  ZVM_VI_HIGHLIGHT_FOREGROUND=#c0caf5
}

# Vi mode indicator
function zvm_after_init() {
  # Bind custom keys after vi-mode loads
  bindkey '^R' fzf-history-widget
  bindkey '^T' fzf-file-widget
  bindkey '^[c' fzf-cd-widget
}

# ═══════════════════════════════════════════════════════════════
# Powerlevel10k Configuration
# ═══════════════════════════════════════════════════════════════

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ═══════════════════════════════════════════════════════════════
# Performance Optimizations
# ═══════════════════════════════════════════════════════════════

# History settings
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_BEEP
setopt APPEND_HISTORY
setopt SHARE_HISTORY

# Auto completion
setopt AUTO_CD
setopt GLOB_COMPLETE
setopt MENU_COMPLETE
setopt AUTO_LIST
setopt COMPLETE_IN_WORD

# Misc
setopt CORRECT
setopt MULTIOS
setopt PROMPT_SUBST

# ═══════════════════════════════════════════════════════════════
# Zellij Shortcuts Reference
# ═══════════════════════════════════════════════════════════════

# Show shortcuts on terminal start
show_shortcuts() {
  echo "🚀 \033[36mLazyVim + Nerd Font Environment Loaded!\033[0m"
  echo ""
  echo "🔑 \033[33mZellij Shortcuts (Leader: Ctrl+Space):\033[0m"
  echo "  • Panes: Ctrl+Space h/j/k/l (navigate), Ctrl+Space n/d/r (new), Ctrl+Space x (close)"
  echo "  • Tabs: Ctrl+Space 1-9 (switch), Ctrl+Space t (new), Ctrl+Space w (close)"
  echo "  • Modes: Ctrl+Space = (resize), Ctrl+Space m (move), Ctrl+Space s (scroll)"
  echo ""
  echo "📝 \033[33mUseful Commands:\033[0m"
  echo "  • zd (dev layout), fe (fuzzy edit), v (nvim), lg (lazygit)"
  echo "  • init-project <name> [type], run <file>, sysinfo"
  echo ""
}

# Only show shortcuts in interactive shells
if [[ $- == *i* ]]; then
  show_shortcuts
fi
