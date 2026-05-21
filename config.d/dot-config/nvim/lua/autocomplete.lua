local M = {}

vim.opt.completeopt = {
    'menuone',
    'noselect',
    'popup',
}

function M.enable_autocomplete(client, bufnr)
    if client:supports_method 'textDocument/completion' then
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(it)
                return {
                    -- Remove inline method signatures in labels:
                    -- only show symbol names.
                    abbr = it.label:gsub('%b()', ''),
                    menu = '',
                }
            end,
        })
    end
end

return M
