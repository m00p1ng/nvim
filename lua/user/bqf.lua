vim.cmd([[
  hi BqfPreviewBorder guifg=#50a14f
]])

require('bqf').setup({
  auto_enable = true,
  auto_resize_height = false, -- highly recommended enable
  preview = {
    win_height = 30,
    win_vheight = 30,
  },
})

