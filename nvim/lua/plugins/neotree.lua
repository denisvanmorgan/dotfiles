return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    lazy = false, -- neo-tree lazily loads itself and hijacks netrw for `nvim <dir>`
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        { "<leader>tr", "<cmd>Neotree toggle<CR>", desc = "Toggle neotree" },
        {
            "<leader>e",
            function()
                if vim.bo.filetype == "neo-tree" then
                    vim.cmd.wincmd("p")
                else
                    vim.cmd("Neotree focus")
                end
            end,
            desc = "Focus Neo-tree / back to file",
        },
    },
    opts = {
        filesystem = {
            filtered_items = {
                visible = true,  -- Show hidden files
                hide_dotfiles = false,  -- Show dotfiles
            },
            follow_current_file = { enabled = true }
        },
    },
}
