return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  ---@type CatppuccinOptions
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
        ColorColumn = { bg = C.mantle },
        WinbarText = { fg = C.subtext0 },
        WinbarModified = { fg = C.yellow },

        Hlargs = { fg = C.maroon },
        NvimDapVirtualText = { link = "LspInlayHint" },

        OutlineGuides = { fg = C.surface0 },
        OutlineNormal = { bg = C.mantle },

        SnacksIndent = { fg = C.surface0 },
        SnacksIndentScope = { fg = C.overlay2 },
        SnacksNotifierInfo = { link = "Normal" },
        SnacksNotifierWarn = { link = "Normal" },
        SnacksNotifierDebug = { link = "Normal" },
        SnacksNotifierError = { link = "Normal" },
        SnacksNotifierTrace = { link = "Normal" },
        SnacksPicker = { fg = C.subtext1, bg = C.mantle },
        SnacksPickerTitle = { fg = C.surface0, bg = C.red, style = { "bold" } },
        SnacksPickerBorder = { fg = C.base, bg = C.mantle },
        SnacksPickerMatch = { fg = C.red },
        SnacksPickerPrompt = { fg = C.flamingo },
        SnacksPickerLabel = { fg = C.peach },
        SnacksPickerSpecial = { fg = C.surface2 },
        SnacksPickerPreview = { bg = C.base },
        SnacksPickerPreviewTitle = { fg = C.surface0, bg = C.green },
        SnacksPickerPreviewCursorLine = { link = "CursorLine" },
        SnacksPickerListCursorLine = { link = "CursorLine" },
        SnacksPickerSearch = { fg = C.surface0, bg = C.sapphire },
        SnacksPickerSpinner = { fg = C.peach },
        SnacksPickerRow = { link = "LineNr" },
        SnacksPickerDelim = { link = "LineNr" },
        SnacksPickerToggle = { fg = C.red, bg = C.mantle, style = { "italic" } },
        SnacksPickerTree = { link = "SnacksIndent" },
        SnacksInputNormal = { fg = C.subtext1, bg = C.mantle },
        SnacksInputBorder = { fg = C.red, bg = C.mantle },
        SnacksInputTitle = { fg = C.mantle, bg = C.red, style = { "bold" } },

        MatchWord = { bg = C.surface1 },
        MatchWordCur = { bg = C.surface1 },
        MatchParen = { fg = "NONE", bg = C.surface1, style = { "bold" } },
        MatchParenCur = { bg = C.surface1, style = { "bold" } },

        NormalFloat = { fg = C.text, bg = C.mantle },
        FloatBorder = { fg = C.mantle, bg = C.mantle },

        -- For native lsp configs
        LspInfoBorder = { link = "FloatBorder" },

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
        NvimTreeEndOfBuffer = { fg = C.mantle },

        OilDir = { link = "Directory", style = { "bold" } },
        OilDirIcon = { link = "Directory" },
        OilFile = { fg = C.subtext1 },

        Pmenu = { fg = C.overlay2, bg = C.base },
        PmenuBorder = { fg = C.surface1, bg = C.base },
        PmenuSel = { link = "CursorLine" },

        BlinkCmpMenu = { fg = C.overlay2, bg = C.base },
        BlinkCmpMenuBorder = { fg = C.surface1, bg = C.base },
        BlinkCmpDoc = { link = "NormalFloat" },
        BlinkCmpDocBorder = { link = "FloatBorder" },
        BlinkCmpLabel = { fg = C.subtext1 },
        BlinkCmpLabelMatch = { fg = C.red, style = { "bold" } },
        BlinkCmpLabelDescription = { fg = C.overlay0 },
      }
    end,
    default_integrations = false,
    integrations = {
      -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      alpha = false,
      blink_cmp = true,
      cmp = false,
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
      neogit = true,
      neotree = true,
      notify = false,
      nvimtree = true,
      rainbow_delimiters = true,
      semantic_tokens = true,
      snacks = true,
      symbols_outline = true,
      telescope = {
        enabled = true,
        style = "nvchad",
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

-- rosewater  #f2d5cf
-- flamingo   #eebebe
-- pink       #f4b8e4
-- mauve      #ca9ee6
-- red        #e78284
-- maroon     #ea999c
-- peach      #ef9f76
-- yellow     #e5c890
-- green      #a6d189
-- teal       #81c8be
-- sky        #99d1db
-- sapphire   #85c1dc
-- blue       #8caaee
-- lavender   #babbf1
-- text       #c6d0f5
-- subtext1   #b5bfe2
-- subtext0   #a5adce
-- overlay2   #949cbb
-- overlay1   #838ba7
-- overlay0   #737994
-- surface2   #626880
-- surface1   #51576d
-- surface0   #414559
-- base       #303446
-- mantle     #292c3c
-- crust      #232634
