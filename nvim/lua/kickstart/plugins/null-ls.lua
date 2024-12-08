return {
  {
    'nvimtools/none-ls.nvim',
    enabled = true,
    dependencies = 'neovim/nvim-lspconfig',
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.diagnostics.markdownlint,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.golines,
          null_ls.builtins.formatting.sqlfmt,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.sqlfluff.with {
            extra_args = { '--dialect', 'postgres' }, -- change to your dialect
          },
          null_ls.builtins.formatting.sql_formatter,
        },
        root_dir = require('null-ls.utils').root_pattern('package.json', '.null-ls-root', '.neoconf.json', '.git'),
      }
    end,
  },
}
