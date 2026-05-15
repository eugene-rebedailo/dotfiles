vim.pack.add {
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-telescope/telescope-ui-select.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
}

local telescope = require 'telescope'
telescope.setup {
    defaults = {
        file_ignore_patterns = {
            '**/packages.lock.json',
        },
    },

    -- pickers = {}
    extensions = {
        ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
        },
        ['fzf'] = {
            case_mode = 'ignore_case',
        },
    },
}

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'ui-select')
