return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = '󰉋 Oil',
            group = 'DiagnosticHint',
            action = 'Oil',
            key = 'o',
          },
          {
            desc = ' Zoxide',
            group = 'Number',
            action = 'Telescope zoxide list',
            key = 'z',
          },
        },
        project = {
          enable = false,
        },
        mru = {
          limit = 10,
          icon = ' ',
          label = ' Recent Files',
          cwd_only = false,
        },
        footer = {},
      },
    })
  end,
}
