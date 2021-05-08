-- npm install -g vscode-css-languageserver-bin
require'lspconfig'.cssls.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach
}
