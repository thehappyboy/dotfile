-- npm install -g dockerfile-language-server-nodejs
require'lspconfig'.dockerls.setup {
    on_attach = require'plugs.lsp.settings'.common_on_attach,
	root_dir = vim.loop.cwd
}
