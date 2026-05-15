vim.pack.add {
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/stevearc/oil.nvim',
}

-- mini.icons setup in nvim-mini.lua
require('oil').setup {
    default_file_explorer = true,
    delete_to_trash = false,
    watch_for_changes = true,
    columns = {
        'icon',
    },
    view_options = {
        show_hidden = true,
    },
}
