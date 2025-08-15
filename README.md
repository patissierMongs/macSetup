# macOS Development Environment Setup 🚀

A comprehensive, modern terminal-based development environment for macOS with minimal mouse usage.

## 🎯 Features

- **Terminal Multiplexing**: WezTerm + Zellij for advanced terminal management
- **Window Management**: AeroSpace tiling window manager
- **Code Editors**: LazyVim (Neovim) as primary, VS Code as secondary
- **Shell**: Zsh with Oh My Zsh and powerful plugins
- **Version Control**: Git with LazyGit for TUI
- **Package Management**: Homebrew, npm, pip, cargo
- **Development Languages**: Python, C/C++, Java, JavaScript/TypeScript, Go, Rust
- **Containerization**: Docker, Kubernetes tools
- **Modern CLI Tools**: eza, bat, ripgrep, fd, fzf, zoxide, delta, and more

## 📦 Installation

### Quick Start

```bash
# Clone the repository
git clone https://github.com/patissierMongs/macSetup.git
cd macSetup

# Run the setup script
chmod +x startup.sh
./startup.sh
```

The script will:
1. Install Homebrew (if not installed)
2. Install all necessary packages and applications
3. Setup Oh My Zsh with plugins
4. Configure all dotfiles and applications
5. Create symbolic links to configuration files
6. Backup existing configurations

## ⌨️ Key Bindings

### Global (AeroSpace)

| Key | Action |
|-----|--------|
| `Alt + h/j/k/l` | Focus window left/down/up/right |
| `Alt + Shift + h/j/k/l` | Move window left/down/up/right |
| `Alt + Ctrl + h/j/k/l` | Resize window |
| `Alt + 1-9` | Switch to workspace 1-9 |
| `Alt + Shift + 1-9` | Move window to workspace 1-9 |
| `Alt + f` | Toggle fullscreen |
| `Alt + s` | Toggle layout (tiles/float) |
| `Alt + Shift + r` | Reload AeroSpace config |

### Zellij (Terminal Multiplexer)

| Key | Action |
|-----|--------|
| `Alt + n` | New pane |
| `Alt + d` | New pane down |
| `Alt + r` | New pane right |
| `Alt + x` | Close pane |
| `Alt + h/j/k/l` | Navigate panes |
| `Alt + t` | New tab |
| `Alt + Tab` | Next tab |
| `Alt + Shift + Tab` | Previous tab |
| `Alt + 1-9` | Go to tab 1-9 |
| `Alt + =` | Resize mode |
| `Alt + s` | Scroll mode |
| `Alt + /` | Search mode |
| `Ctrl + b` | Tmux mode (for compatibility) |

### Neovim (LazyVim)

| Key | Action |
|-----|--------|
| `Space` | Leader key |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Find buffers |
| `<leader>e` | File explorer |
| `<leader>gg` | LazyGit |
| `<leader>r` | Compile and run current file |
| `<leader>db` | Toggle breakpoint |
| `F5` | Start debugging |
| `F10` | Step over |
| `F11` | Step into |
| `F12` | Step out |
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Hover documentation |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename symbol |

### WezTerm

| Key | Action |
|-----|--------|
| `Cmd + d` | Split horizontal |
| `Cmd + Shift + d` | Split vertical |
| `Cmd + Alt + h/j/k/l` | Navigate panes |
| `Cmd + Shift + h/j/k/l` | Resize panes |
| `Cmd + 1-9` | Go to tab 1-9 |
| `Cmd + w` | Close pane |
| `Cmd + Shift + z` | Toggle zoom |

## 🛠 Included Tools

### Modern CLI Replacements
- `eza` → `ls` (with icons and git integration)
- `bat` → `cat` (with syntax highlighting)
- `ripgrep` → `grep` (faster and more user-friendly)
- `fd` → `find` (simpler and faster)
- `delta` → `diff` (better git diff)
- `zoxide` → `cd` (smarter directory jumping)
- `dust` → `du` (more intuitive disk usage)
- `duf` → `df` (better disk free)
- `procs` → `ps` (modern process viewer)
- `sd` → `sed` (simpler find and replace)
- `htop` → `top` (interactive process viewer)

### Development Tools
- **Python**: pyenv, poetry, black, pylint, pytest, jupyter
- **JavaScript/TypeScript**: node, npm, yarn, pnpm, eslint, prettier
- **Java**: OpenJDK, Maven, Gradle
- **C/C++**: GCC, Clang, LLVM, CMake
- **Go**: Go compiler, gopls
- **Rust**: Rust toolchain, rust-analyzer
- **Containers**: Docker, docker-compose, kubectl, k9s, helm
- **Databases**: PostgreSQL, MySQL, Redis, SQLite

## 🎨 Customization

### Themes
- Terminal: Tokyo Night
- Neovim: Tokyo Night
- VS Code: Tokyo Night
- Starship: Custom powerline theme

### Fonts
- JetBrains Mono Nerd Font (included in setup)

## 📁 Directory Structure

```
~/
├── .config/
│   ├── nvim/          # Neovim configuration
│   ├── wezterm/       # WezTerm configuration
│   ├── zellij/        # Zellij configuration
│   ├── aerospace/     # AeroSpace configuration
│   └── starship.toml  # Starship prompt
├── .zshrc             # Zsh configuration
├── .gitconfig         # Git configuration
└── Developer/         # Development projects
    ├── projects/
    ├── scripts/
    ├── temp/
    └── sandbox/
```

## 🔧 Troubleshooting

### Fonts not displaying correctly
```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
```

### Neovim plugins not loading
```bash
nvim
:Lazy sync
```

### Zsh plugins not working
```bash
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### AeroSpace not working
```bash
brew services restart aerospace
```

## 📝 Useful Commands

```bash
# Update all packages
brew update && brew upgrade

# Clean up old versions
brew cleanup

# Check system health
brew doctor

# Update npm packages
npm update -g

# Update pip packages
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 pip install -U

# Neovim health check
nvim +checkhealth
```

## 🤝 Contributing

Feel free to fork and submit pull requests!

## 📄 License

MIT License - Feel free to use and modify as needed.

## 🙏 Acknowledgments

- [LazyVim](https://www.lazyvim.org/)
- [Oh My Zsh](https://ohmyz.sh/)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [WezTerm](https://wezfurlong.org/wezterm/)
- [Zellij](https://zellij.dev/)
- All the amazing open source tool creators

---

**Happy Coding!** 🚀✨
