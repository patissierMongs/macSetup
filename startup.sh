#!/usr/bin/env bash
# macSetup DEFAULT startup script - Essential packages only

# =============== Colors ===============
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; MAGENTA='\033[0;35m'; CYAN='\033[0;36m'; NC='\033[0m'

# =============== Feature Flags (Defaults) ===============
# 병렬 다운로드(prefetch) 기본 ON
PARALLEL_DOWNLOADS="${PARALLEL_DOWNLOADS:-1}"      # 1 = brew fetch (formula/cask) 병렬
DL_JOBS="${DL_JOBS:-6}"

# 아래 둘은 기본 OFF (필요시 1로)
PIPX_PREFETCH="${PIPX_PREFETCH:-0}"                # 1 = pip download 병렬 후 오프라인 설치 시도
NPM_PREFETCH="${NPM_PREFETCH:-0}"                  # 1 = npm tarball 병렬 prefetch

INSTALL_RUST_CARGO_DUPES="${INSTALL_RUST_CARGO_DUPES:-0}"
CREATE_NVIM_PY_VENV="${CREATE_NVIM_PY_VENV:-1}"
TS_RUNNER="${TS_RUNNER:-ts-node}"

# =============== Paths ===============
BACKUP_TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="$HOME/.config_backup_${BACKUP_TIMESTAMP}"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PREFETCH_DIR="$HOME/.cache/macsetup-prefetch"
mkdir -p "$BACKUP_DIR" "$PREFETCH_DIR"

# =============== Logging Helpers ===============
log_info()  { echo -e "${BLUE}[INFO]${NC} $*"; }
log_ok()    { echo -e "${GREEN}[OK]${NC} $*"; }
log_warn()  { echo -e "${YELLOW}[WARN]${NC} $*"; }
log_err()   { echo -e "${RED}[ERR]${NC} $*"; }

echo -e "${CYAN}══════════════════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}   macOS Development Environment Auto-Configuration (DEFAULT)${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}병렬 다운로드(prefetch) 기본 활성화: PARALLEL_DOWNLOADS=$PARALLEL_DOWNLOADS (DL_JOBS=$DL_JOBS)${NC}"

# =============== Backup + Link ===============
backup_and_link() {
  local source="$1" target="$2"
  if [ -L "$target" ]; then
    local cur
    cur="$(readlink "$target")"
    if [ "$cur" = "$source" ]; then
      log_ok "Skip (already linked): $target"
      return 0
    fi
  fi
  if [ -e "$target" ] || [ -L "$target" ]; then
    log_warn "Backing up $target"
    local rel="${target#$HOME/}"
    mkdir -p "$BACKUP_DIR/$(dirname "$rel")"
    mv "$target" "$BACKUP_DIR/$rel" || log_err "Backup failed: $target"
  fi
  mkdir -p "$(dirname "$target")"
  ln -sf "$source" "$target" && log_ok "Linked $target" || log_err "Link failed: $target"
}

# =============== Step 1: Homebrew ===============
echo -e "\n${BLUE}[Step 1/10] Checking Homebrew...${NC}"
if ! command -v brew >/dev/null 2>&1; then
  log_warn "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || log_err "Homebrew install failed"
  if [[ -f "/opt/homebrew/bin/brew" ]]; then
    grep -q 'brew shellenv' "$HOME/.zprofile" 2>/dev/null || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
else
  log_ok "Homebrew present"
fi

# =============== Step 2: Brew Packages ===============
echo -e "\n${BLUE}[Step 2/10] Installing packages via Homebrew...${NC}"

FORMULAE=(
  # Core development tools
  git neovim wezterm zellij starship
  # Essential command line tools
  eza bat fd ripgrep fzf zoxide delta gh jq htop tree curl
  # Programming languages and tools
  python@3.12 pipx gcc cmake node rust go openjdk
  # Debugging tools
  llvm gdb
  # Language servers (essential ones only)
  lua-language-server rust-analyzer typescript-language-server pyright
  # Database (lightweight)
  sqlite
  # Version control and formatting
  lazygit shfmt shellcheck
)

CASKS=(
  # Core applications
  nikitabobko/tap/aerospace raycast visual-studio-code font-jetbrains-mono-nerd-font
)

# Filter out comments and check existing packages
filtered_formulae=()
for f in "${FORMULAE[@]}"; do
  [[ "$f" =~ ^[[:space:]]*# ]] && continue  # Skip comments
  [[ -z "$f" ]] && continue                 # Skip empty lines
  filtered_formulae+=("$f")
done

missing_formulae=()
for f in "${filtered_formulae[@]}"; do
  if brew list --versions "$f" >/dev/null 2>&1; then
    log_ok "Formula exists: $f"
  else
    missing_formulae+=("$f")
  fi
done

missing_casks=()
for c in "${CASKS[@]}"; do
  if brew list --cask --versions "$c" >/dev/null 2>&1; then
    log_ok "Cask exists: $c"
  else
    missing_casks+=("$c")
  fi
done

# --- Prefetch (parallel fetch) ---
if [ "$PARALLEL_DOWNLOADS" = "1" ]; then
  if ((${#missing_formulae[@]})); then
    log_info "Parallel fetching ${#missing_formulae[@]} formulae (jobs=$DL_JOBS)"
    printf '%s\n' "${missing_formulae[@]}" | xargs -P "$DL_JOBS" -n 1 bash -c 'brew fetch --formula "$0" >/dev/null 2>&1 || exit 0'
  else
    log_ok "No formulae need fetching"
  fi
  if ((${#missing_casks[@]})); then
    log_info "Parallel fetching ${#missing_casks[@]} casks (jobs=$DL_JOBS)"
    printf '%s\n' "${missing_casks[@]}" | xargs -P "$DL_JOBS" -n 1 bash -c 'brew fetch --cask "$0" >/dev/null 2>&1 || exit 0'
  else
    log_ok "No casks need fetching"
  fi
else
  log_info "PARALLEL_DOWNLOADS disabled; skipping prefetch"
fi

# --- Install (sequential with better error handling) ---
if ((${#missing_formulae[@]})); then
  log_info "Installing formulae (cached bottles expected)"
  failed_formulae=()
  for formula in "${missing_formulae[@]}"; do
    if brew install "$formula" >/dev/null 2>&1; then
      log_ok "Installed: $formula"
    else
      log_warn "Failed: $formula"
      failed_formulae+=("$formula")
    fi
  done
  if ((${#failed_formulae[@]})); then
    log_warn "Failed formulae: ${failed_formulae[*]}"
  fi
else
  log_ok "All formulae already installed"
fi

if ((${#missing_casks[@]})); then
  log_info "Installing casks"
  failed_casks=()
  for cask in "${missing_casks[@]}"; do
    if brew install --cask "$cask" >/dev/null 2>&1; then
      log_ok "Installed: $cask"
    else
      log_warn "Failed: $cask"
      failed_casks+=("$cask")
    fi
  done
  if ((${#failed_casks[@]})); then
    log_warn "Failed casks: ${failed_casks[*]}"
  fi
else
  log_ok "All casks already installed"
fi

# =============== Step 3: Oh My Zsh & Plugins ===============
echo -e "\n${BLUE}[Step 3/10] Setting up Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  log_warn "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || log_err "Oh My Zsh install failed"
else
  log_ok "Oh My Zsh present"
fi
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
clone_plugin() {
  local url="$1" dest="$2"
  if [ ! -d "$dest" ]; then
    git clone --depth=1 "$url" "$dest" >/dev/null 2>&1 && log_ok "Cloned $(basename "$dest")" || log_warn "Clone failed $(basename "$dest")"
  else
    log_ok "Exists: $(basename "$dest")"
  fi
}
clone_plugin https://github.com/zsh-users/zsh-autosuggestions     "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_plugin https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
clone_plugin https://github.com/zsh-users/zsh-completions         "$ZSH_CUSTOM/plugins/zsh-completions"
clone_plugin https://github.com/jeffreytse/zsh-vi-mode            "$ZSH_CUSTOM/plugins/zsh-vi-mode"
clone_plugin https://github.com/romkatv/powerlevel10k             "$ZSH_CUSTOM/themes/powerlevel10k"

# =============== Step 4: Python & pipx (prefetch optional) ===============
echo -e "\n${BLUE}[Step 4/10] Python tooling (pipx)...${NC}"
if command -v pipx >/dev/null 2>&1; then
  pipx ensurepath >/dev/null 2>&1
else
  log_err "pipx missing."
fi

PYTHON_TOOLS=(
  poetry black ruff pytest virtualenv debugpy
)

# Go tools installation (if Go is available)
if command -v go >/dev/null 2>&1; then
  log_info "Installing Go debugging tools"
  go install github.com/go-delve/delve/cmd/dlv@latest >/dev/null 2>&1 && log_ok "delve installed" || log_warn "delve install failed"
fi

if [ "$PIPX_PREFETCH" = "1" ]; then
  log_info "Prefetching pip packages (parallel) → $PREFETCH_DIR/pipx"
  mkdir -p "$PREFETCH_DIR/pipx"
  export PIP_NO_CACHE_DIR=off
  printf '%s\n' "${PYTHON_TOOLS[@]}" | xargs -P "$DL_JOBS" -n 1 python3 -m pip download -q -d "$PREFETCH_DIR/pipx" || true
  pipx_install() {
    local pkg="$1"
    if pipx list 2>/dev/null | grep -E "^[[:space:]]*$pkg " >/dev/null 2>&1; then
      log_ok "pipx: $pkg"
    else
      pipx install "$pkg" --pip-args="--no-index --find-links $PREFETCH_DIR/pipx" >/dev/null 2>&1 \
        && log_ok "pipx installed $pkg" || log_warn "pipx failed $pkg"
    fi
  }
else
  pipx_install() {
    local pkg="$1"
    if pipx list 2>/dev/null | grep -E "^[[:space:]]*$pkg " >/dev/null 2>&1; then
      log_ok "pipx: $pkg"
    else
      pipx install "$pkg" >/dev/null 2>&1 && log_ok "pipx installed $pkg" || log_warn "pipx failed $pkg"
    fi
  }
fi

for t in "${PYTHON_TOOLS[@]}"; do
  pipx_install "$t"
done

# =============== Step 5: Neovim (LazyVim) ===============
echo -e "\n${BLUE}[Step 5/10] Setting up LazyVim...${NC}"
backup_and_link "$SCRIPT_DIR/config/lazyvim" "$HOME/.config/nvim"

if [ "$CREATE_NVIM_PY_VENV" = "1" ]; then
  NVIM_PY_VENV="$HOME/.local/share/nvim/py3-venv"
  if [ ! -d "$NVIM_PY_VENV" ]; then
    log_info "Creating Neovim python venv"
    python3 -m venv "$NVIM_PY_VENV" 2>/dev/null || log_warn "venv create failed"
    if [ -x "$NVIM_PY_VENV/bin/python" ]; then
      "$NVIM_PY_VENV/bin/python" -m pip install --upgrade pip pynvim >/dev/null 2>&1 || log_warn "pynvim install failed"
      grep -q NVIM_PYTHON_HOST_PROG "$HOME/.zshenv" 2>/dev/null || echo "export NVIM_PYTHON_HOST_PROG=\"$NVIM_PY_VENV/bin/python\"" >> "$HOME/.zshenv"
    fi
  else
    log_ok "Neovim python venv exists"
  fi
fi
if command -v npm >/dev/null 2>&1; then
  npm list -g neovim >/dev/null 2>&1 || npm install -g neovim >/dev/null 2>&1 || log_warn "npm neovim install failed"
fi
if command -v gem >/dev/null 2>&1; then
  gem install neovim >/dev/null 2>&1 || log_warn "Ruby neovim gem failed"
fi

# =============== Step 6: Dotfiles ===============
echo -e "\n${BLUE}[Step 6/10] Linking dotfiles...${NC}"
backup_and_link "$SCRIPT_DIR/dotfiles/zsh/.zshrc"              "$HOME/.zshrc"
backup_and_link "$SCRIPT_DIR/dotfiles/zsh/.zshenv"             "$HOME/.zshenv"
backup_and_link "$SCRIPT_DIR/dotfiles/zsh/.zprofile"           "$HOME/.zprofile"
backup_and_link "$SCRIPT_DIR/dotfiles/git/.gitconfig"          "$HOME/.gitconfig"
backup_and_link "$SCRIPT_DIR/dotfiles/git/.gitignore_global"   "$HOME/.gitignore_global"
backup_and_link "$SCRIPT_DIR/dotfiles/vim/.vimrc"              "$HOME/.vimrc"
backup_and_link "$SCRIPT_DIR/config/wezterm"                   "$HOME/.config/wezterm"
backup_and_link "$SCRIPT_DIR/config/zellij"                    "$HOME/.config/zellij"
backup_and_link "$SCRIPT_DIR/config/aerospace"                 "$HOME/.config/aerospace"
backup_and_link "$SCRIPT_DIR/config/starship/starship.toml"    "$HOME/.config/starship.toml"

# =============== Step 7: VS Code ===============
echo -e "\n${BLUE}[Step 7/10] VS Code setup...${NC}"
if command -v code >/dev/null 2>&1; then
  VSCODE_EXTS=(
    ms-python.python ms-python.vscode-pylance vscodevim.vim
    ms-vscode.cpptools vscjava.vscode-java-pack
    eamodio.gitlens esbenp.prettier-vscode
  )
  for e in "${VSCODE_EXTS[@]}"; do
    code --install-extension "$e" >/dev/null 2>&1 || log_warn "Ext fail: $e"
  done
  if [ "$(uname)" = "Darwin" ]; then
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_USER_DIR"
    backup_and_link "$SCRIPT_DIR/config/vscode/settings.json"    "$VSCODE_USER_DIR/settings.json"
    backup_and_link "$SCRIPT_DIR/config/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
  fi
else
  log_warn "'code' CLI not found, skipping VS Code extensions"
fi

# =============== Step 8: Node Global Packages (prefetch optional) ===============
echo -e "\n${BLUE}[Step 8/10] Global Node packages...${NC}"
if command -v npm >/dev/null 2>&1; then
  NPM_PACKAGES=(
    typescript ts-node nodemon eslint prettier
  )
  if [ "$NPM_PREFETCH" = "1" ]; then
    log_info "Prefetching npm tarballs (parallel) → $PREFETCH_DIR/npm"
    mkdir -p "$PREFETCH_DIR/npm"
    get_tarball() { npm view "$1" dist.tarball 2>/dev/null; }
    > "$PREFETCH_DIR/npm/url.list"
    for p in "${NPM_PACKAGES[@]}"; do get_tarball "$p" >> "$PREFETCH_DIR/npm/url.list"; done
    sort -u "$PREFETCH_DIR/npm/url.list" -o "$PREFETCH_DIR/npm/url.list"
    cat "$PREFETCH_DIR/npm/url.list" | xargs -P "$DL_JOBS" -n 1 bash -c 'u="$0"; f="$PREFETCH_DIR/npm/$(basename "$u")"; [ -f "$f" ] || curl -sSL "$u" -o "$f"' || true
    for p in "${NPM_PACKAGES[@]}"; do
      npm install -g "$p" >/dev/null 2>&1 && log_ok "npm $p" || log_warn "npm fail $p"
    done
  else
    for p in "${NPM_PACKAGES[@]}"; do
      npm install -g "$p" >/dev/null 2>&1 && log_ok "npm $p" || log_warn "npm fail $p"
    done
  fi
else
  log_warn "npm missing, skip Node global packages"
fi

# =============== Step 9: Java ===============
echo -e "\n${BLUE}[Step 9/10] Java environment...${NC}"
if [ ! -f "$HOME/.java_home" ]; then
  {
    echo 'export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null || echo "")'
    echo '[ -n "$JAVA_HOME" ] && export PATH=$JAVA_HOME/bin:$PATH'
  } > "$HOME/.java_home"
  grep -q '.java_home' "$HOME/.zshrc" 2>/dev/null || echo '[ -f "$HOME/.java_home" ] && source "$HOME/.java_home"' >> "$HOME/.zshrc"
  log_ok "JAVA_HOME helper created"
else
  log_ok ".java_home exists"
fi

# =============== Step 10: Finalization ===============
echo -e "\n${BLUE}[Step 10/10] Finalizing...${NC}"
log_info "Creating development directories"
mkdir -p "$HOME/Developer"/{projects,scripts,temp,sandbox}
mkdir -p "$HOME/.local/bin"

# fzf script
if [ -f /opt/homebrew/opt/fzf/install ]; then
  /opt/homebrew/opt/fzf/install --all --no-bash --no-fish >/dev/null 2>&1
elif [ -f /usr/local/opt/fzf/install ]; then
  /usr/local/opt/fzf/install --all --no-bash --no-fish >/dev/null 2>&1
fi

# Optional cargo duplicates
if command -v cargo >/dev/null 2>&1; then
  if [ "$INSTALL_RUST_CARGO_DUPES" = "1" ]; then
    log_warn "Installing duplicate Rust tools via cargo"
    for c in bat ripgrep fd-find delta starship zoxide; do
      cargo install --locked "$c" >/dev/null 2>&1 || true
    done
  else
    log_info "Skip cargo duplicates (INSTALL_RUST_CARGO_DUPES=1 to enable)"
  fi
fi

echo -e "${CYAN}══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}                    Setup Complete! 🎉${NC}"
echo -e "${CYAN}══════════════════════════════════════════════════════════════${NC}"

echo -e "${YELLOW}Next Steps:${NC}"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Open Neovim and let plugins sync: nvim"
echo "  3. Start AeroSpace: brew services start aerospace"
echo "  4. Optional services: brew services start postgresql@16 redis mysql"
echo ""

echo -e "${BLUE}Key Commands to Remember:${NC}"
echo "  • Zellij layouts: zellij -l dev|minimal|dotfiles"
echo "  • File search: fe (fuzzy find + edit)"
echo "  • Directory nav: fd-cd (fuzzy directory change)"
echo "  • Git log: fzf-git-log"
echo "  • Process manager: pf"
echo "  • Project init: init-project <name> [python|node|go|rust|java]"
echo "  • Quick compile: run <filename>"
echo "  • System info: sysinfo"
echo ""

echo -e "${MAGENTA}Config Locations:${NC}"
echo "  • Neovim: ~/.config/nvim/"
echo "  • Zellij: ~/.config/zellij/"
echo "  • WezTerm: ~/.config/wezterm/"
echo "  • AeroSpace: ~/.config/aerospace/"
echo "  • Starship: ~/.config/starship.toml"
echo ""

echo -e "${CYAN}Backups saved to:${NC} $BACKUP_DIR"
echo -e "${GREEN}Happy coding! 🚀✨${NC}"
