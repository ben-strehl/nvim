vim.cmd [[packadd packer.vim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = 'v0.1.9',
    requires = { { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install' }
    }
  }

  use('sainnhe/gruvbox-material')

  use('theprimeagen/harpoon')

  use('tpope/vim-fugitive')

  use('tpope/vim-commentary')

  -- LSP Support
  use('neovim/nvim-lspconfig')             -- Required
  use('williamboman/mason.nvim')           -- Optional
  use('williamboman/mason-lspconfig.nvim') -- Optional

  -- Autocompletion
  use('hrsh7th/nvim-cmp')         -- Required
  use('hrsh7th/cmp-nvim-lsp')     -- Required
  use('hrsh7th/cmp-buffer')       -- Optional
  use('hrsh7th/cmp-path')         -- Optional
  use('saadparwaiz1/cmp_luasnip') -- Optional
  use('hrsh7th/cmp-nvim-lua')     -- Optional

  -- Snippets
  use('L3MON4D3/LuaSnip')             -- Required
  use('rafamadriz/friendly-snippets') -- Optional

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use { 'airblade/vim-gitgutter' }
end)
