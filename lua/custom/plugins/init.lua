-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  {
    'ThePrimeagen/refactoring.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- require('refactoring').setup()
      require('refactoring').setup {
        -- prompt for return type
        prompt_func_return_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
      }

      -- You can also use below = true here to to change the position of the printf
      -- statement (or set two remaps for either one). This remap must be made in normal mode.
      vim.keymap.set('n', '<leader>rp', function()
        require('refactoring').debug.printf { below = true }
      end, { desc = '[R]efactoring add debugging [P]rintf' })

      -- Print var

      vim.keymap.set({ 'x', 'n' }, '<leader>rv', function()
        require('refactoring').debug.print_var()
      end, { desc = '[R]efactoring add debugging print [V]ar' })
      -- Supports both visual and normal mode

      vim.keymap.set('n', '<leader>rc', function()
        require('refactoring').debug.cleanup {}
      end, { desc = '[R]efactoring [C]leanup debugging prints' })
      -- Supports only normal mode
    end,
  },
}
