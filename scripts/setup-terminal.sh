#!/bin/bash
# setup-terminal.sh — Install and configure terminal tools, shell prompt, and iTerm2
set -e

echo "==> Setting up terminal environment..."

# Check for Homebrew
if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is required. Install it first:"
  echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# Install iTerm2
echo "==> Installing iTerm2..."
brew install --cask iterm2

# Install Nerd Font
echo "==> Installing JetBrains Mono Nerd Font..."
brew install --cask font-jetbrains-mono-nerd-font

# Install all CLI tools
echo "==> Installing CLI tools..."
brew install starship eza bat fd ripgrep zoxide fzf git-delta lazygit btop tldr thefuck zsh-autosuggestions zsh-syntax-highlighting

# Configure Starship prompt (Kanagawa-inspired)
echo "==> Configuring Starship prompt..."
mkdir -p ~/.config
cat > ~/.config/starship.toml << 'STARSHIP'
# Kanagawa-inspired Starship prompt

format = """
$directory\
$git_branch\
$git_status\
$nodejs\
$python\
$rust\
$golang\
$docker_context\
$cmd_duration\
$line_break\
$character"""

[directory]
style = "bold #7E9CD8"
truncation_length = 3
truncate_to_repo = true

[git_branch]
style = "bold #957FB8"
symbol = " "

[git_status]
style = "#DCA561"
ahead = "⇡${count}"
behind = "⇣${count}"
diverged = "⇕⇡${ahead_count}⇣${behind_count}"
modified = "!${count}"
untracked = "?${count}"
staged = "+${count}"

[character]
success_symbol = "[❯](bold #76946A)"
error_symbol = "[❯](bold #C34043)"

[cmd_duration]
style = "#727169"
min_time = 2_000
format = "took [$duration]($style) "

[nodejs]
style = "#98BB6C"
symbol = " "

[python]
style = "#E6C384"
symbol = " "

[rust]
style = "#FF5D62"
symbol = " "

[golang]
style = "#7FB4CA"
symbol = " "

[docker_context]
style = "#7FB4CA"
symbol = " "
STARSHIP

# Configure bat
echo "==> Configuring bat..."
mkdir -p ~/.config/bat
echo '--theme="TwoDark"' > ~/.config/bat/config

# Configure git-delta
echo "==> Configuring git-delta..."
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "TwoDark"
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
echo "Manual iTerm2 steps:"
echo "  1. Set font: Settings > Profiles > Text > Font > JetBrainsMono Nerd Font (size 13-14)"
echo "  2. Import Kanagawa colors: Settings > Profiles > Colors > Color Presets > Import"
echo "     (Download kanagawa_wave.itermcolors from https://github.com/rebelot/kanagawa.nvim/tree/master/extras)"
echo "  3. Set theme: Settings > Appearance > Theme > Minimal"
echo "  4. Set keys: Settings > Profiles > Keys > Presets > Natural Text Editing"
echo "  5. Optional: Settings > Profiles > Window > Transparency 10-15%"
echo ""
echo "Restart your terminal or run: source ~/.zshrc"
