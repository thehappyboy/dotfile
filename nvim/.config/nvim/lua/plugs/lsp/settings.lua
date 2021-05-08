local opts = { noremap=true, silent=true }

if not packer_plugins['lspsaga.nvim'].loaded then
  vim.cmd [[packadd lspsaga.nvim]]
end


local saga = require 'lspsaga'
saga.init_lsp_saga({
  code_action_icon = '💡'
})


vim.fn.sign_define( "LspDiagnosticsSignError", {texthl = "LspDiagnosticsSignError", text = "", numhl = "LspDiagnosticsSignError"})
vim.fn.sign_define( "LspDiagnosticsSignWarning", {texthl = "LspDiagnosticsSignWarning", text = "", numhl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define( "LspDiagnosticsSignHint", {texthl = "LspDiagnosticsSignHint", text = "", numhl = "LspDiagnosticsSignHint"})
vim.fn.sign_define( "LspDiagnosticsSignInformation", {texthl = "LspDiagnosticsSignInformation", text = "", numhl = "LspDiagnosticsSignInformation"})


-- symbols for autocomplete
vim.lsp.protocol.CompletionItemKind = {
    "   (Text) ",
    "   (Method)",
    "   (Function)",
    "   (Constructor)",
    " ﴲ  (Field)",
    "[] (Variable)",
    "   (Class)",
    " ﰮ  (Interface)",
    "   (Module)",
    " 襁 (Property)",
    "   (Unit)",
    "   (Value)",
    " 練 (Enum)",
    "   (Keyword)",
    " ﬌  (Snippet)",
    "   (Color)",
    "   (File)",
    "   (Reference)",
    "   (Folder)",
    "   (EnumMember)",
    " ﲀ  (Constant)",
    " ﳤ  (Struct)",
    "   (Event)",
    "   (Operator)",
    "   (TypeParameter)"
}

local function documentHighlight(client, bufnr)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
        hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
        augroup lsp_document_highlight
            autocmd! * <buffer>
            autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]],
            false
        )
    end
end

local lsp_config = {}

function lsp_config.common_on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    documentHighlight(client, bufnr)
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- require "lsp_signature".on_attach()
    -- # Key mappings

    function _G.reload_lsp()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        vim.cmd [[edit]]
    end

    function _G.reload_lsp()
        vim.lsp.stop_client(vim.lsp.get_active_clients())
        vim.cmd [[edit]]
    end

    function _G.open_lsp_log()
        local path = vim.lsp.get_log_path()
        vim.cmd("edit " .. path)
    end

    -- ## lsp mappings
    vim.cmd('command! -nargs=0 LspLog call v:lua.open_lsp_log()')
    vim.cmd('command! -nargs=0 LspRestart call v:lua.reload_lsp()')
    vim.cmd('command! -nargs=0 LspVirtualTextToggle lua require("lsp/virtual_text").toggle()')

    -- show hover doc
    buf_set_keymap('n', 'K',  ':Lspsaga hover_doc<cr>', opts)
    -- jump diagnostic
    buf_set_keymap('n', '<C-p>', ':Lspsaga diagnostic_jump_prev<cr>', opts)
    buf_set_keymap('n', '<C-n>', ':Lspsaga diagnostic_jump_next<cr>', opts)
    buf_set_keymap('n', '[e', "<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", opts)
    buf_set_keymap('n', ']e', "<Cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", opts)
    -- scroll up/down hover doc or definition preview
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    buf_set_keymap('n', '<C-f>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<cr>', opts)
    buf_set_keymap('n', '<C-b>', '<cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<cr>', opts)

end

return lsp_config
