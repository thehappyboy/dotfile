-- npm install -g yaml-language-server
require'lspconfig'.yamlls.setup{
    on_attach = require'plugs.lsp.settings'.common_on_attach,
}
