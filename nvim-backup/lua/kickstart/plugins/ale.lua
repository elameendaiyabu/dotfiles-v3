return {
  'dense-analysis/ale',
  config = function()
    -- Configuration goes here.
    local g = vim.g

    g.ale_fixers = {
      css = { 'prettier' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
    }

    g.ale_fix_on_save = 1
  end,
}
