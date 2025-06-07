return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
            hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = {
          "",
          "██╗   ██╗██╗",
          "██║   ██║██║",
          "██║   ██║██║",
          "╚██╗ ██╔╝██║",
          " ╚████╔╝ ██║",
          "  ╚═══╝  ╚═╝",
          "",
        },
        footer = {
          '',
          '围奁像天',
        },
      }
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

