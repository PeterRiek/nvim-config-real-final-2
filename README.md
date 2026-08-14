# My Real Final Final Neovim Configuration (v2)

Lua-based Neovim config (`init.lua` + `lua/`). Part of my dotfiles, usable standalone.

## Structure

| File / dir          | Purpose                                    |
| ------------------- | ------------------------------------------- |
| `settings.lua`      | Core `vim.opt` options                      |
| `plugins/init.lua`  | Bootstraps lazy.nvim, plugin list           |
| `plugins/configs/`  | Per-plugin setup                            |
| `mappings.lua`      | Keymaps (via which-key, `<space>` leader)   |
| `lsp/`              | LSP server configs                          |
| `autocmds.lua`      | Autocommands                                |
| `theme.lua`         | Colorscheme setup                           |

Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim); versions are pinned in `lazy-lock.json`.

## Setup

1. Requirements: Neovim >= 0.10, `git`, a [Nerd Font](https://www.nerdfonts.com/), `ripgrep` (Telescope search), `binutils` (Lua LSP, see below), Node.js (`ts_ls`), a JDK (`jdtls`).
2. Back up any existing config, then clone this repo:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
   git clone git@github.com:PeterRiek/nvim-config-real-final-final-2.git ~/.config/nvim
   mkdir -p ~/.vim/undidir
   ```
3. Launch `nvim` — lazy.nvim bootstraps itself and installs all plugins on first run.
4. Run `:Mason` and install/update LSP servers if any are missing (they're listed in `lua/plugins/configs/mason.lua` and installed automatically via `mason-lspconfig`).
5. Optional: create `lua/secrets.lua` (gitignored) if you want CodeCompanion's Gemini/Nvidia integrations:
   ```lua
   return { gemini_api_key = "...", nvidia_api_key = "..." }
   ```

Press `<space>` and wait to browse available keymaps via which-key.

### Lua LSP dependency

Lua LSP depends on `binutils` and might need to be symlinked manually:

```bash
# Arch/CachyOS
sudo pacman -S binutils
```
