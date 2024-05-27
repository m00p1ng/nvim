return {
  "catppuccin/nvim",
  name = "catppuccin",
  cond = vim.g.vscode == nil,
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
        IndentBlanklineContextChar = { fg = C.overlay2 },
        UfoFoldedEllipsis = { fg = C.overlay2, bg = nil },

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
        CmpItemKindSnippet = { fg = C.base, bg = C.mauve },
        CmpItemKindKeyword = { fg = C.base, bg = C.red },
        CmpItemKindText = { fg = C.base, bg = C.teal },
        CmpItemKindMethod = { fg = C.base, bg = C.blue },
        CmpItemKindConstructor = { fg = C.base, bg = C.blue },
        CmpItemKindFunction = { fg = C.base, bg = C.blue },
        CmpItemKindFolder = { fg = C.base, bg = C.blue },
        CmpItemKindModule = { fg = C.base, bg = C.blue },
        CmpItemKindConstant = { fg = C.base, bg = C.peach },
        CmpItemKindField = { fg = C.base, bg = C.green },
        CmpItemKindProperty = { fg = C.base, bg = C.green },
        CmpItemKindEnum = { fg = C.base, bg = C.green },
        CmpItemKindUnit = { fg = C.base, bg = C.green },
        CmpItemKindClass = { fg = C.base, bg = C.yellow },
        CmpItemKindVariable = { fg = C.base, bg = C.flamingo },
        CmpItemKindFile = { fg = C.base, bg = C.blue },
        CmpItemKindInterface = { fg = C.base, bg = C.yellow },
        CmpItemKindColor = { fg = C.base, bg = C.red },
        CmpItemKindReference = { fg = C.base, bg = C.red },
        CmpItemKindEnumMember = { fg = C.base, bg = C.red },
        CmpItemKindStruct = { fg = C.base, bg = C.blue },
        CmpItemKindValue = { fg = C.base, bg = C.peach },
        CmpItemKindEvent = { fg = C.base, bg = C.blue },
        CmpItemKindOperator = { fg = C.base, bg = C.blue },
        CmpItemKindTypeParameter = { fg = C.base, bg = C.blue },
        CmpItemKindCopilot = { fg = C.base, bg = C.teal },
        CmpItemKindTabnine = { fg = C.base, bg = "#b668cd" },
      }
    end,
    default_integrations = false,
    integrations = {
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      alpha = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      diffview = true,
      gitsigns = true,
      indent_blankline = {
        enabled = true,
        scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = false,
      },
      illuminate = {
        enabled = true,
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
      notify = true,
      nvimtree = true,
      rainbow_delimiters = true,
      semantic_tokens = true,
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
