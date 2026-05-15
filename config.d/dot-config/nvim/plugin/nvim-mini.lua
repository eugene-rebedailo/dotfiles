vim.pack.add {
    'https://github.com/nvim-mini/mini.icons',
    'https://github.com/nvim-mini/mini.statusline',
}

require('mini.icons').setup()
local statusline = require 'mini.statusline'
statusline.setup { use_icons = true }
statusline.section_location = function()
    return '%2l:%-2v'
end
