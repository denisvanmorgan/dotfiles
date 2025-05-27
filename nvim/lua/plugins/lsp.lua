return {
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "docker-compose-language-service",
                "dockerfile-language-server",
                "checkmake",
                "php-debug-adapter",
                "phpactor",
                "rust-analyzer",
            },
        },
    },
}
