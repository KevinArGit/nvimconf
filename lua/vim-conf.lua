vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set smartindent")
vim.cmd("set autoindent")
vim.cmd("set relativenumber")

vim.g.mapleader = " "
vim.opt.fileformat = "unix"
-- Navigation
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

-- vim.api.nvim_set_keymap('i', '<C-h>', '<C-o>db', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('i', '<80><fc>^D<80>kD', '<C-o>dw', { noremap = true, silent = true })

vim.wo.number = true

-- Platformio support for clangd
vim.api.nvim_create_user_command('Pioclang', function(args)
  if args.fargs[1] == 'update' then
    os.execute('~/.stuff/platformio/clang-lib.sh')
  else
    os.execute('~/.stuff/platformio/clang-init.sh')
    vim.cmd('!' .. 'pio run -t compiledb')
  end
end, { nargs = '*' })  -- Allow for optional arguments

-- remove carriage returns
vim.api.nvim_create_user_command('RemoveCarriageReturns', ':%s/\\r//g', {})

-- barbar keybinds
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Goto pinned/unpinned buffer
--                 :BufferGotoPinned
--                 :BufferGotoUnpinned

-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
map('n', '<C-p>',   '<Cmd>BufferPick<CR>', opts)
map('n', '<C-s-p>', '<Cmd>BufferPickDelete<CR>', opts)

-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

-- NeoTest mapping
vim.keymap.set('n', '<leader>mr', '<Cmd>lua require("neotest").run.run()<CR>', { silent = true })
vim.keymap.set('n', '<leader>ms', '<Cmd>lua require("neotest").run.stop()<CR>', { silent = true })
vim.keymap.set('n', '<leader>mw', '<Cmd>lua require("neotest").watch.watch()<CR>', { silent = true })
vim.keymap.set('n', '<leader>mW', '<Cmd>lua require("neotest").watch.stop()<CR>', { silent = true })
vim.keymap.set('n', '<leader>mo', '<Cmd>lua require("neotest").output.open()<CR>', { silent = true })
vim.keymap.set('n', '<leader>mm', '<Cmd>lua require("neotest").summary.open()<CR>', { silent = true })
vim.keymap.set('n', '<leader>mM', '<Cmd>lua require("neotest").summary.close()<CR>', { silent = true })
