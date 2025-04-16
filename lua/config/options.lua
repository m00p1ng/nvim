vim.g.autoformat = true
vim.g.autoformat_ignore_filetypes = {}

vim.opt.backspace = { 2 }
vim.opt.cmdheight = 1                            -- more space in the neovim command line for displaying messages
-- vim.opt.colorcolumn = {"80", "100", "120"}
vim.opt.completeopt = { "menuone", "noselect" }  -- mostly just for cmp
vim.opt.confirm = true
vim.opt.cursorline = true                        -- highlight the current line
vim.opt.expandtab = true                         -- convert tabs to spaces
vim.opt.exrc = true
vim.opt.fileencoding = "utf-8"                   -- the encoding written to a file
vim.opt.fillchars:append { diff = "" }
vim.opt.formatoptions = "jcroqlnt"               -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.guifont = "monospace:h17"                -- the font used in graphical neovim applications
vim.opt.hlsearch = true                          -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                        -- ignore case in search patterns
vim.opt.iskeyword:append "-"
vim.opt.laststatus = 3
vim.opt.listchars:append { tab = "->", space = "·", eol = "$" }
vim.opt.mouse = "a"                              -- allow the mouse to be used in neovim
vim.opt.mousemodel = "extend"
vim.opt.number = true                            -- set numbered lines
vim.opt.pumblend = 5                             -- Popup blend
vim.opt.pumheight = 10                           -- pop up menu height
vim.opt.scrolloff = 6                            -- is one of my fav
vim.opt.shiftwidth = 2                           -- the number of spaces inserted for each indentation
vim.opt.shortmess:append { W = true, I = true, c = true }
vim.opt.showmode = false                         -- we don't need to see things like -- INSERT -- anymore
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"                       -- always show the sign column otherwise it would shift the text each time
vim.opt.smartindent = true                       -- make indenting smarter again
vim.opt.softtabstop = 2
vim.opt.splitbelow = true                        -- force all horizontal splits to go below current window
vim.opt.splitright = true                        -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                         -- creates a swapfile
vim.opt.tabstop = 2                              -- insert 2 spaces for a tab
vim.opt.termguicolors = true                     -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true
vim.opt.undofile = true                          -- enable persistent undo
vim.opt.updatetime = 100                         -- faster completion (4000ms default)
vim.opt.wildmode = "longest:full,full"           -- Command-line completion mode
vim.opt.wrap = false                             -- display lines as one long line
vim.opt.writebackup = false                      -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
