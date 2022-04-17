local status_ok, pretty_fold = pcall(require, "pretty-fold")
if not status_ok then
  return
end

local status_preview_ok, pretty_fold_preview = pcall(require, 'pretty-fold.preview')
if not status_preview_ok then
  return
end

pretty_fold.setup()
pretty_fold_preview.setup()
