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
            desc = ' Frecency',
            group = 'Number',
            action = 'Telescope frecency',
            key = 'f',
          },
          {
            desc = ' Recent Files',
            group = 'String',
            action = 'Telescope oldfiles',
            key = 'r',
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
