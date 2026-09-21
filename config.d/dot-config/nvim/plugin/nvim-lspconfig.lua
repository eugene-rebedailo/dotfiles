vim.pack.add {
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/seblyng/roslyn.nvim',
}

vim.lsp.config('lua_ls', {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                version = 'LuaJIT',
                path = {
                    'lua/?.lua',
                    'lua/?/init.lua',
                },
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    vim.api.nvim_get_runtime_file('lua/lspconfig', false)[1],
                },
            },
        })
    end,
    on_attach = function()
        local keymap = require('keymap')
        keymap.bind_lsp_commands()
        keymap.bind_debug_commands()
    end,
    settings = {
        Lua = {},
    },
})

vim.lsp.enable 'lua_ls'

vim.lsp.config('rust_analyzer', {
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = true,
            },
        },
    },
    on_attach = function()
        require('keymap').bind_lsp_commands()
    end,
})

vim.lsp.enable 'rust_analyzer'
local roslyn = require 'roslyn'
roslyn.setup {
    config = {
        filetypes = { 'cs', 'csproj' },
        filewatching = 'roslyn',
        settings = {
            ['csharp|background_analysis'] = {
                dotnet_analyzer_diagnostics_scope = 'fullSolution',
                dotnet_compiler_diagnostics_scope = 'fullSolution',
            },
            ['csharp|completion'] = {
                dotnet_show_completion_items_from_unimported_namespaces = true,
            },
        },
    },
}

vim.lsp.config('roslyn', {
    on_attach = function()
        local keymap = require('keymap')
        keymap.bind_lsp_commands()
        -- Debugging or testing has nothing to do with LSP, but it really is easier
        -- to bundle these options together.
        keymap.bind_debug_commands()
        keymap.bind_test_commands()
        keymap.bind_debug_test_commands()
    end,

    settings = {
        ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
        },
        ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
        },
        ['csharp|completions'] = {
            dotnet_show_completion_items_from_unimported_namespaces = true,
        },
    },
})

vim.lsp.enable 'roslyn'
