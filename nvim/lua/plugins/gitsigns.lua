return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "│" },
                change = { text = "│" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            attach_to_untracked = true,
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            on_attach = function(bufnr)
                local gs = require("gitsigns")
                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
                end

                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, "Next hunk")
                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, "Previous hunk")
                map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
                map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
                map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
                map("n", "<leader>gb", gs.blame_line, "Blame line")
                map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
            end,
        },
    }
}
