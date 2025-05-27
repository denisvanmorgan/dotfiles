-- Set encodings
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable relative line numbers
vim.opt.nu = true
vim.opt.rnu = true

-- Disable showing the mode below the statusline
vim.opt.showmode = false

-- Set tabs to 2 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Enable auto indenting and set it to spaces
vim.opt.smartindent = true
vim.opt.shiftwidth = 4

-- Enable smart indenting
vim.opt.breakindent = true
vim.opt.autoindent = true

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

vim.opt.backspace = {"start", "eol", "indent"}
vim.opt.number = true
vim.opt.title = true
vim.opt.ignorecase = true
vim.opt.showcmd = true


-- Buffer navigation
vim.keymap.set('n', '<leader>d', ':bd<CR>', { desc = 'Close buffer' })
vim.keymap.set('n', '<leader>b', ':Telescope buffers<CR>', { desc = 'List buffers' })

-- Toggle neotree
vim.keymap.set('n', '<leader>tr', ':Neotree<CR>', { desc = 'Toggle neotree' })

-- Fuzzy search
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { desc = 'Fuzzy search' })
vim.keymap.set('n', '<leader>fw', ':Telescope live_grep<CR>', { desc = 'Fuzzy word search' })

-- Clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<leader>p', '<C-r>+', { noremap = true, silent = true })

