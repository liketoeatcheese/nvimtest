vim.opt.linebreak = true
vim.opt.spell.spelllang = "en_au"
vim.opt.wrap = true
vim.opt.wrap.linebreak = true
vim.cmd[[ set wrap linebreak ]]

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

vim.cmd[[ setlocal spell spelllang=en_us ]]

