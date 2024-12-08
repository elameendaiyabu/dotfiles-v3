vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('n', '<C-s>', '<cmd>wa<CR>', { desc = 'save all files' })
vim.keymap.set('i', '<C-s>', '<cmd>wa<CR>', { desc = 'save all files' })
vim.keymap.set('v', '<C-s>', '<cmd>wa<CR>', { desc = 'save all files' })

vim.keymap.set('n', '<leader>w', '<cmd>wa<CR>', { desc = 'save all ' })
vim.keymap.set('i', '<leader>w', '<cmd>wa<CR>', { desc = 'save all ' })
vim.keymap.set('v', '<leader>w', '<cmd>wa<CR>', { desc = 'save all ' })

vim.keymap.set('n', '<leader>tt', "<cmd>exe v:count . 'ToggleTerm'<CR>", { desc = 'toggle term' })
vim.keymap.set('i', '<leader>tt', "<cmd>exe v:count . 'ToggleTerm'<CR>", { desc = 'toggle term' })
vim.keymap.set('v', '<leader>tt', "<cmd>exe v:count . 'ToggleTerm'<CR>", { desc = 'toggle term' })

vim.keymap.set('n', '<leader>q', '<cmd>wqa<CR>', { desc = 'save all and quit' })
vim.keymap.set('i', '<leader>q', '<cmd>wqa<CR>', { desc = 'save all and quit' })
vim.keymap.set('v', '<leader>q', '<cmd>wqa<CR>', { desc = 'save all and quit' })

vim.keymap.set('n', '<leader>Q', '<cmd>q!<CR>', { desc = 'discard and quit' })
vim.keymap.set('i', '<leader>Q', '<cmd>q!<CR>', { desc = 'discard and quit' })
vim.keymap.set('v', '<leader>Q', '<cmd>q!<CR>', { desc = 'discard and quit' })

vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<CR>', { desc = 'Move focus to the upper window' })
