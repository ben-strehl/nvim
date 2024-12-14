vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.c", "*.h", "*.cpp", "*.c++" },
  command = "setlocal commentstring=//\\ %s"
})
