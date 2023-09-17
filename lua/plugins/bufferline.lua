local icons = require "utils.icons"

return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "moll/vim-bbye",
  },
  enabled = false,
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      -- style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
      themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
      numbers = "none", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      close_command = "Bdelete! %d", -- can be a string | function, | false see "Mouse actions"
      right_mouse_command = "Bdelete! %d", -- can be a string | function | false, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, | false see "Mouse actions"
      middle_mouse_command = nil, -- can be a string | function, | false see "Mouse actions"
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon", -- "icon" | "underline" | "none",
      },
      buffer_close_icon = icons.ui.Close,
      modified_icon = icons.ui.Circle,
      close_icon = icons.ui.TickClose,
      left_trunc_marker = icons.ui.LeftArrow,
      right_trunc_marker = icons.ui.RightArrow,
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      name_formatter = function(buf) -- buf contains:
        -- name                | str        | the basename of the active file
        -- path                | str        | the full path of the active file
        -- bufnr (buffer only) | int        | the number of the active buffer
        -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
        -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
      end,
      max_name_length = 30,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 21,
      diagnostics = false, -- false | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        return "(" .. count .. ")"
      end,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
        -- filter out filetypes you don't want to see
        if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
          return true
        end
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          return true
        end
        -- filter out based on arbitrary rules
        -- e.g. filter out vim wiki buffer from tabline in your work repo
        if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          return true
        end
        -- filter out by it's index number in list (don't show first buffer)
        if buf_numbers[1] ~= buf_number then
          return true
        end
      end,
      offsets = {
        { filetype = "NvimTree", text = "", padding = 1 },
        { filetype = "DiffviewFiles", text = "", padding = 1 },
      },
      color_icons = true, -- true | false, -- whether or not to add the filetype icon highlights
      get_element_icon = nil,
      show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
      show_buffer_close_icons = true, -- true | false,
      show_close_icon = true, -- true | false,
      show_tab_indicators = true, -- true | false,
      show_duplicate_prefix = true, -- true | false, -- whether to show duplicate buffer prefix
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin", -- "slant" | "slope" | "thick" | "thin" | { "any", "any" },
      enforce_regular_tabs = false, -- false | true,
      always_show_bufferline = true, -- true | false,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { "close" },
      },
      sort_by = "insert_after_current",
    },
  },
  highlights = {
    fill = {
      fg = { attribute = "fg", highlight = "#ff0000" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    background = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    buffer_visible = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
      bold = true,
    },
    close_button = {
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    close_button_visible = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    tab_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    tab = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    tab_close = {
      fg = { attribute = "fg", highlight = "TabLineSel" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    duplicate_selected = {
      fg = { attribute = "fg", highlight = "TabLineSel" },
      bg = { attribute = "bg", highlight = "TabLineSel" },
      italic = true,
    },
    duplicate_visible = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
      italic = true,
    },
    duplicate = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
      italic = true,
    },
    modified = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    modified_selected = {
      fg = { attribute = "fg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    modified_visible = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    separator = {
      fg = { attribute = "bg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    separator_selected = {
      fg = { attribute = "bg", highlight = "Normal" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    indicator_selected = {
      fg = { attribute = "fg", highlight = "LspDiagnosticsDefaultHint" },
      bg = { attribute = "bg", highlight = "Normal" },
    },
    numbers = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
    numbers_visible = {
      fg = { attribute = "fg", highlight = "TabLine" },
      bg = { attribute = "bg", highlight = "TabLine" },
    },
  },
}
