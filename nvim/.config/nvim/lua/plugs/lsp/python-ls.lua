-- npm install -g pyright

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


require'lspconfig'.pyright.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach,
    capabilities = capabilities,
    handlers = {
        ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = true,
            signs = true,
            underline = true,
            update_in_insert = true
        })
    },
    settings = {
        python = {
            venvPath = '/Users/john/miniconda3/envs'
        }
    }
}

