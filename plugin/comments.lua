vim.pack.add({ 'https://github.com/tpope/vim-commentary' })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.c", "*.h", "*.cpp", "*.c++" },
  command = "setlocal commentstring=//\\ %s"
})
