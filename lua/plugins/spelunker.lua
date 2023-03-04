return {
  "kamykn/spelunker.vim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.api.nvim_set_hl(0, "SpelunkerSpellBad", { sp = "#4FC1FF", fg = nil, undercurl = true })
    vim.api.nvim_set_hl(0, "SpelunkerComplexOrCompoundWord", { sp = "#4FC1FF", fg = nil, undercurl = true })

    local spelunker_ignored_filetypes = require("utils").ui_filetypes

    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local filetype = vim.api.nvim_buf_get_option(0, "ft")
        if vim.tbl_contains(spelunker_ignored_filetypes, filetype) then
          return
        end

        vim.call("spelunker#check_displayed_words")
      end,
      group = vim.api.nvim_create_augroup("_spelunker", { clear = true }),
    })
  end,
}
