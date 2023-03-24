local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Open broweser --
keymap("n", "gx", ":execute '!wslview ' . shellescape(expand('<cfile>'), 1)<CR>", opts)

-- Toggle nvimtree
keymap("n", "<c-n>", ":NvimTreeToggle<cr><s-h>", opts)

-- Save file
keymap("n", "<c-s>", ":w<cr>", opts)

-- Copy the whole file
keymap("n", "yaa", "ggVGy", opts)

-- Create new no name buffer
keymap("n", "<leader>n", ":vnew<cr>i", opts)

-- Turn off macros
keymap("n", "q","<Nop>",opts)

-- Turn off macros
keymap("n", "<s-y>","^y$",opts)

-- Delete buffer
keymap("n", "<c-b>", ":Bdelete<cr>", opts)

-- Fuzzy finder
keymap("n", "<c-a>", ":lua require('fzf-lua').files({ cwd = '~/' })<CR>", opts)
keymap("n", "<c-f>", ":lua require('fzf-lua').live_grep()<CR>", opts)


-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jj", "<ESC>", opts)

-- format JSON data
keymap("n", "fjq", ":%! jq<cr>", opts)
keymap("n", "dfjq", ":%! jq -c<cr>", opts)

-- format XML data
keymap("n", "fxml", ":%! xmlstarlet fo<cr>", opts)

-- decode html data
keymap("n", "fhtml", ":%! recode html..ascii<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<A-h>", "<gv", opts)
keymap("v", "<A-l>", ">gv", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("n", "<A-h>", "<gn", opts)
keymap("n", "<A-l>", ">gn", opts)
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- d and u to middle of the screen
keymap("n", "<C-d>", "<C-d>zz", term_opts)
keymap("n", "<C-u>", "<C-u>zz", term_opts)

--[[ -- Harpoon navigation ]]
--[[ keymap("n", "<A-h>", ":lua require('harpoon.ui').nav_file(1)<cr>", term_opts) ]]
--[[ keymap("n", "<A-j>", ":lua require('harpoon.ui').nav_file(2)<cr>", term_opts) ]]
--[[ keymap("n", "<A-k>", ":lua require('harpoon.ui').nav_file(3)<cr>", term_opts) ]]
--[[ keymap("n", "<A-l>", ":lua require('harpoon.ui').nav_file(4)<cr>", term_opts) ]]

-- Toggle current line or with count
vim.keymap.set("n", "gcc", function()
  return vim.v.count == 0 and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_count)"
end, { expr = true })

-- changing . to , to go back a word
keymap("n", ".", ",", term_opts)

-- Toggle in Op-pending mode
vim.keymap.set("n", "gc", "<Plug>(comment_toggle_linewise)")

-- Toggle in VISUAL mode
vim.keymap.set("x", "gc", "<Plug>(comment_toggle_linewise_visual)")
