vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "yg$")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-L>", "20zl")
vim.keymap.set("n", "<C-H>", "20zh")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>")

vim.keymap.set("v", "<leader>(", "di()<Esc>Pva(")
vim.keymap.set("v", "<leader>{", "di{}<Esc>Pva{")
vim.keymap.set("v", "<leader>\"", "di\"\"<Esc>Pva\"")
vim.keymap.set("v", "<leader>'", "di''<Esc>Pva'")

vim.keymap.set("n", "<leader>-(", "di(hPl2x")
vim.keymap.set("n", "<leader>-{", "di{hPl2x")
vim.keymap.set("n", "<leader>-\"", "di\"hPl2x")
vim.keymap.set("n", "<leader>-'", "di'hPl2x")
