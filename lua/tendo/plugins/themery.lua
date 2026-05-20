return {
  'zaldih/themery.nvim',
  lazy = false,
  config = function()
    require('themery').setup {
      -- add the config here
      themes = {
        { name = 'Tokyo Night [Night]', colorscheme = 'tokyonight-night' },
        { name = 'Vague', colorscheme = 'vague' },
      },
    }
  end,
}
