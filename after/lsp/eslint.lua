local nodePath = vim.fn.isdirectory ".yarn/sdks/eslint" == 1 and "./.yarn/sdks" or ""

return {
  settings = {
    nodePath = nodePath,
  },
}
