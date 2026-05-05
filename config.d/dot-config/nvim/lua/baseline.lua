-- Set up some basic vim defaults.
vim.cmd 'set expandtab'
vim.cmd 'set tabstop=4'
vim.cmd 'set softtabstop=4'
vim.cmd 'set shiftwidth=4'

-- Leader = <Space>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true 
vim.o.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- No break indent - I dislike long lines of text.
vim.o.breakindent = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true

-- Set up whitespace character display. Multispace means that only multiple spaces (like indent)
-- will show up.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', multispace = '.' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
