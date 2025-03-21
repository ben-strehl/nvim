if vim.fn.has("gui_running") then
  vim.cmd('set guifont=Consolas:h9')
end

vim.opt.relativenumber = true
vim.opt.numberwidth = 1

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
vim.opt.signcolumn = "number"
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

-- Set up custom highlights
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.buftype ~= 'terminal' then
      -- NOTE
      vim.api.nvim_command('highlight Note guibg=green gui=bold ctermbg=green cterm=bold')
      vim.api.nvim_command('syntax clear Note')
      vim.api.nvim_command('syntax match Note "NOTE" contained')

      -- TODO
      vim.api.nvim_command('highlight Todo guibg=red gui=bold ctermbg=red cterm=bold')
      vim.api.nvim_command('syntax clear Todo')
      vim.api.nvim_command('syntax match Todo "TODO" contained')

      -- IMPORTANT
      vim.api.nvim_command('highlight Important guibg=yellow gui=bold ctermbg=yellow cterm=bold')
      vim.api.nvim_command('syntax clear Important')
      vim.api.nvim_command('syntax match Important "IMPORTANT" contained')

      -- Only match in comments
      local commentString = string.sub(vim.bo.commentstring, 0, string.find(vim.bo.commentstring, ' '))
      vim.api.nvim_command('syntax match Comment "' .. commentString .. '.*' .. '" contains=Note,Todo,Important')
    else
      vim.api.nvim_command('syntax clear Comment')
    end
  end
})

-- Set correct spacing for GE files
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.has('mac') == 1 and (vim.bo.filetype == 'c' or vim.bo.filetype == 'cpp') then
      vim.opt.tabstop = 3
      vim.opt.softtabstop = 3
      vim.opt.shiftwidth = 3
    end
    if vim.bo.filetype == 'lua' then
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
    end
  end
})


-- See whitespace in makefiles
vim.opt.listchars = "space:·,tab:->"
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == 'make' then
      vim.api.nvim_command('set list')
    else
      vim.api.nvim_command('set nolist')
    end
  end
})
