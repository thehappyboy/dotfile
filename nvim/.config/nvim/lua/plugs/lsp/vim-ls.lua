-- npm install -g vim-language-server
require'lspconfig'.vimls.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach
}
