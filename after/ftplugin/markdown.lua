-- matchadd() always overrules syntax/treesitter highlighting, so use extmarks
-- with a priority below treesitter's (100): mentions only show where markdown
-- highlighting left the text unstyled. Extmarks are buffer-local, so nothing
-- leaks into other buffers sharing the window.
local ns = vim.api.nvim_create_namespace("FileMention")
local bufnr = vim.api.nvim_get_current_buf()
local group = vim.api.nvim_create_augroup("FileMentionMarkdown" .. bufnr, { clear = true })

local function highlight()
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  if vim.bo[bufnr].filetype ~= "markdown" then
    return
  end
  for lnum, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    local init = 1
    while true do
      local s, e = line:find("@%S+", init)
      if not s then
        break
      end
      -- mention must start a line or follow whitespace
      if s == 1 or line:sub(s - 1, s - 1):match("%s") then
        vim.api.nvim_buf_set_extmark(bufnr, ns, lnum - 1, s - 1, {
          end_col = e,
          hl_group = "FileMention",
          priority = 99,
        })
      end
      init = e + 1
    end
  end
end

highlight()

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  group = group,
  buffer = bufnr,
  callback = highlight,
})

local undo = ("lua vim.api.nvim_del_augroup_by_id(%d) vim.api.nvim_buf_clear_namespace(%d, vim.api.nvim_create_namespace('FileMention'), 0, -1)"):format(
  group,
  bufnr
)
local prev = vim.b[bufnr].undo_ftplugin
vim.b[bufnr].undo_ftplugin = (prev and prev ~= "") and (prev .. " | " .. undo) or undo
