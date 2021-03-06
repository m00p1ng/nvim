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
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs"
  use "numToStr/Comment.nvim"
  use "moll/vim-bbye"
  use "akinsho/toggleterm.nvim"
  use "ahmedkhalf/project.nvim"
  use "lewis6991/impatient.nvim"
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "norcalli/nvim-colorizer.lua"
  use "folke/todo-comments.nvim"
  use "ur4ltz/surround.nvim"
  use "andymass/vim-matchup"
  use "kamykn/spelunker.vim"
  use "NTBBloodbath/rest.nvim"
  use "numToStr/Navigator.nvim"
  use "anuvyklack/pretty-fold.nvim"
  use "monaqa/dial.nvim"
  use "tpope/vim-repeat"
  use "ThePrimeagen/refactoring.nvim"
  use "phaazon/hop.nvim"

  -- Colorschemes
  use "m00p1ng/darkplus.nvim"

  -- UI
  use "akinsho/bufferline.nvim"
  use "folke/which-key.nvim"
  use "goolord/alpha-nvim"
  use "karb94/neoscroll.nvim"
  use "kyazdani42/nvim-tree.lua"
  use "kyazdani42/nvim-web-devicons"
  use "lukas-reineke/indent-blankline.nvim"
  use "nvim-lualine/lualine.nvim"
  use "rcarriga/nvim-notify"
  use "ntpeters/vim-better-whitespace"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "saadparwaiz1/cmp_luasnip"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-cmdline"
  use "rcarriga/cmp-dap"
  use { "tzachar/cmp-tabnine", run = "./install.sh" }

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "filipdutescu/renamer.nvim"
  use "ray-x/lsp_signature.nvim"
  use "RRethy/vim-illuminate"
  use "folke/trouble.nvim"
  use "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim"
  use "b0o/SchemaStore.nvim"
  use "akinsho/flutter-tools.nvim"
  use "j-hui/fidget.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", }
  use "nvim-treesitter/playground"
  use "nvim-treesitter/nvim-treesitter-textobjects"
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "windwp/nvim-ts-autotag"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "ruifm/gitlinker.nvim"
  use "f-person/git-blame.nvim"
  use "TimUntersberger/neogit"
  use "sindrets/diffview.nvim"

  -- DAP
  use "mfussenegger/nvim-dap"
  use "theHamsta/nvim-dap-virtual-text"
  use "rcarriga/nvim-dap-ui"
  use "Pocco81/DAPInstall.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
