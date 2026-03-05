# Terminal Setup Guide

Complete guide to setting up a customized, productive terminal environment on macOS. Uses a Kanagawa dark theme to match the Neovim configuration.

---

## Quick Setup (Automated)

Run the setup script to install and configure everything automatically:

```bash
./scripts/setup-terminal.sh
```

For Neovim setup:

```bash
./scripts/setup-neovim.sh
```

---

## 1. Install iTerm2

Download and install iTerm2 as a replacement for the default macOS Terminal:

```bash
brew install --cask iterm2
```

## 2. Install a Nerd Font

Nerd Fonts include icons used by many CLI tools (eza, starship, etc).

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

After installing, set it in iTerm2:
- **Settings > Profiles > Text > Font** — select **JetBrainsMono Nerd Font**, size 13-14

## 3. iTerm2 Configuration

### Kanagawa Color Scheme

The Kanagawa color scheme is available in the [kanagawa.nvim extras](https://github.com/rebelot/kanagawa.nvim/tree/master/extras). Download the `.itermcolors` file and import it:

1. Download `kanagawa_wave.itermcolors` from the repo's `extras/` folder
2. **Settings > Profiles > Colors > Color Presets > Import** — select the downloaded file
3. **Settings > Profiles > Colors > Color Presets** — select **kanagawa_wave**

### Recommended iTerm2 Settings

| Setting | Path | Value |
|---------|------|-------|
| Theme | Settings > Appearance > Theme | **Minimal** |
| Text editing | Settings > Profiles > Keys > Presets | **Natural Text Editing** |
| Transparency | Settings > Profiles > Window > Transparency | **10-15%** |
| Background blur | Settings > Profiles > Window > Blur | **Enabled** |

## 4. Shell Prompt

### Option A: Starship (Recommended)

A fast, customizable, cross-shell prompt with git status, language versions, and icons.

```bash
brew install starship
```

Add to `~/.zshrc`:

```bash
eval "$(starship init zsh)"
```

See [Section 6](#6-starship-prompt-configuration) for the full Kanagawa-themed config.

### Option B: Powerlevel10k

A feature-rich zsh theme with an interactive configuration wizard.

```bash
brew install powerlevel10k
echo 'source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
```

Then restart your terminal — the configuration wizard will launch automatically. Choose your preferred style (icons, colors, prompt segments). To reconfigure later:

```bash
p10k configure
```

> **Note:** If using Powerlevel10k, skip the Starship sections. Do not use both at the same time.

## 5. Shell Tools

### Install Everything

```bash
brew install starship eza bat fd ripgrep zoxide fzf git-delta lazygit btop tldr thefuck zsh-autosuggestions zsh-syntax-highlighting
```

### Tool Overview

| Tool | Replaces | Description |
|------|----------|-------------|
| **starship** | pure/oh-my-zsh prompt | Fast, customizable shell prompt with git status, language versions, icons |
| **eza** | `ls` | Modern file listing with colors, icons, git status, tree view |
| **bat** | `cat` | File viewer with syntax highlighting and line numbers |
| **fd** | `find` | Fast, user-friendly file search |
| **ripgrep** | `grep` | Extremely fast content search across files |
| **zoxide** | `cd` | Smart directory jumper that learns your most-used paths |
| **fzf** | — | Fuzzy finder for files, history, and anything else |
| **git-delta** | git's default pager | Syntax-highlighted, side-by-side git diffs |
| **lazygit** | — | Terminal UI for git with an intuitive interface |
| **btop** | `htop`/`top` | Beautiful system resource monitor |
| **tldr** | `man` | Simplified, example-based command documentation |
| **thefuck** | — | Auto-corrects your previous mistyped command |
| **zsh-autosuggestions** | — | Suggests commands as you type based on history |
| **zsh-syntax-highlighting** | — | Colors valid/invalid commands in real-time |

### Tool Commands

```bash
# eza — modern ls
eza --icons --git              # list files with icons and git status
eza --icons --git -la          # long listing, all files
eza --icons --git --tree       # tree view

# bat — syntax-highlighted cat
bat file.py                    # view file with highlighting
bat --diff file.py             # show git diff for file

# fd — fast find
fd "pattern"                   # find files matching pattern
fd -e py                       # find all .py files
fd -e js --exec wc -l          # find .js files and count lines

# ripgrep — fast grep
rg "pattern"                   # search file contents
rg "pattern" -t py             # search only python files
rg "pattern" -l                # list matching files only

# zoxide — smart cd
z projects                     # jump to most-used dir matching "projects"
z foo bar                      # jump to dir matching "foo" and "bar"
zi                             # interactive directory picker with fzf

# fzf — fuzzy finder
Ctrl+R                         # fuzzy search command history
Ctrl+T                         # fuzzy search files
Alt+C                          # fuzzy cd into subdirectory
vim $(fzf)                     # open fzf-selected file in vim

# git-delta — better diffs (automatic, configured as git pager)
git diff                       # shows syntax-highlighted diff
git log -p                     # shows highlighted patches
git show                       # highlighted commit details

# lazygit
lazygit                        # open the git TUI

# btop
btop                           # open system monitor

# tldr
tldr tar                       # show simplified examples for tar
tldr git-rebase                # show simplified examples for git-rebase

# thefuck — auto-correct mistakes
fuck                           # re-run previous command with correction
```

## 6. Zsh Configuration

Add the following to `~/.zshrc`:

```bash
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
```

## 7. Starship Prompt Configuration

Create `~/.config/starship.toml` with a Kanagawa-inspired theme:

```toml
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
```

## 8. Git Delta Configuration

Configure git to use delta as its pager:

```bash
git config --global core.pager delta
git config --global interactive.diffFilter "delta --color-only"
git config --global delta.navigate true
git config --global delta.dark true
git config --global delta.line-numbers true
git config --global delta.syntax-theme "TwoDark"
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default
```

## 9. Bat Configuration

Create `~/.config/bat/config`:

```
--theme="TwoDark"
```

This sets the default syntax highlighting theme for bat to match the dark Kanagawa aesthetic.
