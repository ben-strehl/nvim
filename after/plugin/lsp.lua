vim.lsp.set_log_level("off")

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua_ls" },
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  window = {},
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" }, -- For luasnip users.
  }, {
    { name = "buffer" },
  }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>ews", function() vim.lsp.buf.workspace_symbol() end, opts)
    -- vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, opts)
    vim.keymap.set("n", "<leader>eca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>err", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>ern", function() vim.lsp.buf.rename() end, opts)
    -- vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    if client ~= nil and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.lsp.config("clangd", {
  cmd = { "clangd", "--header-insertion=never" },
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- This is key for recognizing 'vim' global
      },
      workspace = {
        -- Add Neovim's runtime Lua library to the workspace
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

-- Shows errors in-line
vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  -- update_in_insert = false,
  -- underline = true,
  -- severity_sort = false,
  -- float = true,
})
