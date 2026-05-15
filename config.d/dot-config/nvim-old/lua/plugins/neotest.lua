return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      discovery = {
        enabled = false
      },
      adapters = {
        require 'neotest-vstest' {},
      },
      summary = {
        open = 'botright vsplit | vertical resize 80',
      },
    },
  },
  {
    'nsidorenco/neotest-vstest',
    dependencies = {
      'nvim-neotest/neotest',
    },
  },
}
