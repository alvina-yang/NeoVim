# Neovim Configuration

A fully-featured Neovim setup for macOS with LSP, autocompletion, fuzzy finding, git integration, and a modern UI.

> **Platform:** macOS only. These instructions assume you are on a Mac.

## What You Get

- Dashboard greeter with NEOVIM ASCII art and recent files
- File explorer sidebar with git status colors
- Fuzzy file/text search with Telescope
- LSP-powered autocompletion, go-to-definition, and diagnostics
- Inline git diff markers and LazyGit integration
- Catppuccin color scheme with a custom statusline
- Autosave on insert leave and focus lost
- Flash jump to navigate anywhere on screen instantly

---

## Quick Start (Fresh Mac Setup)

### 1. Install Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After installation, follow the instructions printed in the terminal to add Homebrew to your PATH:

```bash
echo >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### 2. Install Neovim and Dependencies

```bash
# Neovim (0.11+ required)
brew install neovim

# Required for Telescope fuzzy finder
brew install ripgrep fd

# Required for Treesitter parser compilation
brew install gcc

# Required for markdown-preview.nvim
brew install node npm

# Required for LazyGit (full git UI inside Neovim)
brew install lazygit

# Optional: better terminal emulator
brew install --cask iterm2
```

### 3. Install a Nerd Font (Required for Icons)

```bash
brew install --cask font-hack-nerd-font
```

Then set your terminal font to **Hack Nerd Font**:

- **iTerm2:** Preferences > Profiles > Text > Font > Select "Hack Nerd Font"
- **Terminal.app:** Preferences > Profiles > Font > Change > Select "Hack Nerd Font"
- **Kitty:** Add `font_family Hack Nerd Font` to `~/.config/kitty/kitty.conf`

### 4. Backup Existing Neovim Config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null
```

### 5. Clone This Repository

```bash
git clone https://github.com/alvina-yang/NeoVim.git ~/.config/nvim
```

### 6. Launch Neovim

```bash
nvim
```

On first launch:

1. **Lazy.nvim** will automatically bootstrap itself and install all plugins
2. **Mason** will install language servers (`lua_ls`, `pyright`)
3. **Treesitter** will download and compile language parsers
4. Wait for everything to finish (progress shows in the bottom right)
5. Restart Neovim (`:qa` then `nvim`) after installation completes
6. Run `:Lazy build markdown-preview.nvim` to build the markdown previewer

### 7. Verify Installation

Run these commands inside Neovim:

```
:checkhealth              Check overall health
:Lazy                     Verify all plugins installed (all should be green)
:Mason                    Verify language servers installed
:TSInstallInfo            Verify treesitter parsers installed
```

---

## File Structure

```
~/.config/nvim/
├── init.lua                    Core settings, autosave, bootstrap lazy.nvim
└── lua/
    ├── config/
    │   ├── diagnostics.lua     Diagnostic signs, virtual text, error line highlights
    │   └── keymaps.lua         All keybindings (splits, tabs, clipboard, terminal)
    └── plugins/
        ├── alpha.lua           Dashboard/greeter
        ├── colorscheme.lua     Catppuccin (default) + extra themes
        ├── editor.lua          Autopairs, comments, surround, indent, flash, illuminate
        ├── git.lua             Git blame, lazygit, gitsigns, diffview
        ├── lsp.lua             LSP, completion, trouble, lsp-progress
        ├── lualine.lua         Statusline with custom colored theme
        ├── nvim-tree.lua       File explorer with git status colors
        ├── session.lua         Session save/restore
        ├── telescope.lua       Fuzzy finder with fzf-native
        ├── tools.lua           Oil file manager, markdown preview
        ├── treesitter.lua      Syntax highlighting + code understanding
        └── ui.lua              Bufferline, noice, notify, dressing, which-key
```

---

## Essential Keybindings

**Leader key = `Space`**

| Keybind | Action |
|---------|--------|
| `Space e` | Toggle file explorer |
| `Space ff` | Find files |
| `Space fg` | Live grep (search text in all files) |
| `Space fr` | Recent files |
| `Space lg` | Open LazyGit (full git UI) |
| `gd` | Go to definition |
| `K` | Hover docs |
| `s` + chars | Flash jump anywhere on screen |
| `Tab` / `Shift-Tab` | Next/previous buffer tab |
| `Ctrl-n` | Exit terminal mode to Normal mode |

For the **complete keybinding reference and plugin guide**, see [INSTRUCTIONS.md](INSTRUCTIONS.md).

---

## Updating

```
:Lazy update          Update all plugins
:Mason                Then press U to update language servers
:TSUpdate             Update treesitter parsers
```

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Icons look broken | Install a Nerd Font and set it as your terminal font (step 3) |
| Treesitter errors | Run `:TSUpdate` to reinstall parsers |
| LSP not working | Run `:Mason`, press `i` next to missing servers |
| Telescope grep fails | Install ripgrep: `brew install ripgrep` |
| Colors look wrong | Ensure terminal supports true color and uses `xterm-256color` |
| Branch shows `.invalid` | Normal in deep subdirectories, statusline auto-detects the correct branch |

---

## License

MIT
