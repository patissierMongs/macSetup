#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${MAGENTA}       macOS Development Environment Auto-Configuration${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}\n"

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"

# Function to create backup and link
backup_and_link() {
    local source=$1
    local target=$2
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        echo -e "${YELLOW}  Backing up existing $target${NC}"
        mkdir -p "$(dirname "$BACKUP_DIR/${target#$HOME/}")"
        mv "$target" "$BACKUP_DIR/${target#$HOME/}"
    fi
    
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    echo -e "${GREEN}  ✓ Linked $target${NC}"
}

# ════════════════════════════════════════════════════════════════
# Install Homebrew if not installed
# ════════════════════════════════════════════════════════════════
echo -e "${BLUE}[Step 1/10] Checking Homebrew...${NC}"
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ -f "/opt/homebrew/bin/brew" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}  ✓ Homebrew already installed${NC}"
fi

# ════════════════════════════════════════════════════════════════
# Install packages via Homebrew
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 2/10] Installing packages via Homebrew...${NC}"

# Core development tools
FORMULAE=(
    "git"
    "neovim"
    "wezterm"
    "zellij"
    "starship"
    "eza"           # Modern replacement for ls
    "bat"           # Better cat with syntax highlighting
    "fd"            # Better find
    "ripgrep"       # Better grep
    "fzf"           # Fuzzy finder
    "zoxide"        # Smarter cd command
    "delta"         # Better git diff
    "gh"            # GitHub CLI
    "jq"            # JSON processor
    "tldr"          # Simplified man pages
    "htop"          # Better top
    "ncdu"          # Disk usage analyzer
    "tree"          # Directory tree viewer
    "wget"          # Download tool
    "curl"          # Transfer tool
    "tmux"          # Terminal multiplexer (backup for zellij)
    "lazygit"       # Terminal UI for git
    "lazydocker"    # Terminal UI for docker
    "glow"          # Markdown renderer
    "httpie"        # Better curl for APIs
    "dust"          # Better du
    "duf"           # Better df
    "broot"         # Better tree/navigation
    "procs"         # Better ps
    "sd"            # Better sed
    "choose"        # Better cut/awk
    "tokei"         # Code statistics
    "hyperfine"     # Command-line benchmarking
    "gping"         # Ping with graph
    "bandwhich"     # Network utilization
    
    # Programming languages and tools
    "python@3.12"
    "pipx"
    "pyenv"
    "gcc"
    "cmake"
    "llvm"
    "openjdk"
    "maven"
    "gradle"
    "node"
    "yarn"
    "pnpm"
    "rust"
    "go"
    
    # Language servers and debuggers for Neovim
    "lua-language-server"
    "rust-analyzer"
    "gopls"
    "typescript-language-server"
    "pyright"
    "ruff"
    "ruff-lsp"
    "black"
    "isort"
    "stylua"
    "shfmt"
    "shellcheck"
    
    # Database tools
    "postgresql@16"
    "mysql"
    "redis"
    "sqlite"
    
    # Container tools
    "docker"
    "docker-compose"
    "podman"
    "kubectl"
    "k9s"
    "helm"
    
    # Additional useful tools
    "yq"            # YAML processor
    "watchman"      # File watching service
    "direnv"        # Directory-specific environment
    "asdf"          # Version manager
)

CASKS=(
    "aerospace"     # Tiling window manager
    "raycast"       # Spotlight replacement
    "visual-studio-code"
    "font-jetbrains-mono-nerd-font"
    "docker"        # Docker Desktop
    "iterm2"        # Backup terminal
    "alt-tab"       # Better app switcher
    "monitorcontrol" # External monitor brightness
    "stats"         # System monitor in menu bar
    "hiddenbar"     # Menu bar organizer
    "rectangle"     # Window management (backup for aerospace)
)

# Install formulae
for formula in "${FORMULAE[@]}"; do
    if brew list --formula | grep -q "^${formula%@*}\$"; then
        echo -e "${GREEN}  ✓ $formula already installed${NC}"
    else
        echo -e "${YELLOW}  Installing $formula...${NC}"
        brew install "$formula" 2>/dev/null || echo -e "${YELLOW}  ⚠ $formula might already be installed or unavailable${NC}"
    fi
done

# Install casks
for cask in "${CASKS[@]}"; do
    if brew list --cask | grep -q "^$cask\$"; then
        echo -e "${GREEN}  ✓ $cask already installed${NC}"
    else
        echo -e "${YELLOW}  Installing $cask...${NC}"
        brew install --cask "$cask" 2>/dev/null || echo -e "${YELLOW}  ⚠ $cask might already be installed or unavailable${NC}"
    fi
done

# ════════════════════════════════════════════════════════════════
# Install Oh My Zsh
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 3/10] Setting up Oh My Zsh...${NC}"
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${YELLOW}Installing Oh My Zsh...${NC}"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo -e "${GREEN}  ✓ Oh My Zsh already installed${NC}"
fi

# Install Zsh plugins
echo -e "${YELLOW}Installing Zsh plugins...${NC}"
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# zsh-completions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-completions" ]; then
    git clone https://github.com/zsh-users/zsh-completions $ZSH_CUSTOM/plugins/zsh-completions
fi

# fast-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ]; then
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH_CUSTOM/plugins/fast-syntax-highlighting
fi

# zsh-vi-mode
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-vi-mode" ]; then
    git clone https://github.com/jeffreytse/zsh-vi-mode $ZSH_CUSTOM/plugins/zsh-vi-mode
fi

# Install Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# ════════════════════════════════════════════════════════════════
# Setup Python development tools
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 4/10] Setting up Python development tools...${NC}"

# Install Python packages via pipx
PYTHON_TOOLS=(
    "poetry"
    "black"
    "isort"
    "mypy"
    "pylint"
    "flake8"
    "pytest"
    "tox"
    "pre-commit"
    "jupyterlab"
    "ipython"
    "httpie"
    "pgcli"
    "mycli"
    "litecli"
    "cookiecutter"
    "pipenv"
    "virtualenv"
    "debugpy"
)

for tool in "${PYTHON_TOOLS[@]}"; do
    if pipx list | grep -q "$tool"; then
        echo -e "${GREEN}  ✓ $tool already installed${NC}"
    else
        echo -e "${YELLOW}  Installing $tool...${NC}"
        pipx install "$tool" 2>/dev/null || echo -e "${YELLOW}  ⚠ Failed to install $tool${NC}"
    fi
done

# ════════════════════════════════════════════════════════════════
# Setup Neovim (LazyVim)
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 5/10] Setting up LazyVim...${NC}"

# Backup existing Neovim config
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
    echo -e "${YELLOW}  Backing up existing Neovim configuration...${NC}"
    mv "$HOME/.config/nvim" "$BACKUP_DIR/nvim"
fi

# Link LazyVim configuration
backup_and_link "$SCRIPT_DIR/config/lazyvim" "$HOME/.config/nvim"

# Install Neovim providers
echo -e "${YELLOW}Installing Neovim providers...${NC}"
pip3 install --user --upgrade pynvim
npm install -g neovim
gem install neovim 2>/dev/null || echo -e "${YELLOW}  ⚠ Ruby provider not installed${NC}"

# ════════════════════════════════════════════════════════════════
# Create symbolic links for dotfiles
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 6/10] Linking configuration files...${NC}"

# Link all configuration files
backup_and_link "$SCRIPT_DIR/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
backup_and_link "$SCRIPT_DIR/dotfiles/zsh/.zshenv" "$HOME/.zshenv"
backup_and_link "$SCRIPT_DIR/dotfiles/zsh/.zprofile" "$HOME/.zprofile"
backup_and_link "$SCRIPT_DIR/dotfiles/git/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$SCRIPT_DIR/dotfiles/git/.gitignore_global" "$HOME/.gitignore_global"
backup_and_link "$SCRIPT_DIR/dotfiles/vim/.vimrc" "$HOME/.vimrc"
backup_and_link "$SCRIPT_DIR/config/wezterm" "$HOME/.config/wezterm"
backup_and_link "$SCRIPT_DIR/config/zellij" "$HOME/.config/zellij"
backup_and_link "$SCRIPT_DIR/config/aerospace" "$HOME/.config/aerospace"
backup_and_link "$SCRIPT_DIR/config/starship/starship.toml" "$HOME/.config/starship.toml"

# ════════════════════════════════════════════════════════════════
# Setup VS Code
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 7/10] Configuring VS Code...${NC}"

# Install VS Code extensions
code --install-extension ms-python.python 2>/dev/null
code --install-extension ms-python.vscode-pylance 2>/dev/null
code --install-extension ms-python.debugpy 2>/dev/null
code --install-extension ms-vscode.cpptools 2>/dev/null
code --install-extension vscjava.vscode-java-pack 2>/dev/null
code --install-extension vscodevim.vim 2>/dev/null
code --install-extension GitHub.copilot 2>/dev/null
code --install-extension eamodio.gitlens 2>/dev/null
code --install-extension PKief.material-icon-theme 2>/dev/null
code --install-extension zhuangtongfa.material-theme 2>/dev/null
code --install-extension ms-vscode-remote.remote-ssh 2>/dev/null
code --install-extension ms-azuretools.vscode-docker 2>/dev/null
code --install-extension redhat.vscode-yaml 2>/dev/null
code --install-extension esbenp.prettier-vscode 2>/dev/null

# Link VS Code settings
if [ "$(uname)" = "Darwin" ]; then
    VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_USER_DIR"
    backup_and_link "$SCRIPT_DIR/config/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
    backup_and_link "$SCRIPT_DIR/config/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
fi

# ════════════════════════════════════════════════════════════════
# Install additional tools via npm
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 8/10] Installing Node.js global packages...${NC}"

NPM_PACKAGES=(
    "typescript"
    "ts-node"
    "nodemon"
    "eslint"
    "prettier"
    "jest"
    "@angular/cli"
    "@vue/cli"
    "create-react-app"
    "vercel"
    "netlify-cli"
    "firebase-tools"
    "pm2"
    "serve"
    "live-server"
    "json-server"
)

for package in "${NPM_PACKAGES[@]}"; do
    echo -e "${YELLOW}  Installing $package...${NC}"
    npm install -g "$package" 2>/dev/null || echo -e "${YELLOW}  ⚠ Failed to install $package${NC}"
done

# ════════════════════════════════════════════════════════════════
# Setup Java development environment
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 9/10] Setting up Java development environment...${NC}"

# Set JAVA_HOME
echo -e "${YELLOW}Setting up JAVA_HOME...${NC}"
if [ ! -f "$HOME/.java_home" ]; then
    echo 'export JAVA_HOME=$(/usr/libexec/java_home)' > "$HOME/.java_home"
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> "$HOME/.java_home"
fi

# ════════════════════════════════════════════════════════════════
# Final setup and instructions
# ════════════════════════════════════════════════════════════════
echo -e "\n${BLUE}[Step 10/10] Finalizing setup...${NC}"

# Create development directories
echo -e "${YELLOW}Creating development directories...${NC}"
mkdir -p "$HOME/Developer/{projects,scripts,temp,sandbox}"
mkdir -p "$HOME/.local/bin"

# Setup fzf
echo -e "${YELLOW}Setting up fzf...${NC}"
if [ -f /opt/homebrew/opt/fzf/install ]; then
    /opt/homebrew/opt/fzf/install --all --no-bash --no-fish 2>/dev/null
elif [ -f /usr/local/opt/fzf/install ]; then
    /usr/local/opt/fzf/install --all --no-bash --no-fish 2>/dev/null
fi

# Install Rust tools
echo -e "${YELLOW}Installing Rust tools...${NC}"
if command -v cargo &> /dev/null; then
    cargo install --locked bat
    cargo install --locked exa
    cargo install --locked ripgrep
    cargo install --locked fd-find
    cargo install --locked starship
    cargo install --locked zoxide
    cargo install --locked delta
fi 2>/dev/null || echo -e "${YELLOW}  ⚠ Some Rust tools might already be installed${NC}"

echo -e "\n${CYAN}════════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}                    Setup Complete! 🎉${NC}"
echo -e "${CYAN}════════════════════════════════════════════════════════════════${NC}"

echo -e "\n${YELLOW}Important next steps:${NC}"
echo -e "  1. Restart your terminal or run: ${CYAN}source ~/.zshrc${NC}"
echo -e "  2. Launch Neovim and wait for plugins to install: ${CYAN}nvim${NC}"
echo -e "  3. Configure Raycast (open it from Applications)"
echo -e "  4. Start Aerospace window manager: ${CYAN}brew services start aerospace${NC}"
echo -e "  5. Test your setup with: ${CYAN}zellij${NC}"

echo -e "\n${MAGENTA}Backup location:${NC} $BACKUP_DIR"
echo -e "\n${GREEN}Happy coding! 🚀${NC}\n"
