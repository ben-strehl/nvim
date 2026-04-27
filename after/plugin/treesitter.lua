require('tree-sitter-manager').setup({
  ensure_installed = { 'c', 'cpp', 'lua', 'vimdoc', 'vim' },
  highlight = true
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function() pcall(vim.treesitter.start) end,
})
