return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },

    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },

    opts = {

      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'css', 'javascript', 'typescript', 'json', 'tsx' },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },

      textobjects = {
        select = {
          enable = true,

          lookahead = true,

          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            ['a='] = '@assignment.outer',
            ['i='] = '@assignment.inner',
            ['l='] = '@assignment.lhs',
            ['r='] = '@assignment.rhs',
            ['ac'] = '@conditional.outer',
            ['ic'] = '@conditional.inner',
          },
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },

        swap = {
          enable = true,
          swap_next = {
            ['<leader>np'] = '@parameter.inner',
            ['<leader>nf'] = '@function.outer',
          },
          swap_previous = {
            ['<leader>pp'] = '@parameter.inner',
            ['<leader>pf'] = '@function.outer',
          },
        },
      },

      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },

      indent = { enable = true, disable = { 'ruby' } },
    },

    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
