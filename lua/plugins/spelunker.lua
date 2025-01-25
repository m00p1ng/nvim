return {
  "kamykn/spelunker.vim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.api.nvim_set_hl(0, "SpelunkerSpellBad", { sp = "#89b4fa", fg = nil, undercurl = true })
    vim.api.nvim_set_hl(0, "SpelunkerComplexOrCompoundWord", { sp = "#89b4fa", fg = nil, undercurl = true })

    local spelunker_ignored_filetypes = require("utils").ui_filetypes

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local ft = vim.bo.ft
        if vim.tbl_contains(spelunker_ignored_filetypes, ft) then
          return
        end

        local limit = 100 * 1024 -- 100KB
        local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))

        if file_size > limit then
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
    vim.g.spelunker_disable_uri_checking = 1
  end,
}
