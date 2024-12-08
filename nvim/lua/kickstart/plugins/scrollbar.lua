return {
  {
    'petertriho/nvim-scrollbar',
    event = 'VeryLazy',
    config = function()
      local scrollbar = require 'scrollbar'
      scrollbar.setup {
        show_in_active_only = true,
        handle = {
          blend = 0,
          text = ' ',
          color = '#C7C2C2',
          color_nr = 234,
        },
        marks = {
          Search = { color = '#C9A554' },
          Error = { color = '#fc3e2b' },
          Warn = { color = '#fcec4c' },
          Info = { color = '#5f875f' },
          Hint = { color = '#5f875f' },
          Misc = { color = '#bb7744' },
          Cursor = { color = '#222222', text = ' ' },
        },
      }
    end,
  },
}
