local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "boole.lsp.lsp-installer"
require "boole.lsp.handlers".setup()
require "boole.lsp.null-ls"
