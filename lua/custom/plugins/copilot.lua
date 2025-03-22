return {
  -- copilot
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        panel = {
          auto_refresh = true,
          layout = {
            position = 'right',
          },
        },
        suggestion = {},
      }
    end,
  },
}
