return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'mason-org/mason.nvim',
  },
  keys = {
    {
      '<leader>d<F1>',
      function()
        require('dap').continue()
      end,
      desc = '[D]ebug: Go (F1)',
    },
    {
      '<leader>dl',
      function()
        require('dap').step_into()
      end,
      desc = '[D]ebug: Step Into (L)',
    },
    {
      '<leader>dj',
      function()
        require('dap').step_over()
      end,
      desc = '[D]ebug: Step Over (J)',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = '[D]ebug: Step [O]ut',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[D]ebug: Toggle [B]reakpoint',
    },
    {
      '<leader>dC',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[D]ebug: Set Breakpoint (with [C]ondition)',
    },
    {
      '<leader>td',
      function()
        require('dapui').toggle()
      end,
      desc = '[T]oggle [D]ebug UI',
    }
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dotnet_helpers = require 'helper.dotnet'

    local netcoredbg_adapter = {
      type = 'executable',
      command = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    dap.adapters.netcoredbg = netcoredbg_adapter
    dap.adapters.coreclr = netcoredbg_adapter

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'LAUNCH directly from nvim',
        request = 'launch',
        args = {
          '-lp',
          'AzureDev', -- Use AzureDev launch profile for debugging
        },
        program = function()
          return dotnet_helpers.build_dll_path()
        end,
      },
    }

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
  end,
}
