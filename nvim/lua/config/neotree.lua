-- NeoTree setup
require('neo-tree').setup {
    close_if_last_window = false,  -- Close NeoTree when it's the last window
    enable_diagnostics = true,    -- Show diagnostics in the tree
    -- window = {
    --     position = "float", -- Open NeoTree in a floating window
    --     width = 60,         -- Width of the floating window
    --     height = 30,        -- Height of the floating window
    --     popup = {
    --           -- Center the floating window
    --         position = {
    --             row = "50%",    -- Center vertically
    --             col = "50%",    -- Center horizontally
    --         },
    --         size = {
    --             width = "60%",  -- Relative width of the floating window
    --             height = "60%", -- Relative height of the floating window
    --         },
    --         border = "rounded", -- Optional: Add a border to the floating window
    --     },
    -- },
    filesystem = {
        filtered_items = {
            visible = true,  -- Show hidden files
            hide_dotfiles = false,  -- Show dotfiles
        },
        follow_current_file = { enabled = true }
    },
}

-- Automatically open NeoTree when opening a directory
vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
        if vim.fn.isdirectory(vim.fn.expand('%')) == 1 then
            require('neo-tree.command').execute({ action = 'show' })
        end
    end,
})
