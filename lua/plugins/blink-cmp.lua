local icons = require "utils.icons"
return {
  {
    "saghen/blink.compat",
    -- use the latest release, via version = '*', if you also use the latest release for blink.cmp
    version = "*",
    -- lazy.nvim will automatically load the plugin when it's required by blink.cmp
    event = "InsertEnter",
    lazy = true,
    -- make sure to set opts so that lazy.nvim calls blink.compat's setup
    opts = {},
  },

  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    -- optional: provides snippets for the snippet source
    dependencies = {
      { "rafamadriz/friendly-snippets", event = "InsertEnter" },
      { "tzachar/cmp-tabnine", event = "InsertEnter", build = "./install.sh" },
    },

    -- use a release tag to download pre-built binaries
    version = "*",
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      enabled = function()
        return not vim.tbl_contains({ "DressingInput", "oil" }, vim.bo.filetype)
          and vim.bo.buftype ~= "prompt"
          and vim.b.completion ~= false
      end,
      -- 'default' for mappings similar to built-in completion
      -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
      -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
      -- See the full "keymap" documentation for information on defining your own keymap.
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_next()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-j>"] = { "select_prev", "fallback" },
        ["<C-k>"] = { "select_next", "fallback" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      completion = {
        menu = {
          border = "single",
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  if ctx.source_id == "tabnine" then
                    return icons.misc.Stars
                  end
                  return ctx.kind_icon
                end,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = {
            border = "single",
          },
        },
        list = {
          selection = {
            preselect = function(ctx)
              return ctx.mode ~= "cmdline"
            end,
          },
        },
        ghost_text = {
          enabled = true,
        },
      },
      signature = {
        enabled = false,
        trigger = {
          blocked_trigger_characters = {},
          blocked_retrigger_characters = {},
          -- When true, will show the signature help window when the cursor comes after a trigger character when entering insert mode
          show_on_insert_on_trigger_character = true,
        },
        window = {
          border = "single",
        },
      },

      appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- Will be removed in a future release
        use_nvim_cmp_as_default = false,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "normal",
        kind_icons = {
          Text = icons.kind.Text,
          Method = icons.kind.Method,
          Function = icons.kind.Function,
          Constructor = icons.kind.Constructor,

          Field = icons.kind.Field,
          Variable = icons.kind.Variable,
          Property = icons.kind.Property,

          Class = icons.kind.Class,
          Interface = icons.kind.Interface,
          Struct = icons.kind.Struct,
          Module = icons.kind.Module,

          Unit = icons.kind.Unit,
          Value = icons.kind.Value,
          Enum = icons.kind.Enum,
          EnumMember = icons.kind.EnumMember,

          Keyword = icons.kind.Keyword,
          Constant = icons.kind.Constant,

          Snippet = icons.kind.Snippet,
          Color = icons.kind.Color,
          File = icons.kind.File,
          Reference = icons.kind.Reference,
          Folder = icons.kind.Folder,
          Event = icons.kind.Event,
          Operator = icons.kind.Operator,
          TypeParameter = icons.kind.TypeParameter,
        },
      },
      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "tabnine" },
        providers = {
          -- create provider
          tabnine = {
            name = "cmp_tabnine", -- IMPORTANT: use the same name as you would for nvim-cmp
            module = "blink.compat.source",
            score_offset = 100,
            opts = {
              max_lines = 1000,
              max_num_results = 20,
              sort = true,
              run_on_every_keystroke = true,
              snippet_placeholder = "..",
              ignored_file_types = require("utils").ui_filetypes,
              show_prediction_strength = true,
            },
          },
          snippets = {
            opts = {
              search_paths = { "~/.config/nvim/snippets", vim.fn.getcwd() .. "/snippets" },
            },
          },
        },
      },
    },
    opts_extend = { "sources.default" },
  },
}
