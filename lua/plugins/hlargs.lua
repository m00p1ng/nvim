return {
  "m-demare/hlargs.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    disable = function(lang, bufnr) -- If changed, `excluded_filetypes` will be ignored
      local limit = 100 * 1024 -- 100KB
      local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr))

      return file_size > limit
    end,
  },
}
