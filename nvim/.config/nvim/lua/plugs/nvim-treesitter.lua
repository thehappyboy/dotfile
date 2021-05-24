
if not packer_plugins['nvim-ts-rainbow'].loaded then
    vim.cmd [[packadd nvim-ts-rainbow]]
end


if not packer_plugins['nvim-treesitter-textobjects'].loaded then
    vim.cmd [[packadd nvim-treesitter-textobjects]]
end

-- if not packer_plugins['nvim-treesitter-pairs'].loaded then
--     vim.cmd [[packadd nvim-treesitter-pairs]]
-- end

-- if not packer_plugins['nvim-treesitter-context'].loaded then
--     vim.cmd [[packadd nvim-treesitter-context]]
-- end

-- if not packer_plugins['nvim-ts-context-commentstring'].loaded then
--     vim.cmd [[packadd nvim-ts-context-commentstring]]
-- end


require'nvim-treesitter.configs'.setup {
    ensure_installed = {'python', 'json','lua', 'html', 'css', 'javascript', 'bash', 'css', 'query',},
    ignore_install = {'haskell'},
    highlight = { enable = true},
    rainbow = {enable = true, extended_mode = true},
    indent = {enable = true, disable = {'python'}},
    context_commentstring = {enable = true},
    textobjects = {
        enable = true,
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["al"] = "@loop.outer",
                ["il"] = "@loop.inner"
            }
        }
    },
    -- refactor = {
    --     highlight_definitions = {enable = true},
    --     highlight_current_scope = {enable = true},
    --     navigation = {
    --         enable = true,
    --         keymaps = {
    --             goto_definition = "gnd",
    --             list_definitions = "gnD",
    --             list_definitions_toc = "gO",
    --             goto_next_usage = "<a-*>",
    --             goto_previous_usage = "<a-#>",
    --         },
    --     },
    --     smart_rename = {
    --         enable = true,
    --         keymaps = {
    --             smart_rename = "grr",
    --         },
    --     },
    -- },
    -- pairs = {
    --     enable = true,
    --     disable = {},
    --     highlight_pair_events = {'CursorMoved'},
    --     highlight_self = true,
    --     goto_right_end = false,
    --     keymaps = {
    --         goto_partner = "<leader>%"
    --     },
    -- }
}

vim.api.nvim_exec([[
    set foldmethod=expr
    set foldexpr=nvim_treesitter#foldexpr()
]], false)
