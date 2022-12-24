local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

lazy.setup({
  -- Lua Development
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "ray-x/lsp_signature.nvim",
  "RRethy/vim-illuminate",
  "b0o/SchemaStore.nvim",
  "j-hui/fidget.nvim",
  "simrat39/symbols-outline.nvim",
  "SmiteshP/nvim-navic",

  -- Completion
  {
    "hrsh7th/nvim-cmp", -- The completion plugin
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer", -- buffer completions
      "hrsh7th/cmp-path", -- path completions
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-cmdline",
      "rcarriga/cmp-dap",
      { "tzachar/cmp-tabnine", build = "./install.sh" },
    }
  },

  -- Snippet
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/playground",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "windwp/nvim-ts-autotag",
      "Wansmer/treesj",
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-ui-select.nvim",
      "ThePrimeagen/refactoring.nvim",
    },
  },

  -- Color
  "NvChad/nvim-colorizer.lua",

  -- Colorschemes
  "m00p1ng/darkplus.nvim",

  -- Utility
  "rcarriga/nvim-notify",
  "moll/vim-bbye",
  "tpope/vim-repeat",
  { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },

  -- Debugging
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
      "rcarriga/nvim-dap-ui",
      { "mxsdev/nvim-dap-vscode-js", ft = { "javascript", "typescript" } },
      { "mfussenegger/nvim-dap-python", ft = "python" },
    }
  },

  -- StatusLine
  "nvim-lualine/lualine.nvim",

  -- StartUp
  "goolord/alpha-nvim",

  -- Indent
  "lukas-reineke/indent-blankline.nvim",

  -- File Explorer
  "nvim-tree/nvim-web-devicons",
  "nvim-tree/nvim-tree.lua",

  -- Comment
  "numToStr/Comment.nvim",
  "folke/todo-comments.nvim",

  -- Terminal
  "akinsho/toggleterm.nvim",
  "numToStr/Navigator.nvim",

  -- Quickfix
  "kevinhwang91/nvim-bqf",

  -- Git
  "lewis6991/gitsigns.nvim",
  "f-person/git-blame.nvim",
  "ruifm/gitlinker.nvim",
  "TimUntersberger/neogit",
  "sindrets/diffview.nvim",
  "akinsho/git-conflict.nvim",

  -- Editing Support
  "windwp/nvim-autopairs",
  "monaqa/dial.nvim",
  "andymass/vim-matchup",
  "karb94/neoscroll.nvim",
  "ntpeters/vim-better-whitespace",
  "ur4ltz/surround.nvim",
  "folke/zen-mode.nvim",
  -- use { "0x100101/lab.nvim", run = 'cd js && npm ci' }

  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
    }
  },

  -- Web development
  { "NTBBloodbath/rest.nvim", ft = "http" },

  -- Keybinding
  "folke/which-key.nvim",

  -- Spell checker
  "kamykn/spelunker.vim",

  -- Programming languages support
  { "akinsho/flutter-tools.nvim", ft = "dart" },
  { "jose-elias-alvarez/typescript.nvim" },

  'wakatime/vim-wakatime',
})
