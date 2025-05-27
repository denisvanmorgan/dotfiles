-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
    extensions = {
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
        },
        project = {
            base_dirs = { '$HOME/dev', '$HOME/workspace' },
            hidden_files = false,
            order_by = "asc",
            sync_with_nvim_tree = true,
            on_project_selected = function(prompt_bufnr)
                -- Do anything you want in here. For example:
                require('telescope._extensions.project.actions').change_working_directory(prompt_bufnr, false)
                vim.cmd('Neotree')
            end,
        }
    },
    defaults = {
        file_ignore_patterns = {
            ".git",
            ".idea",
            ".next",
            ".build",
            "var/cache",
        }
    }
}

-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')
require('telescope').load_extension('project')
