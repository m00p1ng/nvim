local nodePath = vim.fn.isdirectory ".yarn/sdks/eslint" and "./.yarn/sdks" or ""

return {
  settings = {
    nodePath = nodePath,
  },
}
