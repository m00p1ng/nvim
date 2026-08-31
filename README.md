# Neovim Configuration

Personal Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim), designed for macOS with Nix.

## Requirements

- [Neovim](https://neovim.io/) >= 0.12 (uses `vim.lsp.config`, `vim.treesitter._select`, bundled `nvim.undotree`)
- [Git](https://git-scm.com/) >= 2.19
- A [Nerd Font](https://www.nerdfonts.com/) (for icons)
- [ripgrep](https://github.com/BurntSushi/ripgrep) (for grep search)
- [tree-sitter](https://tree-sitter.github.io/) CLI (for Treesitter parsers)
- Node.js / Python (for Mason-installed language servers)
- Optional: [fd](https://github.com/sharkdp/fd) (faster file picker backend)
- Optional: `pbcopy`/`pbpaste` (macOS clipboard, built-in)
- Optional: [tmux](https://github.com/tmux/tmux) (for `Navigator.nvim` pane movement)

## Install

```sh
git clone https://github.com/m00p1ng/nvim.git ~/.config/nvim
```

Launch `nvim` -- lazy.nvim bootstraps itself and installs plugins on first run.

Lockfiles are per-user: `lazy-lock.json` for `m00p1ng`, `lazy-lock_$USER.json` otherwise (gitignored).

## Structure

```
~/.config/nvim/
├── init.lua                  # Entry point (VS Code-aware, optional profiler)
├── .nvim.lua                 # Project-local exrc (disables autoformat for some files)
├── lua/
│   ├── config/
│   │   ├── keymaps.lua       # General keymaps (loaded even in VS Code)
│   │   ├── options.lua       # Vim options
│   │   ├── autocmds.lua      # Autocommands
│   │   └── lazy.lua          # Plugin manager setup
│   ├── plugins/
│   │   ├── ai/               # Minuet + completion providers (copilot, gemini, zai, local-llm)
│   │   ├── lang/             # Per-language configs (25 filetypes)
│   │   ├── lsp/              # LSP core, mason, conform, nvim-lint, neoconf, signature
│   │   ├── lualine/          # Statusline spec + components
│   │   ├── snacks/           # Snacks.nvim modules (picker, dashboard, toggle, ...)
│   │   └── *.lua             # One file per standalone plugin
│   ├── lualine/themes/       # Custom lualine theme (mooping)
│   ├── override/             # Local overrides (gitignored except example.lua)
│   └── utils/                # git, icons, lsp, tmux, treesitter, winbar helpers
├── after/
│   ├── ftdetect/             # Custom filetype detection
│   ├── ftplugin/             # markdown, python
│   └── lsp/                  # Per-server config (vim.lsp.config style)
├── queries/                  # Custom Treesitter queries (lua highlights)
├── snippets/                 # Custom snippets
└── spell/                    # Custom spellfile
```

## Key Features

| Category       | Plugin                                                                                                     | Purpose                                     |
|----------------|------------------------------------------------------------------------------------------------------------|---------------------------------------------|
| Plugin Manager | [lazy.nvim](https://github.com/folke/lazy.nvim)                                                            | Lazy-loading, per-user lockfile, checker    |
| Completion     | [blink.cmp](https://github.com/Saghen/blink.cmp)                                                           | LSP, snippets, path, buffer sources         |
| AI Completion  | [minuet-ai](https://github.com/milanglacier/minuet-ai.nvim)                                                 | Inline completion (copilot/gemini/zai/local) |
| LSP            | [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig), [mason.nvim](https://github.com/mason-org/mason.nvim) | Auto-installed language servers        |
| Formatting     | [conform.nvim](https://github.com/stevearc/conform.nvim)                                                   | Formatter management, format-on-save        |
| Linting        | [nvim-lint](https://github.com/mfussenegger/nvim-lint)                                                     | Async linting                               |
| Debugging      | [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [dap-ui](https://github.com/rcarriga/nvim-dap-ui)    | Breakpoints, stepping, virtual text         |
| Fuzzy Finder   | [Snacks picker](https://github.com/folke/snacks.nvim)                                                       | Files, buffers, grep, git, LSP symbols      |
| UI / Messages  | [noice.nvim](https://github.com/folke/noice.nvim), [snacks notifier](https://github.com/folke/snacks.nvim)  | Cmdline, popupmenu, notifications           |
| Statusline     | [lualine](https://github.com/nvim-lualine/lualine.nvim)                                                     | Custom statusline + winbar                  |
| File Explorer  | [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua), [oil.nvim](https://github.com/stevearc/oil.nvim)   | Tree and buffer-based navigation            |
| Git            | [gitsigns](https://github.com/lewis6991/gitsigns.nvim), [neogit](https://github.com/NeogitOrg/neogit), [diffview](https://github.com/sindrets/diffview.nvim), [git-conflict](https://github.com/akinsho/git-conflict.nvim) | Signs, git UI, diffs, conflicts |
| Treesitter     | [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)                                       | Highlighting, textobjects, context          |
| Code Outline   | [outline.nvim](https://github.com/hedyhli/outline.nvim), [lensline](https://github.com/oribarilan/lensline.nvim) | Symbol tree, inline lenses            |
| Folding        | [nvim-ufo](https://github.com/kevinhwang91/nvim-ufo)                                                       | LSP/Treesitter-backed folds                 |
| Task Runner    | [overseer.nvim](https://github.com/stevearc/overseer.nvim)                                                 | Run and manage tasks                        |
| Quickfix       | [nvim-bqf](https://github.com/kevinhwang91/nvim-bqf), [quicker](https://github.com/stevearc/quicker.nvim), [nvim-pqf](https://github.com/yorickpeterse/nvim-pqf) | Better quickfix UX      |
| Editing        | [nvim-surround](https://github.com/kylechui/nvim-surround), [treesj](https://github.com/Wansmer/treesj), [dial.nvim](https://github.com/monaqa/dial.nvim), [text-case](https://github.com/johmsalas/text-case.nvim) | Surround, split/join, increment, case |
| Navigation     | [Navigator.nvim](https://github.com/numToStr/Navigator.nvim), [treewalker](https://github.com/aaronik/treewalker.nvim), [demicolon](https://github.com/mawkler/demicolon.nvim) | Tmux panes, AST movement, repeatable jumps |
| Habits         | [hardtime.nvim](https://github.com/m4xshen/hardtime.nvim)                                                  | Discourage inefficient motions              |
| Colorscheme    | [catppuccin](https://github.com/catppuccin/nvim)                                                           | Catppuccin Mocha                            |

Also included: markview, helpview, todo-comments, colorizer, rainbow-delimiters, hlargs, paint, virt-column, indent guides, undo-glow, autopairs, ts-autotag, ts-comments, guess-indent, matchup, neoscroll, spelunker, url-open, whitespace, puppeteer, nvzone (minty/showkeys/typr), package-info, wakatime, filemention.

## Languages

Configured with dedicated Treesitter parsers, LSP servers, formatters, and linters:

Bash, C++, CSS, Docker, English, Env, Flutter/Dart, Git, Go, GraphQL, HTML, HTTP, JSON, Lua, Markdown, Nix, Python, Ruby, Rust, SQL, Tailwind, TOML, TypeScript/JSX, Vue, YAML

## Keymaps (Leader: Space, Localleader: `\`)

### General

| Key           | Mode | Action                       |
|---------------|------|------------------------------|
| `<CR>`        | n    | Clear search highlight       |
| `<leader>q`   | n    | Quit                         |
| `<leader>Q`   | n    | Quit all                     |
| `<leader>c`   | n    | Close buffer                 |
| `<leader>O`   | n    | Close other buffers          |
| `<leader>M`   | n    | Messages                     |
| `<leader>u`   | n    | Undotree (built-in, 1/3 width) |
| `<leader>c`   | v    | Copy to system clipboard     |
| `x` / `c` / `C` | n, v | Delete/change without clobbering register |
| `dd`          | n    | Blackhole register on blank lines |

### Navigation

| Key                 | Mode | Action                     |
|---------------------|------|----------------------------|
| `j` / `k`           | n    | Soft wrap-aware movement   |
| `[t` / `]t`         | n    | Prev/next tab              |
| `<C-h/j/k/l>`       | n    | Move across tmux panes/splits |
| `<M-q>`             | n    | Quickfix list              |
| `n` / `N`           | n, x, o | Direction-stable search + `zv` |
| `*`                 | n    | Search current word, keep position |
| `[k` / `]k`         | n    | Treewalker up/down         |
| `[p` / `]p`         | n    | Treewalker out/in          |
| `[K` / `]K` / `[P` / `]P` | n | Treewalker swap             |

### Explorer / Pickers

| Key                 | Mode | Action                    |
|---------------------|------|---------------------------|
| `<leader>e`         | n    | Toggle nvim-tree          |
| `<leader>E`         | n    | Focus nvim-tree           |
| `<leader>b`         | n    | Buffers                   |
| `<leader><leader>`  | n    | Smart open                |
| `<leader>ff`        | n    | Find files                |
| `<leader>ft`        | n    | Grep                      |
| `<leader>fs`        | n, v | Grep word / selection     |
| `<leader>fb`        | n    | Grep open buffers         |
| `<leader>fr`        | n    | Recent files              |
| `<leader>fl`        | n    | Resume last search        |
| `<leader>fp`        | n    | Command palette           |
| `<leader>fh` / `fM` | n    | Help / man pages          |
| `<leader>fk` / `fC` / `fc` | n | Keymaps / commands / history |
| `<leader>fm` / `fj` / `fq` / `fu` | n | Marks / jumps / quickfix / undo |
| `<leader>fR` / `fH` / `fS` | n | Registers / highlights / colorschemes |
| `z=`                | n    | Spelling suggestions      |

### Code / LSP (`<leader>l`)

| Key             | Mode | Action                    |
|-----------------|------|---------------------------|
| `gd` / `gD`     | n    | Definition / declaration  |
| `gri` / `grr`   | n    | Implementations / references |
| `gs`            | n    | Signature help            |
| `gl`            | n    | Line diagnostics (float)  |
| `<localleader>a`| n, v | Code action               |
| `<leader>ld` / `lw` | n | Buffer / workspace diagnostics |
| `<leader>ls` / `lS` | n | Document / workspace symbols |
| `<leader>lo`    | n    | Outline                   |
| `<leader>lq`    | n    | Diagnostics to loclist    |
| `<leader>li`    | n    | LSP config (buffer)       |
| `<leader>lI`    | n    | Mason                     |
| `<leader>lR`    | n    | Restart LSP               |

### Git (`<leader>g`)

| Key                 | Mode | Action                        |
|---------------------|------|-------------------------------|
| `<leader>gg` / `gc` | n    | Neogit / Neogit commit        |
| `<leader>go`        | n    | Open changed file             |
| `<leader>gb` / `gB` | n    | Checkout branch (local / all) |
| `<leader>gl` / `gL` | n    | Log (buffer / repo)           |
| `<leader>gs` / `gS` | n, v | Stage hunk / buffer           |
| `<leader>gr` / `gR` | n, v | Reset hunk / buffer           |
| `<leader>gu`        | n    | Undo stage hunk               |
| `<leader>gP`        | n    | Preview hunk                  |
| `<leader>gk`        | n    | Toggle line blame             |
| `<leader>gt`        | n    | Diffview open                 |
| `<leader>gd`        | n    | Diff against `origin/develop` |
| `<leader>gh`        | n    | File history                  |
| `<leader>gy` / `gw` / `gO` | n | Browse file / commit / repo on remote |

### Debug (`<leader>d`)

| Key                        | Mode | Action                     |
|----------------------------|------|----------------------------|
| `<leader>db` / `dB` / `dL` | n    | Breakpoint / conditional / logpoint |
| `<leader>dc`               | n    | Continue                   |
| `<leader>di` / `do` / `dO` | n    | Step into / over / out      |
| `<leader>dr` / `du`        | n    | REPL / DAP UI              |
| `<leader>de`               | n    | Eval                       |
| `<leader>dl` / `dx`        | n    | Run last / terminate       |
| `<leader>dv`               | n    | Toggle virtual text        |

### Options (`<leader>o`)

| Key                 | Mode | Action                          |
|---------------------|------|---------------------------------|
| `<leader>of` / `oF` | n    | Toggle autoformat (buffer / global) |
| `<leader>ol` / `oL` | n    | Relative / absolute line numbers |
| `<leader>ow`        | n    | Wrap                            |
| `<leader>ob`        | n    | Dark background                 |
| `<leader>oi`        | n    | Inlay hints                     |
| `<leader>oc`        | n    | Conceal                         |
| `<leader>op`        | n    | Profiler                        |

### Other Groups

| Prefix       | Group                                                     |
|--------------|-----------------------------------------------------------|
| `<leader>p`  | Lazy (`pp` UI, `pc` check, `pC` clean, `pi` install, `ps` sync, `pu` update) |
| `<leader>r`  | Overseer (`rr` run, `ra` quick action, `rc` run cmd, `rl` last, `ri` info, `ru` toggle) |
| `<leader>m`  | Misc, filetype-scoped (label shows current `filetype`)    |
| `<leader>R`  | Kulala (HTTP requests)                                    |
| `<leader>n` / `<leader>N` | Noice / Noice last                             |
| `<leader>v` / `<leader>V` | DotENV reload / load                           |

### Treesitter Textobjects

| Key         | Mode    | Action                            |
|-------------|---------|-----------------------------------|
| `af` / `if` | x, o    | Outer/inner function              |
| `aC` / `iC` | x, o    | Outer/inner class                 |
| `ac` / `ic` | x, o    | Outer/inner conditional           |
| `al` / `il` | x, o    | Outer/inner loop                  |
| `ae` / `ie` | x, o    | Outer/inner block                 |
| `as` / `is` | x, o    | Outer/inner statement             |
| `am` / `im` | x, o    | Outer/inner call                  |
| `ad`        | x, o    | Comment                           |
| `]m` / `[m` | n, x, o | Next/prev function start          |
| `]M` / `[M` | n, x, o | Next/prev function end            |
| `]a` / `[a` | n, x, o | Next/prev parameter               |
| `+` / `_`   | n, x, o | Incremental/decremental selection (Treesitter, LSP fallback) |

## Formatting

Auto-format on save is enabled by default. To disable:

```lua
vim.g.autoformat = false     -- global
vim.b.autoformat = false     -- current buffer
```

To ignore specific filetypes:

```lua
vim.g.autoformat_ignore_filetypes = { "json" }
```

Runtime toggles: `<leader>of` (buffer), `<leader>oF` (global).

## Project-Local Config

`exrc` is enabled, so a `.nvim.lua` in the project root is sourced on startup. lazy.nvim's
`local_spec` also picks up a project-level `.lazy.lua` plugin spec.

This repo's own `.nvim.lua` disables autoformat for a few heavily-commented config files.

## Override

Place local overrides in `lua/override/` (gitignored except `example.lua`). The directory is
imported as a lazy.nvim spec, so it can add, disable, or reconfigure any plugin.
See `lua/override/example.lua` for reference.
