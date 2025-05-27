-- Makes nvim transparent
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

-- Requires
require("config.editor")
require("config.lazy")
require("config.telescope")
require("config.colorscheme")
require("config.treesitter")
require("config.lsp")
require("config.neotree")
require("config.gitsigns")
require("config.surround")
require("config.comment")
require("config.log")
