vim.pack.add({ 'https://github.com/romus204/tree-sitter-manager.nvim' })

require('tree-sitter-manager').setup({
  ensure_installed = { 'c', 'cpp', 'lua', 'vimdoc', 'vim' },
})


vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    if vim.treesitter.language.add(vim.bo.filetype) then
      vim.treesitter.start()
      -- Enables regex highlighting
      vim.bo.syntax = 'ON'
    end
  end,
})
