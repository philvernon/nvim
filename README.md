# Neovim

Personal Lua configuration for Neovim 0.11+ using [lazy.nvim](https://github.com/folke/lazy.nvim). The leader and local leader are both `,`.

## What it includes

- Native Neovim LSP with Mason-managed servers, including Lua, Go, Bash, Markdown, Vue and TypeScript.
- `blink.cmp` + LuaSnip for completion and snippets.
- `conform.nvim` for format-on-save with LSP fallback, plus `nvim-lint`/`eslint_d` for JS, TS and Vue.
- Telescope, Neo-tree and Yazi for search and file navigation.
- Gitsigns, Neogit, Diffview and Gitlinker for Git.
- `nvim-dap` + DAP UI for debugging.
- Catppuccin, Lualine, WhichKey, Outline and folding/UI helpers.
- Markdown/notes tooling with render-markdown, mkdnflow, bullets and zk.
- AI/CLI integration through Sidekick, pi-tools, pi-nvim and Neocrush.

## Layout

| Path | Purpose |
| --- | --- |
| `init.lua` | Entry point and load order |
| `lua/user/options.lua` | Editor options and leader |
| `lua/user/keymaps.lua` | General keymaps |
| `lua/user/plugins/` | lazy.nvim plugin specs |
| `lua/user/lsp/` | LSP configuration and mappings |
| `after/ftplugin/` | Filetype-specific behaviour |
| `lua/extra.lua` | Translate command and Godot integration |
| `lazy-lock.json` | Pinned plugin revisions |

## Formatting and linting

Configured formatters:

- Lua: `stylua`
- Python: `isort`, `black`
- JavaScript/TypeScript/Vue/SCSS: `prettierd` or `prettier`
- Rust: `rustfmt`
- Go: `goimports`, `gofumpt`
- HTML: `prettierd`
- SQL: `pg_format`

JavaScript, TypeScript and Vue are linted with `eslint_d`.

## Requirements

`git` is required for the lazy.nvim bootstrap. Other executables are only required for the features that use them, including the formatters above, `yazi`, `tmux`, `pi`, `crush`, `trans`, Node.js and Godot.

The local `pi-tools` plugin is loaded from `~/dev-trash/pi-tools`.

Place the configuration at `~/.config/nvim` and start Neovim; lazy.nvim bootstraps itself and installs the configured plugins.
