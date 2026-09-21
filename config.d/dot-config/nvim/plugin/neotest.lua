vim.pack.add {
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/nvim-neotest/neotest',
    'https://github.com/nsidorenco/neotest-vstest',
}

require('neotest').setup {
    discovery = {
        enabled = false,
    },
    adapters = {
        require 'neotest-vstest' {},
    },
    summary = {
        open = 'botright vsplit | vertical resize 80',
    },
}
