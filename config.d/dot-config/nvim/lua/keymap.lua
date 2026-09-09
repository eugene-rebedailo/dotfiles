local M = {}

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Easy exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- EVIL navigation on windows and panes
vim.keymap.set('n', '<left>', '<Nop>')
vim.keymap.set('n', '<right>', '<Nop>')
vim.keymap.set('n', '<up>', '<Nop>')
vim.keymap.set('n', '<down>', '<Nop>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- Oil with '\'
vim.keymap.set('n', '\\', ':Oil<CR>')

-- Conform format
vim.keymap.set('n', '<leader>f', function()
    require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat current buffer' })

-- Telescope navigation
-- NOTE: Have to lazily require every time to defer until after the plugin is loaded.
vim.keymap.set('n', '<leader>s', '<Nop>', { desc = '[S]earch' })

vim.keymap.set('n', '<leader>sf', function()
    return require('telescope.builtin').find_files()
end, { desc = '[S]earch [F]iles' })

vim.keymap.set('n', '<leader>sg', function()
    return require('telescope.builtin').live_grep()
end, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sr', function()
    return require('telescope.builtin').resume()
end, { desc = '[S]earch [R]esume' })

vim.keymap.set('n', '<leader><leader>', function()
    return require('telescope.builtin').buffers()
end, { desc = '[ ] Open Buffers' })

vim.keymap.set('n', '/', function()
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end)

-- Bind LSP commands - will be called lazily when LSP attaches.
function M.bind_lsp_commands()
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ga', vim.lsp.buf.code_action, { desc = '[G]oto Code [A]ction' })

    vim.keymap.set('n', '<leader>gr', function()
        require('telescope.builtin').lsp_references()
    end, { desc = '[G]oto [R]eferences' })

    vim.keymap.set('n', '<leader>gi', function()
        require('telescope.builtin').lsp_implementations()
    end, { desc = '[G]oto [I]mplementations' })

    vim.keymap.set('n', '<leader>gd', function()
        require('telescope.builtin').lsp_definitions()
    end, { desc = '[G]oto [D]efinitions' })

    vim.keymap.set('n', '<leader>rd', function()
        for _, client in ipairs(vim.lsp.get_clients()) do
            require('workspace-diagnostics').populate_workspace_diagnostics(client, 0)
        end
    end, { desc = '[R]epopulate Workspace [D]iagnostics' })
end

return M
