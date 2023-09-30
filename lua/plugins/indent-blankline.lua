return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  tag = "v2.20.8",
  opts = {
    -- char = "│"
    -- char = "▎"
    char = "▏",
    context_char = "▏",
    show_trailing_blankline_indent = false,
    show_first_indent_level = true,
    use_treesitter = true,
    show_current_context = true,
    buftype_exclude = { "terminal", "nofile" },
    filetype_exclude = require("utils").ui_filetypes,
  },
  -- main = "ibl",
  -- opts = {
  --   enabled = true,
  --   debounce = 200,
  --   viewport_buffer = {
  --     min = 30,
  --     max = 500,
  --   },
  --   indent = {
  --     -- char = "│"
  --     -- char = "▎"
  --     char = "▏",
  --     tab_char = nil,
  --     highlight = "IblIndent",
  --     smart_indent_cap = true,
  --     priority = 1,
  --   },
  --   whitespace = {
  --     highlight = "IblWhitespace",
  --     remove_blankline_trail = true,
  --   },
  --   scope = {
  --     enabled = true,
  --     char = "▏",
  --     show_start = true,
  --     show_end = true,
  --     injected_languages = true,
  --     highlight = "IblScope",
  --     priority = 1024,
  --     include = {
  --       node_type = {},
  --     },
  --     exclude = {
  --       language = { "typescript" },
  --       node_type = {
  --         ["*"] = {
  --           "source_file",
  --           "program",
  --         },
  --         lua = {
  --           "chunk",
  --           "do_statement",
  --           "while_statement",
  --           "repeat_statement",
  --           "if_statement",
  --           "for_statement",
  --           "function_declaration",
  --           "function_definition",
  --           "table_constructor",
  --           "assignment_statement",
  --         },
  --         python = {
  --           "module",
  --         },
  --         -- typescript = {
  --         --   "statement_block",
  --         --   "function",
  --         --   "arrow_function",
  --         --   "function_declaration",
  --         --   "method_definition",
  --         --   "for_statement",
  --         --   "for_in_statement",
  --         --   "catch_clause",
  --         --   "object_pattern",
  --         --   "arguments",
  --         --   "switch_case",
  --         --   "switch_statement",
  --         --   "switch_default",
  --         --   "object",
  --         --   "object_type",
  --         --   "ternary_expression",
  --         -- },
  --       },
  --     },
  --   },
  --   exclude = {
  --     filetypes = require("utils").ui_filetypes,
  --     buftypes = {
  --       "terminal",
  --       "nofile",
  --       "quickfix",
  --       "prompt",
  --     },
  --   },
  -- },
}
