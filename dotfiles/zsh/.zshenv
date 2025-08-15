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
    /HOME/.cargo/bin
    $HOME/go/bin
    $HOME/.poetry/bin
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

# Language-specific environment
export PYTHON_CONFIGURE_OPTS="--enable-framework"
export PYTHONDONTWRITEBYTECODE=1
export PIPENV_VENV_IN_PROJECT=1
export POETRY_VIRTUALENVS_IN_PROJECT=true

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# GPG
export GPG_TTY=$(tty)