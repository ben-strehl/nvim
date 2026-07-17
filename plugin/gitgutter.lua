vim.pack.add({ 'https://github.com/airblade/vim-gitgutter' })

vim.g.gitgutter_map_keys = "0"

vim.keymap.set("n", "]c", function() vim.cmd("GitGutterNextHunk") end)
vim.keymap.set("n", "[c", function() vim.cmd("GitGutterPrevHunk") end)
