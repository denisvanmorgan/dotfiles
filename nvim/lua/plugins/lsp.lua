return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "b0o/SchemaStore.nvim",
        },
        config = function()
            -- Add cmp_nvim_lsp capabilities to every server
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })

            vim.diagnostic.config({ virtual_text = true })

            vim.lsp.config("vtsls", {
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
                settings = {
                    vtsls = {
                        tsserver = {
                            globalPlugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location = vim.fn.expand("$MASON/packages")
                                        .. "/vue-language-server/node_modules/@vue/language-server",
                                    languages = { "vue" },
                                    configNamespace = "typescript",
                                },
                            },
                        },
                    },
                },
            })

            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            })

            vim.lsp.config("phpactor", {
                init_options = {
                    ["indexer.exclude_patterns"] = {
                        "/vendor/**/Tests/**/*",
                        "/vendor/**/tests/**/*",
                        "/var/cache/**/*",
                        "/vendor/composer/**/*",
                        "/.phpstan.cache/**/*",
                        "/**/.conform.*",
                        "/**/conform.*.php",
                    },
                },
                handlers = {
                    ["textDocument/publishDiagnostics"] = function() end,
                },
                on_attach = function(client)
                    local caps = client.server_capabilities
                    caps.completionProvider = nil
                    caps.hoverProvider = false
                    caps.definitionProvider = false
                    caps.referencesProvider = false
                    caps.documentSymbolProvider = false
                    caps.workspaceSymbolProvider = false
                    caps.signatureHelpProvider = nil
                end,
            })

            -- This is where you enable features that only work
            -- if there is a language server active in the file
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local function map(mode, lhs, rhs, desc, extra)
                        local opts = vim.tbl_extend("force", { buffer = event.buf, desc = desc }, extra or {})
                        vim.keymap.set(mode, lhs, rhs, opts)
                    end

                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
                    map("n", "go", vim.lsp.buf.type_definition, "Go to type definition")
                    -- nowait: don't pause for the built-in grr/grn/gra/... maps
                    map("n", "gr", vim.lsp.buf.references, "References", { nowait = true })
                    map("n", "gs", vim.lsp.buf.signature_help, "Signature help")
                    map("n", "<F2>", vim.lsp.buf.rename, "Rename")
                    map("n", "<F4>", vim.lsp.buf.code_action, "Code action")
                end,
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "docker_compose_language_service",
                    "dockerls",
                    "phpactor",
                    "intelephense",
                    "rust_analyzer",
                    "vtsls",
                    "vue_ls",
                    "eslint",
                    "html",
                    "cssls",
                    "jsonls",
                },
                -- rustaceanvim starts rust-analyzer itself
                automatic_enable = { exclude = { "rust_analyzer" } },
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "prettierd",
                "php-cs-fixer",
                "phpstan",
                "phpcs",
                "phpcbf",
            },
        },
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
}
