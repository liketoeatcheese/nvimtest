require('tabnine').setup({
  disable_auto_comment = true,
  accept_keymap = "<s-e>",
  dismiss_keymap = "<C->",
  debounce_ms = 800,
  suggestion_color = { gui = "#808080", cterm = 244 },
  exclude_filetypes = { "TelescopePrompt" }
})

require("wpham.set")
require("wpham.remap")
require("wpham.cmp")
require("wpham.lsp")
require("wpham.treesitter-context")
require("wpham.treesitter")
require("wpham.comment")
require("wpham.bufferline")
require("wpham.autopairs")
require("wpham.nvimtree")
require("wpham.whichkey")
require("wpham.packer")
require("wpham.feline")
require("wpham.fzf")
require("wpham.rusttools")
