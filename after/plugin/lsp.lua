local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	'rust_analyzer',
    'clangd'
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.set_preferences({
	sign_icons = {}
})

-- clang-format on save
local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
    vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
    vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format()
            filter = function(client)
                return client.name == "clangd"
            end
        end,
    })
end

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>ews", function() vim.lsp.buf.workspace_symbol() end, opts)
	-- vim.keymap.set("n", "<leader>d", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>eca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>err", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>ern", function() vim.lsp.buf.rename() end, opts)
	-- vim.keymap.set("n", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    lsp_format_on_save(bufnr)
end)

lsp.setup()

-- Shows errors in-line
vim.diagnostic.config({
    virtual_text = true,
    -- signs = true,
    -- update_in_insert = false,
    -- underline = true,
    -- severity_sort = false,
    -- float = true,
})

-- Recompile LaTeX on save
require('lspconfig').texlab.setup{
    cmd = {"texlab"},
    filetypes = {"tex", "bib"},
    settings = {
        texlab = {
            rootDirectory = nil,
            build = { 
                executable = 'pdflatex',
                args = {'%f'},
                forwardSearchAfter = true,
                onSave = true
            },
            forwardSearch = {
                executable = "zathura",
                args = {"--synctex-forward", "%l:1:%f", "%p"}
            }
        }
    }
}

