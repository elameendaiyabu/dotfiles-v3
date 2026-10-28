require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  { 'numToStr/Comment.nvim', opts = {} },

  require 'kickstart/plugins/vim-tmux-navigator',

  require 'kickstart/plugins/gitsigns',

  require 'kickstart/plugins/telescope',
  require 'kickstart/plugins/tokyonight',

  require 'kickstart/plugins/fidget',

  require 'kickstart/plugins/lspkind',
  require 'kickstart/plugins/lspconfig',

  require 'kickstart/plugins/conform',

  require 'kickstart/plugins/cmp',

  require 'kickstart/plugins/todo-comments',

  require 'kickstart/plugins/mini',

  require 'kickstart/plugins/treesitter',

  require 'kickstart/plugins/autotag',

  --  require 'kickstart/plugins/null-ls',
  require 'kickstart.plugins.lint',

  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.notify',
  require 'kickstart.plugins.trouble',
  require 'kickstart/plugins/lualine',
  -- require 'kickstart/plugins/ale',

  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- vim: ts=2 sts=2 sw=2 et
