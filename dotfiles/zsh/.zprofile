# ═══════════════════════════════════════════════════════════════
# ZSH Profile Configuration
# ═══════════════════════════════════════════════════════════════

# Homebrew initialization
if [[ -f "/opt/homebrew/bin/brew" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Java environment
if [ -f "$HOME/.java_home" ]; then
  source "$HOME/.java_home"
fi