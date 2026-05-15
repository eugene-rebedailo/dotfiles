vim.pack.add {
    'https://github.com/mason-org/mason.nvim',
}

require('mason').setup {
    log_level = vim.log.levels.WARN,
}
