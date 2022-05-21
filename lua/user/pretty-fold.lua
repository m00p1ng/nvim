local status_ok, pretty_fold = pcall(require, "pretty-fold")
if not status_ok then
  return
end

pretty_fold.setup()
