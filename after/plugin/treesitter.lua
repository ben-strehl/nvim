require("nvim-treesitter").setup({
  -- List of parser names
  ensure_installed = { "c", "cpp", "lua", "vim", "query" },

  --Install parser synchronously
  sync_install = false,

  auto_install = true,

  ignore_install = {},

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = true,
  },
})
