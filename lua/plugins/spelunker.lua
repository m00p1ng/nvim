return {
  "kamykn/spelunker.vim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.api.nvim_set_hl(0, "SpelunkerSpellBad", { sp = "#89b4fa", fg = nil, undercurl = true })
    vim.api.nvim_set_hl(0, "SpelunkerComplexOrCompoundWord", { sp = "#89b4fa", fg = nil, undercurl = true })

    local spelunker_ignored_filetypes = require("utils").ui_filetypes
    local f = require "utils"

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local filetype = f.get_buf_option "ft"
        if vim.tbl_contains(spelunker_ignored_filetypes, filetype) then
          return
        end

        vim.call "spelunker#check_displayed_words"
      end,
      group = vim.api.nvim_create_augroup("_spelunker", { clear = true }),
    })
  end,
  init = function()
    vim.g.spelunker_highlight_type = 0
    vim.g.spelunker_check_type = 2
    vim.g.spelunker_disable_auto_group = 1
  end,
}
