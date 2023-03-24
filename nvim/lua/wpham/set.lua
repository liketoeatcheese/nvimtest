vim.opt.nu = true
vim.opt.rnu = true
vim.opt.timeoutlen = 500
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.clipboard = "unnamed"
vim.opt.cmdheight = 2
vim.opt.fileencoding = "utf-8"
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showtabline = 2
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.conceallevel = 0
vim.opt.sidescrolloff = 8
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.wrap = false
vim.opt.shortmess:append("c")
vim.opt.list = false
vim.cmd([[set iskeyword+=- ]])

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true
if vim.fn.has("wsl") == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("Yank", { clear = true }),
    callback = function()
      vim.fn.system("clip.exe", vim.fn.getreg('"'))
    end,
  })
end

vim.g.ray_browser = "wslview"

-- nightfly color scheme settings
local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "nightfly",
  callback = function()
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#da5151", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#f69939", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#4f97d9", bold = true })
    vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#4f97d9", bold = true })
    vim.api.nvim_set_hl(0, "incsearch", { fg = "#efa65a", bold = true })
  end,
  group = custom_highlight,
})

require("link-visitor").setup({
	open_cmd = nil,
	--[[ cmd to open url
    defaults:
    win or wsl: cmd.exe /c start
    mac: open
    linux: xdg-open
  --]]
	silent = true, -- disable all prints, `false` by defaultsskip_confirmation
	 skip_confirmation = true, -- Skip the confirmation step, default: false
})
