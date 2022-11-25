local status_ok, treesj pcall(require, "treesj")
if not status_ok then
  return
end

treesj.setup({
  use_default_keymaps = false,
  check_syntax_error = true,
  max_join_length = 120,
  cursor_behavior = 'hold',
  notify = true,
  langs = {},
})
