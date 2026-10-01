-- https://github.com/nvim-telescope/telescope.nvim

return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    cmd = 'Telescope',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-project.nvim',
        -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    keys = {
        { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'Fuzzy search' },
        { '<leader>fw', '<cmd>Telescope live_grep<CR>', desc = 'Fuzzy word search' },
        { '<leader>b', '<cmd>Telescope buffers<CR>', desc = 'List buffers' },
        { '<leader>gf', '<cmd>Telescope git_status<CR>', desc = 'Git changed files' },
    },
    config = function()
        local telescope = require('telescope')
        telescope.setup {
            extensions = {
                project = {
                    base_dirs = { '$HOME/dev', '$HOME/workspace' },
                    hidden_files = false,
                    order_by = "asc",
                    on_project_selected = function(prompt_bufnr)
                        require('telescope._extensions.project.actions').change_working_directory(prompt_bufnr, false)
                        vim.cmd('Neotree')
                    end,
                }
            },
            defaults = {
                -- Lua patterns: `%.` is a literal dot
                file_ignore_patterns = {
                    "%.git/",
                    "%.idea/",
                    "%.next/",
                    "%.build/",
                    "var/cache/",
                }
            }
        }

        telescope.load_extension('fzf')
        telescope.load_extension('project')
    end,
}
