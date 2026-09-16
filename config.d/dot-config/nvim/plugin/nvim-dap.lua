vim.pack.add {
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
}

local dap = require 'dap'
local dapui = require 'dapui'
local dotnet_helpers = require 'helper.dotnet'

local netcoredbg_adapter = {
    type = 'executable',
    command = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg',
    args = { '--interpreter=vscode' },
    enrich_config = function(config, on_config)
        local enriched = vim.deepcopy(config)
        if config.launch_profile_options == nil or #config.launch_profile_options == 0 then
            -- Assuming no launch profiles were available, no need to select anything. Just launch as is.
            -- This might be the case for test debugging.
            print 'Launching without a launch profile'
            on_config(enriched)
        else
            -- If multiple profiles were detected before, need to pick one (or first as default).
            -- This data comes from coreclr launch requests, but not from netcoredbg
            vim.ui.select(config.launch_profile_options, {
                prompt = ('Select launch profile to start (%s)'):format(config.launch_profile_options[1].name),
                format_item = function(item)
                    return item.name
                end,
            }, function(selected_profile)
                selected_profile = selected_profile or config.launch_profile_options[1]
                print('Launching with launch profile: ' .. selected_profile.name)
                enriched.env = selected_profile.env
                on_config(enriched)
            end)
        end
    end,
}

dap.adapters.netcoredbg = netcoredbg_adapter
dap.adapters.coreclr = netcoredbg_adapter

local coreclr_debug = {
    type = 'coreclr',
    name = 'LAUNCH directly from nvim',
    request = 'launch',
    justMyCode = false
    -- Program and ENV are set by dynamic config discovery.
}

setmetatable(coreclr_debug, {
    __call = function(cfg)
        local new_cfg = vim.deepcopy(cfg)
        local project_root = dotnet_helpers.discover_project_root()

        -- Discover some details about the assembly under debug and its available configuration
        -- This is later used by the adapter enrichment step
        new_cfg.program = dotnet_helpers.build_dll_path(project_root)
        new_cfg.launch_profile_options = dotnet_helpers.get_launch_profiles_with_env(project_root)

        return new_cfg
    end,
})

dap.configurations.cs = { coreclr_debug }

-- more minimal ui
dapui.setup {
    expand_lines = true,
    controls = { enabled = false }, -- no extra play/step buttons
    floating = { border = 'rounded' },

    -- Set dapui window
    render = {
        max_type_length = 60,
        max_value_lines = 200,
    },

    -- Only one layout: just the "scopes" (variables) list at the bottom
    layouts = {
        {
            elements = {
                { id = 'scopes', size = 1.0 }, -- 100% of this panel is scopes
            },
            size = 15, -- height in lines (adjust to taste)
            position = 'bottom', -- "left", "right", "top", "bottom"
        },
    },
}

-- Change breakpoint icons
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = {
    Breakpoint = '🛑',
    BreakpointCondition = '⭕',
    BreakpointRejected = '❌',
    LogPoint = '🔻',
    Stopped = '🟥',
}
for type, icon in pairs(breakpoint_icons) do
    local tp = 'Dap' .. type
    local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
    vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close
