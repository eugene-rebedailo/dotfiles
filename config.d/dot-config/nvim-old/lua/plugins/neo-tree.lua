-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
    keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
        filesystem = {
            filtered_items = {
                hide_gitignored = true,
                hide_hidden = false,
                hide_dotfiles = false,
                hide_by_name = {
                    ".DS_Store",
                    "thumbs.db"
                }
            },
            window = {
                mappings = {
                    ['\\'] = 'close_window',
                },
            },
        },
    },
}
