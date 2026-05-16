local M = {}

vim.opt.completeopt = {
    'menuone',
    'noselect',
    'popup',
}

function M.enable_autocomplete(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
        autotrigger = true,
        convert = function(it)
            return {
                abbr = it.label:gsub('%b()', ''),
                menu = ''
            }
        end,
    })
end

return M
