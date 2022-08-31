local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  return
end

vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldnestmax = 2

ufo.setup()
