-- npm install -g vscode-html-languageserver-bin

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.html.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach,
    capabilities = capabilities,
    default_config = {
        filetypes = {'html', 'htmldjango'}
        }
}
