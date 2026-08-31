-- matchadd() is window-local, so the highlight leaks into other buffers shown
-- in the same window. Add it on enter, drop it on leave.
local PATTERN = "\\%(^\\|\\s\\)\\zs@\\S\\+"
local bufnr = vim.api.nvim_get_current_buf()
local group = vim.api.nvim_create_augroup("FileMentionMarkdown" .. bufnr, { clear = true })

local function clear()
  for _, m in ipairs(vim.fn.getmatches()) do
    if m.group == "FileMention" then
      vim.fn.matchdelete(m.id)
    end
  end
end

local function add()
  clear()
  if vim.bo[bufnr].filetype == "markdown" then
    vim.fn.matchadd("FileMention", PATTERN)
  end
end

add()

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = group,
  buffer = bufnr,
  callback = add,
})

vim.api.nvim_create_autocmd({ "BufLeave", "BufWinLeave" }, {
  group = group,
  buffer = bufnr,
  callback = clear,
})

local undo = ("lua vim.api.nvim_del_augroup_by_id(%d) for _, m in ipairs(vim.fn.getmatches()) do if m.group == 'FileMention' then vim.fn.matchdelete(m.id) end end"):format(
  group
)
local prev = vim.b[bufnr].undo_ftplugin
vim.b[bufnr].undo_ftplugin = (prev and prev ~= "") and (prev .. " | " .. undo) or undo
