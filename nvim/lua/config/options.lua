-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Disable showing the mode below the statusline
vim.opt.showmode = false

-- Set tabs to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Enable auto indenting and set it to spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

-- Enable smart indenting
vim.opt.breakindent = true

-- Disable text wrap
vim.opt.wrap = false

-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Decrease updatetime to 250ms
vim.opt.updatetime = 250

-- Enable persistent undo history
vim.opt.undofile = true

-- Enable 24-bit color
vim.opt.termguicolors = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Enable cursor line highlight
vim.opt.cursorline = true

-- Always keep 10 lines above/below cursor unless at start/end of file
vim.opt.scrolloff = 10

-- Set command height to 0
vim.opt.cmdheight = 0

vim.opt.title = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
