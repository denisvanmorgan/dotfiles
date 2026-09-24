return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                sources = {
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp", group_index = 1 },
                    { name = "path", group_index = 1 },
                    { name = "buffer", group_index = 2 },
                },
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ["<CR>"] = cmp.mapping.confirm({ select = false }),

                    -- Ctrl+Space to trigger completion menu
                    ["<C-Space>"] = cmp.mapping.complete(),

                    -- Scroll up and down in the completion documentation
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
            })
        end,
    },
}
