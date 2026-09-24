local linter_configs = {
    phpstan = { "phpstan.neon", "phpstan.neon.dist", "phpstan.dist.neon" },
    phpcs = { "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" },
}

return {
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                php = { "phpstan", "phpcs" },
            }

            vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
                group = vim.api.nvim_create_augroup("lint", { clear = true }),
                callback = function(args)
                    for _, name in ipairs(lint.linters_by_ft[vim.bo[args.buf].filetype] or {}) do
                        local markers = linter_configs[name]
                        if not markers then
                            lint.try_lint(name)
                        else
                            local root = vim.fs.root(args.buf, markers)
                            if root then
                                lint.try_lint(name, { cwd = root })
                            end
                        end
                    end
                end,
            })
        end,
    },
}
