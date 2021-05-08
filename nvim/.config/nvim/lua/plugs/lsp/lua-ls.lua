local sumneko_root_path = '/Users/john/.config/language-server/lua-language-server'
local sumneko_binary = '/Users/john/.config/language-server/lua-language-server/bin/macOS/lua-language-server'


require'lspconfig'.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    on_attach = require'plugs.lsp.settings'.common_on_attach,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                enable = true,
                -- Get the language server to recognize the `vim` global
                globals = {'vim', 'packer_plugins'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {[vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true}
            }
        }
    }
}
