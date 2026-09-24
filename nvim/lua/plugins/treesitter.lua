local parsers = {
	"bash",
	"c",
	"css",
	"csv",
	"diff",
	"dockerfile",
	"gitcommit",
	"html",
	"javascript",
	"jsdoc",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nginx",
	"php",
	"phpdoc",
	"regex",
	"rust",
	"scss",
	"sql",
	"toml",
	"tsx",
	"twig",
	"typescript",
	"vimdoc",
	"vue",
	"yaml",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if not pcall(vim.treesitter.start, args.buf) then
						return
					end
					local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
					if lang and vim.treesitter.query.get(lang, "indents") then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		-- Additional text objects for treesitter
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function()
			-- Prevent ftplugin maps (e.g. ]] / [[) from shadowing the ones below
			vim.g.no_plugin_maps = true
		end,
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				},
				move = {
					set_jumps = true, -- whether to set jumps in the jumplist
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local move = require("nvim-treesitter-textobjects.move")

			-- You can use the capture groups defined in textobjects.scm
			local selects = {
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}
			for lhs, query in pairs(selects) do
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end)
			end

			local moves = {
				goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
				goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
				goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
				goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
			}
			for method, maps in pairs(moves) do
				for lhs, query in pairs(maps) do
					vim.keymap.set({ "n", "x", "o" }, lhs, function()
						move[method](query, "textobjects")
					end)
				end
			end
		end,
	},
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufReadPre",
        enabled = true,
        opts = {
            mode = "cursor",
            multiline_threshold = 1
        },
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "folke/ts-comments.nvim",
        event = "VeryLazy",
        opts = {},
    },
}
