local status_ok, surround = pcall(require, "surround")
if not status_ok then
  return
end

surround.setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "surround",
  map_insert_mode = false,
  quotes = {"'", '"'},
  brackets = {"(", '{', '['},
  pairs = {
    nestable = {{"(", ")"}, {"[", "]"}, {"{", "}"}},
    linear = {{"'", "'"}, {"`", "`"}, {'"', '"'}}
  },
  prefix = "s"
}
