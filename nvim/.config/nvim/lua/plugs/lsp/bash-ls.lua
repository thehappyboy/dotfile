-- npm install -g bash-language-server
require'lspconfig'.bashls.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach,
    filetypes = { "sh", "zsh" }
}
