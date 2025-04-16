vim.g.autoformat = true
vim.g.autoformat_ignore_filetypes = {}

local opt = vim.opt

opt.backspace = { 2 }
opt.cmdheight = 1                            -- more space in the neovim command line for displaying messages
-- opt.colorcolumn = {"80", "100", "120"}
opt.completeopt = { "menuone", "noselect" }  -- mostly just for cmp
opt.confirm = true
opt.cursorline = true                        -- highlight the current line
opt.expandtab = true                         -- convert tabs to spaces
opt.exrc = true
opt.fileencoding = "utf-8"                   -- the encoding written to a file
opt.fillchars:append { diff = "" }
opt.formatoptions = "jcroqlnt"               -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true                        -- ignore case in search patterns
opt.iskeyword:append "-"
opt.laststatus = 3
opt.listchars:append { tab = "->", space = "·", eol = "$" }
opt.mouse = "a"                              -- allow the mouse to be used in neovim
opt.mousemodel = "extend"
opt.number = true                            -- set numbered lines
opt.pumblend = 5                             -- Popup blend
opt.pumheight = 10                           -- pop up menu height
opt.ruler = false                            -- Disable the default ruler
opt.scrolloff = 6                            -- is one of my fav
opt.shiftwidth = 2                           -- the number of spaces inserted for each indentation
opt.shortmess:append { W = true, I = true, c = true }
opt.showmode = false                         -- we don't need to see things like -- INSERT -- anymore
opt.sidescrolloff = 8
opt.signcolumn = "yes"                       -- always show the sign column otherwise it would shift the text each time
opt.smartcase = true                         -- Don't ignore case with capitals
opt.smartindent = true                       -- make indenting smarter again
opt.softtabstop = 2
opt.splitbelow = true                        -- force all horizontal splits to go below current window
opt.splitright = true                        -- force all vertical splits to go to the right of current window
opt.swapfile = false                         -- creates a swapfile
opt.tabstop = 2                              -- insert 2 spaces for a tab
opt.termguicolors = true                     -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000                        -- time to wait for a mapped sequence to complete (in milliseconds)
opt.title = true
opt.undofile = true                          -- enable persistent undo
opt.undolevels = 10000
opt.updatetime = 100                         -- faster completion (4000ms default)
opt.virtualedit = "block"                    -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full"           -- Command-line completion mode
-- opt.winblend = 5
opt.wrap = false                             -- display lines as one long line
opt.writebackup = false                      -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
