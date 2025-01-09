return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-frecency.nvim", lazy = true },
  },
  opts = function()
    local icons = require "utils.icons"
    local actions = require "telescope.actions"

    return {
      defaults = {
        prompt_prefix = " " .. icons.ui.Telescope .. "  ",
        selection_caret = icons.ui.ChevronRight .. " ",
        scroll_strategy = "limit",
        -- results_title = true,
        layout_strategy = "horizontal",
        path_display = { "filename_first" },
        sorting_strategy = "ascending",
        file_ignore_patterns = { ".git/", ".cache", "build/", "dist/", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip" },
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
        },

        mappings = {
          i = {
            ["<esc>"] = actions.close,
            -- ["<C-n>"] = actions.cycle_history_next,
            -- ["<C-p>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.move_selection_next,
            ["<C-p>"] = actions.move_selection_previous,
            ["<C-a>"] = { "<esc>I", type = "command" },
            ["<C-e>"] = { "<esc>A", type = "command" },

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
          },

          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        git_files = {
          theme = "dropdown",
          previewer = false,
        },
        oldfiles = {
          theme = "dropdown",
          previewer = false,
        },
        colorscheme = {
          theme = "dropdown",
        },
        live_grep = {
          theme = "ivy",
        },
        grep_string = {
          theme = "ivy",
        },
        help_tags = {
          theme = "dropdown",
        },
        highlights = {
          theme = "dropdown",
        },
        marks = {
          theme = "dropdown",
        },
        vim_options = {
          theme = "dropdown",
        },
        git_status = {
          theme = "dropdown",
          previewer = false,
        },
        git_branches = {
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<cr>"] = actions.git_switch_branch,
            },
          },
        },
        git_commits = {
          theme = "dropdown",
        },
        buffers = {
          theme = "dropdown",
          previewer = false,
          mappings = {
            i = {
              ["<C-d>"] = actions.delete_buffer,
            },
          },
        },
        spell_suggest = {
          theme = "cursor",
          layout_config = {
            height = 14,
          },
        },
        jumplist = {
          theme = "dropdown",
        },
        command_history = {
          theme = "dropdown",
        },
        lsp_definitions = {
          theme = "ivy",
        },
        lsp_declarations = {
          theme = "ivy",
        },
        lsp_implementations = {
          theme = "ivy",
        },
        lsp_references = {
          theme = "ivy",
        },
        lsp_document_symbols = {
          theme = "ivy",
        },
        lsp_dynamic_workspace_symbols = {
          theme = "ivy",
        },
        diagnostics = {
          theme = "ivy",
        },
        filetypes = {
          theme = "dropdown",
        },
        symbols = {
          theme = "dropdown",
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "ignore_case",
        },
        live_grep_args = {
          mappings = {
            i = {
              ["<C-h>"] = require("telescope-live-grep-args.actions").quote_prompt(),
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
            },
          },
          theme = "ivy",
        },
        frecency = {
          show_filter_column = false,
          show_scores = true,
          previewer = false,
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)

    telescope.load_extension "fzf"
    telescope.load_extension "diffview"
    telescope.load_extension "live_grep_args"
    telescope.load_extension "frecency"
  end,
  keys = {
    { "z=", "<cmd>Telescope spell_suggest<cr>", desc = "Spell Suggestion" },

    -- Find --
    { "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    -- { "<leader><leader>", "<cmd>lua require('utils.telescope').project_files()<cr>", desc = "Find files" },
    {
      "<leader><leader>",
      "<cmd>Telescope frecency workspace=CWD theme=dropdown prompt_title=Find\\ Files<cr>",
      desc = "Find files",
    },

    { "<leader>fS", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
    -- { "<leader>ft",  { "<cmd>Telescope live_grep<cr>", "Find Text" },
    { "<leader>ft", "<cmd>Telescope live_grep_args<cr>", desc = "Find Text (Args)" },
    -- { "<leader>fs", "<cmd>Telescope grep_string<cr>", "Find String" },
    {
      "<leader>fs",
      "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<cr>",
      desc = "Find String",
    },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
    { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Highlight" },
    { "<leader>fl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Marks" },
    { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },
    { "<leader>fR", "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fV", "<cmd>Telescope vim_options<cr>", desc = "Vim Options" },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "Jump list" },

    -- Find Visual --
    {
      "<leader>fs",
      "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection({ theme = 'ivy' })<cr>",
      desc = "Find String",
      mode = "v",
    },

    -- Git --
    { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
    { "<leader>gb", "<cmd>Telescope git_branches show_remote_tracking_branches=false<cr>", desc = "Checkout branch" },
    { "<leader>gB", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
    { "<leader>gC", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    { "<leader>gD", "<cmd>Telescope diffview<cr>", desc = "Compare HEAD" },

    -- LSP --
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Diagnostics" },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
  },
}
