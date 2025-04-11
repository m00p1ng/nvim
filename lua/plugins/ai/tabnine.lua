return {
  {
    "codota/tabnine-nvim",
    event = "InsertEnter",
    build = "./dl_binaries.sh",
    opts = {
      disable_auto_comment = true,
      accept_keymap = "<C-F>",
      dismiss_keymap = "<C-]>",
      debounce_ms = 800,
      suggestion_color = { gui = "#b668cd", cterm = 244 },
      codelens_color = { gui = "#b668cd", cterm = 244 },
      codelens_enabled = false,
      exclude_filetypes = require("utils").ui_filetypes,
      log_file_path = nil,
      tabnine_enterprise_host = nil,
    },
    config = function(_, opts)
      vim.api.nvim_set_hl(0, "TabnineSuggestion", { fg = opts.suggestion_color.gui })

      require("tabnine").setup(opts)
    end,
  },

  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "tzachar/cmp-tabnine", build = "./install.sh" },
    opts = {
      keymap = {
        ["<a-y>"] = {
          function(cmp)
            cmp.show { providers = { "tabnine" } }
          end,
        },
      },
      sources = {
        default = { "tabnine" },
        providers = {
          tabnine = {
            name = "cmp_tabnine",
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
        },
      },
    },
    opts_extend = { "sources.default" },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      local text_func = opts.completion.menu.draw.components.kind_icon.text

      opts.completion.menu.draw.components.kind_icon.text = function(ctx)
        if ctx.source_id == "tabnine" then
          return require("utils.icons").misc.Stars
        end
        return text_func and text_func(ctx) or ctx.kind_icon
      end
    end,
  },
}
