local status_ok, bad_practices = pcall(require, "bad_practices")
if not status_ok then
  return
end

bad_practices.setup({
  most_splits = 0,
  most_tabs = 0,
  max_hjkl = 10,
})
