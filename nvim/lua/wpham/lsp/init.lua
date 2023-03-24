local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "wpham.lsp.mason"
require("wpham.lsp.handlers").setup()
require "wpham.lsp.null-ls"
require "wpham.lsp.navigator"
