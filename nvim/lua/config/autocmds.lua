vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "css",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "scss",
        "typescript",
        "typescriptreact",
        "vue",
    },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})
