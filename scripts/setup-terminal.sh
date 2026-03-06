#!/bin/bash
# setup-terminal.sh — Install and configure terminal tools, shell prompt, and Ghostty
set -e

echo "==> Setting up terminal environment..."

# Check for Homebrew
if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is required. Install it first:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# Install Ghostty
echo "==> Installing Ghostty..."
brew install --cask ghostty

# Install Nerd Font
echo "==> Installing JetBrains Mono Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font

# Install all CLI tools
echo "==> Installing CLI tools..."
brew install starship eza bat fd ripgrep zoxide fzf git-delta lazygit btop tldr thefuck zsh-autosuggestions zsh-syntax-highlighting

# Configure Ghostty
echo "==> Configuring Ghostty..."
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
cat > "$GHOSTTY_DIR/config" << 'GHOSTTY'
# Theme
theme = Catppuccin Mocha

# Font
font-family = JetBrainsMono Nerd Font
font-size = 14

# Window
macos-titlebar-style = transparent
window-padding-x = 8
window-padding-y = 4
background-opacity = 0.95
background-blur-radius = 20

# Cursor
cursor-style = bar
cursor-style-blink = true

# Scrollback
scrollback-limit = 10000

# Shell integration
shell-integration = zsh

# Mouse
mouse-hide-while-typing = true

# Clipboard
clipboard-read = allow
clipboard-write = allow
copy-on-select = true
GHOSTTY

# Configure Starship prompt (Catppuccin powerline)
echo "==> Configuring Starship prompt..."
mkdir -p ~/.config
starship preset catppuccin-powerline -o ~/.config/starship.toml

# Configure bat
echo "==> Configuring bat..."
mkdir -p ~/.config/bat
echo '--theme="Catppuccin Mocha"' > ~/.config/bat/config

# Configure git-delta
echo "==> Configuring git-delta..."
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "Catppuccin Mocha"
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

# Configure global gitignore
echo "==> Configuring global gitignore..."
git config --global core.excludesfile ~/.gitignore_global
touch ~/.gitignore_global
grep -qxF 'CLAUDE.md' ~/.gitignore_global || echo 'CLAUDE.md' >> ~/.gitignore_global
grep -qxF '.claude/' ~/.gitignore_global || echo '.claude/' >> ~/.gitignore_global

# Add shell configuration to .zshrc
ZSHRC=~/.zshrc
if ! grep -q "starship init zsh" "$ZSHRC" 2>/dev/null; then
  echo "==> Adding shell configuration to ~/.zshrc..."
  cat >> "$ZSHRC" << 'ZSHCONFIG'

# --- Terminal Setup (auto-generated) ---

# Starship prompt
eval "$(starship init zsh)"

# Zoxide (smart cd)
eval "$(zoxide init zsh)"

# fzf keybindings & completion (Ctrl+R history, Ctrl+T files)
source <(fzf --zsh)

# thefuck (corrects previous command)
eval $(thefuck --alias)

# Zsh plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Better CLI aliases
alias ls="eza --icons --git"
alias ll="eza --icons --git -la"
alias la="eza --icons --git -a"
alias lt="eza --icons --git --tree --level=2"
alias cat="bat"
alias cd="z"
ZSHCONFIG
else
  echo "==> Shell configuration already present in ~/.zshrc, skipping."
fi

echo ""
echo "==> Terminal setup complete!"
echo ""
echo "Open Ghostty to start using your new terminal."
echo "Restart your shell or run: source ~/.zshrc"
