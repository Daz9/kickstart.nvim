return {
  vim.api.nvim_set_keymap('n', '<leader>cl', ':w !npx commitlint<CR>', { noremap = true, silent = true }),
}
