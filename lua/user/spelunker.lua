vim.g.spelunker_highlight_type = 0
vim.g.spelunker_check_type = 2
vim.g.spelunker_disable_auto_group = 1
vim.g.spelunker_ignored_filetypes = require('user.function').ui_filetypes

vim.api.nvim_set_hl(0, "SpelunkerSpellBad", { sp = "#4FC1FF", fg=nil, undercurl=true })
vim.api.nvim_set_hl(0, "SpelunkerComplexOrCompoundWord", { sp = "#4FC1FF", fg=nil, undercurl=true })
