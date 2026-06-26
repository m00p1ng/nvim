vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("git_keymap", { clear = true }),
  pattern = "gitcommit",
  callback = function()
    vim.keymap.set("i", "<C-s>", function()
      local result = vim.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }, { text = true }):wait()
      if result.code ~= 0 then
        vim.notify("Git repository not found", vim.log.levels.WARN)
        return
      end
      local branch = vim.trim(result.stdout)
      local prefix = branch:match "([A-Za-z]+-[0-9]+)" or branch
      vim.api.nvim_feedkeys(prefix, "i", false)
    end, { expr = true, buffer = true })
  end,
})

return {
  {
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "git_config",
        "gitcommit",
        "git_rebase",
        "gitignore",
        "gitattributes",
      },
    },
  },
}
