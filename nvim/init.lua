vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.clipboard = 'unnamedplus'
vim.g.have_nerd_font = true

require 'options'

require 'keymaps'

require 'lazy-bootstrap'

require 'lazy-plugins'

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

vim.opt.shortmess:append 'I'
vim.opt.guicursor = ''
vim.opt.swapfile = false

-- clangd fix
local cmp_nvim_lsp = require 'cmp_nvim_lsp'
require('lspconfig').clangd.setup {
  capabilities = cmp_nvim_lsp.default_capabilities(),
  cmd = {
    'clangd',
    '--offset-encoding=utf-16',
  },
}

-- editing lsp popup menu
local cmp = require 'cmp'
cmp.setup {
  formatting = {
    expandable_indicator = true,
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local kind = require('lspkind').cmp_format { mode = 'symbol_text', maxwidth = 50, show_labelDetails = true }(entry, vim_item)
      local strings = vim.split(kind.kind, '%s', { trimempty = true })
      kind.kind = ' ' .. (strings[1] or '') .. ' '
      kind.menu = '    (' .. (strings[2] or '') .. ')'

      return kind
    end,
  },
  window = {
    completion = cmp.config.window.bordered {
      border = 'single',
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
    documentation = cmp.config.window.bordered {
      border = 'single',
      winhighlight = 'Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
    },
  },
  view = {
    entries = {
      name = 'custom',
      selection_order = 'near_cursor',
      follow_cursor = true,
    },
  },
  preselect = cmp.PreselectMode.None,
}
