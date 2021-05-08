vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"

if not packer_plugins['vim-vsnip'].loaded then
    vim.cmd [[packadd vim-vsnip]]
end

require('compe').setup({
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'always',
    source = {
        vsnip = true,
        snippets_nvim = true,
        buffer = true,
        path = true,
        tags = true,
        spell = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        treesitter = true
    }
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#jumpable", {1}) == 1 then
        return t "<Plug>(vsnip-jump-next)"
    else
        return t "<Tab>"
    end
end




_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

vim.g.delimitMate_expand_cr = 0
vim.g.delimitMate_expand_space = 1
vim.g.delimitMate_smart_quotes = 1
vim.g.delimitMate_expand_inside_quotes = 0
vim.api.nvim_command('au FileType markdown let b:delimitMate_nesting_quotes = ["`"]')



