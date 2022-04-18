local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
  return
end

gitlinker.setup({
  opts = {
    add_current_line_on_normal_mode = true,
    action_callback = require("gitlinker.actions").open_in_browser,
    print_url = false,
    mappings = "gy",
  },
})
