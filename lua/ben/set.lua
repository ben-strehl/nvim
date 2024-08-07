vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.clipboard = unnamedplus

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
if vim.fn.has('linux') == 1 then
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
end
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Split to the right
vim.opt.splitright = true

-- Remove line numbers from terminal buffs
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
       vim.cmd("set nonu")
       vim.cmd("set nornu")
    end
})
