local prettier = { "prettierd", "prettier", stop_after_first = true }

local php_cs_fixer_configs = { ".php-cs-fixer.php", ".php-cs-fixer.dist.php" }
local phpcs_configs = { "phpcs.xml", "phpcs.xml.dist", ".phpcs.xml", ".phpcs.xml.dist" }

local function config_root(markers)
    return function(_, ctx)
        return vim.fs.root(ctx.dirname, markers)
    end
end

return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        keys = {
            {
                "<F3>",
                function()
                    require("conform").format({ async = true })
                end,
                mode = { "n", "x" },
                desc = "Format",
            },
            {
                "<leader>tf",
                function()
                    vim.g.disable_autoformat = not vim.g.disable_autoformat
                    vim.notify("Format on save " .. (vim.g.disable_autoformat and "disabled" or "enabled"))
                end,
                desc = "Toggle format on save",
            },
        },
        opts = {
            default_format_opts = { lsp_format = "fallback" },
            formatters_by_ft = {
                javascript = prettier,
                javascriptreact = prettier,
                typescript = prettier,
                typescriptreact = prettier,
                vue = prettier,
                css = prettier,
                scss = prettier,
                html = prettier,
                php = function(bufnr)
                    local formatters = { lsp_format = "never" }
                    if vim.fs.root(bufnr, php_cs_fixer_configs) then
                        table.insert(formatters, "php_cs_fixer")
                    end
                    if vim.fs.root(bufnr, phpcs_configs) then
                        table.insert(formatters, "phpcbf")
                    end
                    return formatters
                end,
            },
            formatters = {
                php_cs_fixer = { cwd = config_root(php_cs_fixer_configs) },
                phpcbf = { cwd = config_root(phpcs_configs) },
            },
            format_on_save = function()
                if vim.g.disable_autoformat then
                    return
                end
                return { timeout_ms = 3000 }
            end,
        },
    },
}
