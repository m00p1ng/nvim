# Neovim Configuration

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim), designed for macOS with Nix.

## Requirements

- [Neovim](https://neovim.io/) >= 0.12
- [Git](https://git-scm.com/) >= 2.19
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for grep search)
- [tree-sitter](https://tree-sitter/) CLI (for Treesitter parsers)
- Optional: `pbcopy`/`pbpaste` (macOS clipboard, built-in)

## Install

```sh
git clone https://github.com/m00p1ng/nvim.git ~/.config/nvim
```

Launch `nvim` -- plugins install automatically on first run.

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── keymaps.lua       # General keymaps
│   │   ├── lazy.lua          # Plugin manager setup
│   │   ├── options.lua       # Vim options
│   │   └── autocmds.lua      # Autocommands
│   ├── plugins/
│   │   ├── ai/               # AI integration
│   │   ├── lang/             # Language-specific configs
│   │   ├── lsp/              # LSP, linting, formatting
│   │   ├── snacks/           # Snacks.nvim modules
│   │   ├── lualine/          # Statusline
│   │   └── ...
│   └── utils/                # Helper modules
├── snippets/                 # Custom snippets
├── after/                    # Filetype plugins
└── queries/                  # Custom Treesitter queries
```

## Key Features

| Category       | Plugin                                                                                                    | Purpose                                     |
|----------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------|
| Plugin Manager | [lazy.nvim](https://github.com/folke/lazy.nvim)                                                           | Lazy-loading, lockfile, auto-update checker |
| Completion     | [blink.cmp](https://github.com/Saghen/blink.cmp)                                                          | LSP, snippets, path, buffer sources         |
| AI Chat        | [CodeCompanion](https://github.com/olimorris/codecompanion.nvim)                                          | Multi-provider AI chat (`<leader>a`)        |
| AI Completion  | [Minuet](https://github.com/milanglacier/minuet-ai.nvim)                                                  | AI-powered inline completion                |
| LSP            | [mason.nvim](https://github.com/willamboman/mason.nvim)                                                   | Auto-installed language servers             |
| Formatting     | [conform.nvim](https://github.com/stevearc/conform.nvim)                                                  | Formatter management                        |
| Linting        | [nvim-lint](https://github.com/mfussenegger/nvim-lint.nvim)                                               | Async linting                               |
| Fuzzy Finder   | [Snacks picker](https://github.com/folke/snacks.nvim)                                                     | Files, buffers, grep, etc.                  |
| Statusline     | [lualine](https://github.com/nvim-lualine/lualine.nvim)                                                   | Custom statusline with winbar               |
| File Explorer  | [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua), [oil.nvim](https://github.com/stevearb/oil.nvim) | Tree and buffer-based navigation            |
| Git            | [gitsigns](https://github.com/lewis6991/gitsigns.nvim), [neogit](https://github.com/NeogitOrg/neogit)     | Signs, hunk navigation, git UI              |
| Treesitter     | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                                     | Highlighting, textobjects                   |
| Colorscheme    | [catppuccin](https://github.com/catppuccin/nvim)                                                          | Catppuccin Mocha                            |

## Languages

Configured with dedicated Treesitter parsers, LSP servers, formatters, and linters:

Bash, C++, CSS, Docker, English, Env, Flutter/Dart, Git, Go, GraphQL, HTML, HTTP, JSON, Lua, Markdown, Nix, Python, Ruby, Rust, SQL, Tailwind, TOML, TypeScript/JSX, Vue, YAML

## Keymaps (Leader: Space)

### General

| Key         | Mode | Action                   |
|-------------|------|--------------------------|
| `<CR>`      | n    | Clear search highlight   |
| `<leader>q` | n    | Quit                     |
| `<leader>c` | n    | Close buffer             |
| `<leader>O` | n    | Close other buffers      |
| `<leader>u` | n    | Undotree                 |
| `<leader>c` | v    | Copy to system clipboard |

### Navigation

| Key         | Mode | Action                   |
|-------------|------|--------------------------|
| `j` / `k`   | n    | Soft wrap-aware movement |
| `[t` / `]t` | n    | Prev/next tab            |
| `<M-q>`     | n    | Quickfix list            |

### Treesitter Textobjects

| Key         | Mode    | Action                            |
|-------------|---------|-----------------------------------|
| `af` / `if` | x, o    | Outer/inner function              |
| `aC` / `iC` | x, o    | Outer/inner class                 |
| `]m` / `[m` | n, x, o | Next/prev function                |
| `]a` / `[a` | n, x, o | Next/prev parameter               |
| `+` / `_`   | n, x, o | Incremental/decremental selection |

### AI (CodeCompanion)

| Key          | Mode | Action                |
|--------------|------|-----------------------|
| `<leader>ao` | n    | Toggle chat           |
| `<leader>aa` | v    | Add selection to chat |
| `<leader>ac` | n, v | Action palette        |
| `<leader>ae` | v    | Explain code          |
| `<leader>at` | v    | Generate tests        |
| `<leader>af` | v    | Fix code              |
| `<leader>ap` | n, v | Custom prompt         |

## Formatting

Auto-format on save is enabled by default. To disable:

```lua
vim.g.autoformat = false
```

To ignore specific filetypes:

```lua
vim.g.autoformat_ignore_filetypes = { "json" }
```

## Override

Place local overrides in `override/` (gitignored). See `override/example.lua` for reference.
