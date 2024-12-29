return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = "auto", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = function(C)
      return {
        ColorColumn = { bg = "#2a2b3d" },
        NavicText = { fg = C.subtext0, bg = C.bg },
        SnacksIndent = { fg = C.surface0 },
        SnacksIndentScope = { fg = C.overlay2 },
        SnacksNotifierInfo = { link = "Normal" },
        SnacksNotifierWarn = { link = "Normal" },
        SnacksNotifierDebug = { link = "Normal" },
        SnacksNotifierError = { link = "Normal" },
        SnacksNotifierTrace = { link = "Normal" },
        UfoFoldedEllipsis = { fg = C.overlay2, bg = "NONE" },

        NvimTreeFolderName = { fg = C.subtext1, style = { "bold" } },
        NvimTreeOpenedFolderName = { fg = C.text, style = { "bold", "italic" } },
        NvimTreeEmptyFolderName = { fg = C.subtext1 },
        NvimTreeNormal = { fg = C.subtext0 },
        NvimTreeIndentMarker = { fg = C.surface0 },
        NvimTreeGitStaged = { fg = C.green },
        NvimTreeGitNew = { fg = C.green },
        NvimTreeGitRenamed = { fg = C.green },
        NvimTreeGitDeleted = { fg = C.yellow },
        NvimTreeGitMerge = { fg = C.yellow },
        NvimTreeGitDirty = { fg = C.yellow },

        CmpGhostText = { fg = C.overlay0, bg = C.bg },
        CmpItemKindCopilot = { fg = C.teal },
        CmpItemKindTabnine = { fg = "#b668cd" },
      }
    end,
    default_integrations = false,
    integrations = {
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      alpha = false,
      cmp = true,
      dap = true,
      dap_ui = true,
      diffview = true,
      gitsigns = true,
      indent_blankline = {
        enabled = false,
      },
      illuminate = {
        enabled = false,
        lsp = false,
      },
      mason = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
        inlay_hints = {
          background = true,
        },
      },
      navic = {
        enabled = true,
        custom_bg = "NONE", -- "lualine" will set background to mantle
      },
      neogit = true,
      notify = false,
      nvimtree = true,
      rainbow_delimiters = true,
      semantic_tokens = true,
      snacks = true,
      symbols_outline = true,
      telescope = {
        enabled = true,
        -- style = "nvchad"
      },
      treesitter = true,
      ufo = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme "catppuccin"
  end,
}
