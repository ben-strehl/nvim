vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allows us to move lines around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- Maintaining cursor position when jumping around
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allow us to paste over words without losing current paste
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Yank to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")
vim.keymap.set("n", "<leader>P", "\"+P")

-- Delete to void register
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- Reload buffers (for when we do something like cargo fmt)
vim.keymap.set("n", "<leader>r", ":bufdo :e<CR>")

-- Apparently Q sucks and we need ot unbind it
vim.keymap.set("n", "Q", "<nop>")

-- Quicker window controls
vim.keymap.set("n", "<leader>v", "<C-w>v")
vim.keymap.set("n", "<leader>s", "<C-w>s")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>|", "<C-w>|")
vim.keymap.set("n", "<leader>_", "<C-w>_")
vim.keymap.set("n", "<leader>f", "<C-w>|<BAR><C-w>_")
vim.keymap.set("n", "<leader>=", "<C-w>=")
vim.keymap.set("n", "<leader>>", "<C-w>>")
vim.keymap.set("n", "<leader><", "<C-w><")
vim.keymap.set("n", "<leader>-", "<C-w>-")
vim.keymap.set("n", "<leader>+", "<C-w>+")

-- Quick notes and todos
if vim.bo.filetype == "lua" then
  vim.keymap.set("n", "<leader>n", "O-- NOTE(ben):<Esc>A<Space>")
  vim.keymap.set("n", "<leader>m", "O-- TODO(ben):<Esc>A<Space>")
else
  vim.keymap.set("n", "<leader>n", 'O// NOTE(ben):<Esc>A<Space>')
  vim.keymap.set("n", "<leader>m", 'O// TODO(ben):<Esc>A<Space>')
end

-- Terminal in nvim
if vim.fn.has('linux') == 1 or vim.fn.has('mac') == 1 then
  vim.keymap.set("n", "<leader>t", function()
    vim.cmd("vsplit term://bash")
  end)
else
  vim.keymap.set("n", "<leader>t", function()
    vim.cmd("vsplit term://cmd")
  end)
end
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

if vim.fn.has('mac') ~= 1 then
  vim.keymap.set({ 'n', 'v' }, "<leader>b", function()
    local enter_code = vim.api.nvim_replace_termcodes("<CR>", false, false, true)
    local buf = vim.api.nvim_create_buf(false, false) + 1
    vim.cmd("belowright split")
    vim.cmd("resize 20")
    vim.cmd("terminal")
    vim.cmd("setlocal nonumber norelativenumber nobuflisted")
    vim.api.nvim_buf_set_keymap(
      buf,
      "t", "<C-T>", "<cmd>close<CR>",
      { noremap = true, silent = true }
    )
    vim.cmd("bprev")
    vim.cmd.b(buf)
    vim.cmd("startinsert!")
    if vim.fn.has('linux') == 1 then
      vim.api.nvim_feedkeys("./build.sh"
        .. enter_code, 't', true)
    else
      vim.api.nvim_feedkeys("build"
        .. enter_code, 't', true)
    end
  end)
end

-- Scratch file
vim.keymap.set("n", "<leader>S", function()
  vim.cmd("vsplit")
  local scratch_path = ""
  if vim.fn.has('linux') == 1 or vim.fn.has('mac') == 1 then
    scratch_path = os.getenv("HOME") .. "/scratch.txt"
  else
    scratch_path = os.getenv("HOMEPATH") .. "/scratch.txt"
  end
  vim.cmd("e " .. scratch_path)
end)
