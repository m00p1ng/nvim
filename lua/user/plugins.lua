local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_user_group = vim.api.nvim_create_augroup("_packer_user_group", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
  group = packer_user_group
})

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  max_jobs = 50,
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    prompt_border = "rounded",
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Plugin Manager
  use "wbthomason/packer.nvim" -- Have packer manage itself

  -- Lua Development
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "ray-x/lsp_signature.nvim"
  use "RRethy/vim-illuminate"
  use "b0o/SchemaStore.nvim"
  use "j-hui/fidget.nvim"
  use "simrat39/symbols-outline.nvim"
  use "SmiteshP/nvim-navic"

  -- Completion
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-cmdline"
  use "rcarriga/cmp-dap"
  use { "tzachar/cmp-tabnine", run = "./install.sh" }

  -- Snippet
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", }
  use "nvim-treesitter/playground"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "windwp/nvim-ts-autotag"

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    requires = {
      { "nvim-telescope/telescope-live-grep-args.nvim" },
    },
  }
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-telescope/telescope-ui-select.nvim"
  use "ThePrimeagen/refactoring.nvim"

  -- Color
  use "NvChad/nvim-colorizer.lua"

  -- Colorschemes
  use "m00p1ng/darkplus.nvim"

  -- Utility
  use "rcarriga/nvim-notify"
  use "moll/vim-bbye"
  use "lewis6991/impatient.nvim"
  use "tpope/vim-repeat"
  use { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }

  -- Debugging
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "mxsdev/nvim-dap-vscode-js"

  -- StatusLine
  use "nvim-lualine/lualine.nvim"

  -- StartUp
  use "goolord/alpha-nvim"

  -- Indent
  use "lukas-reineke/indent-blankline.nvim"

  -- File Explorer
  use "nvim-tree/nvim-web-devicons"
  use "nvim-tree/nvim-tree.lua"

  -- Comment
  use "numToStr/Comment.nvim"
  use "folke/todo-comments.nvim"

  -- Terminal
  use "akinsho/toggleterm.nvim"
  use "numToStr/Navigator.nvim"

  -- Project
  use "ahmedkhalf/project.nvim"

  -- Quickfix
  use "kevinhwang91/nvim-bqf"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "TimUntersberger/neogit"
  use "sindrets/diffview.nvim"
  use "akinsho/git-conflict.nvim"

  -- Editing Support
  use "windwp/nvim-autopairs"
  use "monaqa/dial.nvim"
  use "andymass/vim-matchup"
  use "karb94/neoscroll.nvim"
  use "ntpeters/vim-better-whitespace"
  use "ur4ltz/surround.nvim"
  use { "aarondiel/spread.nvim", after = "nvim-treesitter" }

  -- Test
  use {
    "nvim-neotest/neotest",
    requires = {
      'haydenmeade/neotest-jest',
    }
  }

  -- Web development
  use "NTBBloodbath/rest.nvim"

  -- Keybinding
  use "folke/which-key.nvim"

  -- Spell checker
  use "kamykn/spelunker.vim"

  -- Programming languages support
  use "akinsho/flutter-tools.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
