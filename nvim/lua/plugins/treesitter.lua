return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		event = { "BufEnter" },
		dependencies = {
			-- Additional text objects for treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
	},
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        enabled = true,
        opts = {
            mode = "cursor",
            multiline_threshold = 1
        },
    }
}
