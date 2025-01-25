return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    filetypes = {
      "*",

      -- Excluded filteypes.
      "!lazy", -- Commit hashes get highlighted sometimes.
    },
    buftypes = {}, -- Buftype options.  Accepts table like `user_default_options`
    -- Boolean | List of usercommands to enable.  See User commands section.
    user_commands = true, -- Enable all or some usercommands
    lazy_load = false, -- Lazily schedule buffer highlighting setup function
    user_default_options = {
      names = false, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
      names_opts = { -- options for mutating/filtering names.
        lowercase = true, -- name:lower(), highlight `blue` and `red`
        camelcase = true, -- name, highlight `Blue` and `Red`
        uppercase = false, -- name:upper(), highlight `BLUE` and `RED`
        strip_digits = false, -- ignore names with digits,
        -- highlight `blue` and `red`, but not `blue3` and `red4`
      },
      -- Expects a table of color name to #RRGGBB value pairs.  # is optional
      -- Example: { cool = "#107dac", ["notcool"] = "ee9240" }
      -- Set to false to disable, for example when setting filetype options
      names_custom = false, -- Custom names to be highlighted: table|function|false
      RGB = true, -- #RGB hex codes
      RGBA = true, -- #RGBA hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      AARRGGBB = false, -- 0xAARRGGBB hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS *features*:
      -- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      -- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
      tailwind = false, -- Enable tailwind colors
      tailwind_opts = { -- Options for highlighting tailwind names
        update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
      },
      -- parsers can contain values used in `user_default_options`
      sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
      -- Highlighting mode.  'background'|'foreground'|'virtualtext'
      mode = "background", -- Set the display mode
      -- Virtualtext character to use
      virtualtext = "■",
      -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
      virtualtext_inline = false,
      -- Virtualtext highlight mode: 'background'|'foreground'
      virtualtext_mode = "foreground",
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = false,
    },
  },
}
