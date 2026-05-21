vim.pack.add {
    'https://github.com/stevearc/conform.nvim',
}

require('conform').setup {
    notify_on_error = false,
    formatters_by_ft = {
        lua = { 'stylua' },
        xml = { 'csharpier' },
        cs = { 'csharpier' },
        json = { 'jq' },
        rust = { 'rustfmt' }
    },
}
