local api = vim.api
local opts = {silent = true, noremap = true}

require('which-key').setup {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        presets = {
            operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true -- bindings for prefixed with g
        }
    },
    operators = {},
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+" -- symbol prepended to a group
    },
    window = {
        border = "single", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = {1, 0, 1, 0}, -- extra window margin [top, right, bottom, left]
        padding = {2, 2, 2, 2} -- extra window padding [top, right, bottom, left]
    },
    layout = {
        height = {min = 4, max = 25}, -- min and max height of the columns
        width = {min = 20, max = 50}, -- min and max width of the columns
        spacing = 3 -- spacing between columns
    },
    hidden = {"<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = {"<leader>", "<C-r>", "g", "z"} -- or specifiy a list manually
}

local wk = require('which-key')

if not packer_plugins['hop.nvim'].loaded then vim.cmd [[packadd hop.nvim]] end

wk.register({
    ['<leader>'] = {
        b = {
            name = '+buffer',
            c = {':BufferClose<cr>', 'buffer close'},
            b = {':BufferPick<cr>', 'pick buffer'},
            n = {':BufferNext<cr>', 'next-buffer'},
            p = {':BufferPrevious<cr>', 'pervious-buffer'}
        },
        c = {':BufferClose<cr>', 'Buffer Close'},
        d = {
            name = '+debug',
            b = {'<cmd>lua require"dap".toggle_breakpoint()<cr>', 'toggle breakpoint'},
            c = {'<cmd>lua require"dap".continue()<cr>', 'continue'},
            i = {'<cmd>lua require"dap".step_into()<cr>', 'step into'},
            o = {'<cmd>lua require"dap".step_over()<cr>', 'step over'},
            O = {'<cmd>lua require"dap".step_out()<cr>', 'step out'},
            r = {'<cmd>lua require"dap".repl.open()<cr>', 'toggle repl'},
            a = {'<cmd>lua require"dap".run_last()<cr>', 'run last'},
            v = {':Telescope dap variables<cr>', 'check variables'},
            l = {':Telescope dap list_breakpoints<cr>', 'list breakpoints'},
            s = {':Telescope dap configurations', 'dap configrations'},
            f = {':Telescope dap frames', 'dap frames'},
            d = {':Telescope dap commands', 'dap commands'}
        },
        e = {':NvimTreeToggle<cr>', 'NvimTreeToggle'},
        p = {
            name = '+plug_manager',
            u = {':PackerUpdate<cr>', 'packer update'},
            i = {':PackerInstall<cr>', 'packer install'},
            c = {':PackerCompile<cr>', 'packer compile'},
            C = {':PackerClean<cr>', 'packer clean'},
            s = {':PackerSync<cr>', 'packer clean&update'},
            S = {':PackerStatus<cr>', 'plug status'},
            p = {':PackerProfile<cr>', 'plug profile'}
        },
        f = {':Telescope find_files<cr>', 'Find files'},
        g = {
            name = '+git',
            s = {'<Cmd>lua require("gitsigns").stage_hunk()<cr>', 'stage'},
            u = {'<Cmd>lua require("gitsigns").undo_stage_hunk()<cr>', 'unstage'},
            r = {'<Cmd>lua require("gitsigns").reset_hunk()<cr>', 'reset'},
            R = {'<Cmd>lua require("gitsigns").reset_buffer()<cr>', 'reset buffer'},
            p = {'<Cmd>lua require("gitsigns").preview_hunk()<cr>', 'preview'},
            b = {'<Cmd>lua require("gitsigns").blame_line()<cr>', 'blame'},
            S = {"<cmd>Telescope git_status<cr>", "Open changed file"},
            B = {"<cmd>Telescope git_branches<cr>", "Checkout branch"},
            c = {"<cmd>Telescope git_commits<cr>", "Checkout commit"},
            C = {"<cmd>Telescope git_bcommits<cr>", "Checkout commit(for current file)"}
        },
        h = {':nohl<cr>', 'no highlight'},
        l = {
            name = '+lsp',
            a = {':Lspsaga code_action<cr>', 'code action'},
            -- d = {':Lspsaga hover_doc<cr>', 'lsp hover_doc'},
            d = {'<cmd>Telescope lsp_document_symbols<cr>'},
            e = {':Lspsaga show_line_diagnostics<cr>', 'show diagnostics'},
            E = {'<cmd>Telescope lsp_document_diagnostics<cr>', 'lsp_document_diagnostics'},
            f = {"<cmd>lua vim.lsp.buf.formatting()<cr>", 'lsp format'},
            h = {'<cmd>lua vim.lsp.buf.signature_help()<cr>', 'signature help'},
            i = {'<cmd>LspInfo<cr>', 'lsp information'},
            l = {'<cmd>LspLog<cr>', 'Lsp log'},
            p = {'<cmd>Lspsaga preview_definition<cr>', 'Preview Definitions'},
            q = {'<cmd>Telescope quickfix<cr>', 'QuickFix'},
            r = {'<cmd>Lspsaga rename<cr>', 'lsp rename'},
            R = {'<cmd>LspRestart<cr>', 'Lsp Restarts'},
            s = {'<cmd>Lspsaga lsp_finder<cr>', 'lsp finder'},
            t = {'<cmd>LspTypeDefinition<cr>', 'Type Definition'},
            v = {'<cmd>LspVirtualToggle<cr>', 'toggle virtual text'},
            w = {'<cmd>Telescope lsp_workspace_symbols<cr>', 'show workspace symbol'},
            x = {'<cmd>cclose<cr>', 'Close QuickFix'}
        },
        s = {
            name = '+find',
            ['.'] = {'<cmd>Telescope filetypes<cr>', 'filetypes'},
            B = {'<cmd>Telescope git_branches<cr>', 'git branches'},
            c = {'<cmd>Telescope command_history<cr>', 'command history'},
            f = {'<cmd>Telescope find_files<cr>', 'files'},
            h = {'<cmd>Telescope oldfiles<cr>', 'command history'},
            m = {'<cmd>Telescope marks<cr>', 'marks'},
            M = {'<cmd>Telescope man_pages<cr>', 'man_pages'},
            o = {'<cmd>Telescope vim_options<cr>', 'vim_options'},
            r = {'<cmd>Telescope registers<cr>', 'registers'},
            t = {'<cmd>Telescope live_grep<cr>', 'search text in project'},
            u = {'<cmd>Telescope colorscheme<cr>', 'colorschemes'}
        },
        t = {
            name = '+toggle',
            s = {'<cmd>Dashboard<cr>', 'Open Start Screen'},
            c = {'<cmd>DashboardChangeColorscheme<cr>', 'Change Colorscheme'},
            e = {'<cmd>NvimTreeToggle<cr>', 'Toggle File Explorer'},
            o = {'<cmd>SymbolsOutline<cr>', 'Toggle Symbols View'},
            t = {'<cmd>ToggleTerm<cr>', 'Toggle Terminal'},
            u = {'<cmd><c-u>UndotreeToggle<cr>', 'toggle undotree'}
        },
        w = {
            name = '+window',
            C = {'<cmd>only<CR>', 'Close all other windows'},
            c = {'<cmd>close<CR>', 'Close current window'},
            h = {'<cmd>split<CR>', 'Split horizontally'},
            v = {'<cmd>vsplit<CR>', 'Split vertically'}
        },
        ['<leader>'] = {
            name = '+hop',
            f = {'<cmd>HopChar1<CR>', 'hop char1'},
            c = {'<cmd>HopChar2<CR>', 'hop char2'},
            w = {'<cmd>HopWord<CR>', 'hop word'},
            l = {'<cmd>HopLine<CR>', 'hop line'},
            p = {'<cmd>HopPattern<CR>', 'hop pattern'}
        },
        ['1'] = {'<cmd>BufferGoto 1<cr>', 'which_key_ignore'},
        ['2'] = {'<cmd>BufferGoto 2<cr>', 'which_key_ignore'},
        ['3'] = {'<cmd>BufferGoto 3<cr>', 'which_key_ignore'},
        ['4'] = {'<cmd>BufferGoto 4<cr>', 'which_key_ignore'},
        ['5'] = {'<cmd>BufferGoto 5<cr>', 'which_key_ignore'},
        ['6'] = {'<cmd>BufferGoto 6<cr>', 'which_key_ignore'},
        ['7'] = {'<cmd>BufferGoto 7<cr>', 'which_key_ignore'},
        ['8'] = {'<cmd>BufferGoto 8<cr>', 'which_key_ignore'},
        ['9'] = {'<cmd>BufferGoto 9<cr>', 'which_key_ignore'},
        ['/'] = {'<cmd>CommentToggle<cr>', 'Comment toggle'},
        ['-'] = {'<Cmd>ChooseWinSwapStay<cr>', 'choose window'},
        ['%'] = {'which_key_ignore'},
    }
})

api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<cr>', {})
api.nvim_set_keymap('n', '<F4>', ':SymbolsOutline<cr>', {})
api.nvim_set_keymap('n', '<F5>', ':ToggleTerm<cr>', {})

-- better window movement
-- api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
-- api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
-- api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)
-- api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)
api.nvim_set_keymap('n', '<C-h>', "<cmd>lua require('Navigator').left()<cr>", opts)
api.nvim_set_keymap('n', '<C-j>', "<cmd>lua require('Navigator').down()<cr>", opts)
api.nvim_set_keymap('n', '<C-k>', "<cmd>lua require('Navigator').up()<cr>", opts)
api.nvim_set_keymap('n', '<C-l>', "<cmd>lua require('Navigator').right()<cr>", opts)
-- Window resieze
api.nvim_set_keymap('n', '<C-Up>', ':resize -2<cr>', opts)
api.nvim_set_keymap('n', '<C-Down>', ':resize +2<cr>', opts)
api.nvim_set_keymap('n', '<C-Left>', ':vertical resize -2<cr>', opts)
api.nvim_set_keymap('n', '<C-Right>', ':vertical resize +2<cr>', opts)
-- better indenting
api.nvim_set_keymap('v', '<', '<gv', opts)
api.nvim_set_keymap('v', '>', '>gv', opts)
-- better cursor move
api.nvim_set_keymap('n', 'j', 'gj', opts)
api.nvim_set_keymap('n', 'k', 'gk', opts)
-- Jump to the first non-whitespace characters
api.nvim_set_keymap('i', '<C-a>', '<C-o>I', opts)
api.nvim_set_keymap('', '<C-a>', '^', opts)
-- Jump to the end of the line
api.nvim_set_keymap('i', '<C-e>', '<C-o>A', opts)
api.nvim_set_keymap('', '<C-e>', '$', opts)
-- Terminal
api.nvim_set_keymap('t', '<ESC>', [[<C-\><C-n>]], opts)
-- Insert
api.nvim_set_keymap('i', '<C-w>', '<C-[>diwa', opts)
api.nvim_set_keymap('i', '<C-h>', '<BS>', opts)
api.nvim_set_keymap('i', '<C-d>', '<Del>', opts)
api.nvim_set_keymap('i', '<C-s>', '<ESC>:w<cr>', opts)
api.nvim_set_keymap('i', '<C-q>', '<ESC>:wq<cr>', opts)
-- Command line
api.nvim_set_keymap('c', '<C-b>', '<Left>', opts)
api.nvim_set_keymap('c', '<C-f>', '<Right>', opts)
api.nvim_set_keymap('c', '<C-a>', '<Home>', opts)
api.nvim_set_keymap('c', '<C-e>', '<End>', opts)
api.nvim_set_keymap('c', '<C-d>', '<Del>', opts)
api.nvim_set_keymap('c', '<C-h>', '<BS>', opts)
api.nvim_set_keymap('c', '<C-t>', [[<C-R>=expand("%:p:h") . "/" <CR>]], opts)
-- Vim map
api.nvim_set_keymap('n', '<C-s>', ':<C-u>w<cr>', opts)
api.nvim_set_keymap('n', '<C-q>', ':wq<cr>', opts)
api.nvim_set_keymap('n', 'Y', 'y$', opts)
api.nvim_set_keymap('n', '<leader>h', ':nohl<cr>', opts)
-- Toggle folds
api.nvim_set_keymap('n', ';', 'za', opts)

-- Compe
api.nvim_set_keymap('i', '<cr>', [[compe#confirm()]], {noremap = true, expr = true})
api.nvim_set_keymap('i', '<C-c>', [[compe#close('<C-c>')]], {noremap = true, expr = true, silent = true})
api.nvim_set_keymap('i', '<C-f>', [[compe#scroll({ 'delta': +4 })]], {noremap = true, expr = true})
api.nvim_set_keymap('i', '<C-b>', [[compe#scroll({ 'delta': -4 })]], {noremap = true, expr = true})
api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- ChooseWin
api.nvim_set_keymap('n', '-', '<Cmd>ChooseWin<cr>', opts)
-- Sandwich
api.nvim_set_keymap('n', 'ys', '<Plug>(operator-sandwich-add)', {})
api.nvim_set_keymap('x', 'ys', '<Plug>(operator-sandwich-add)', {})
api.nvim_set_keymap('o', 'ys', '<Plug>(operator-sandwich-g@)', {})
api.nvim_set_keymap('n', 'ds', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',{})
api.nvim_set_keymap('x', 'ds', '<Plug>(operator-sandwich-delete)', {})
api.nvim_set_keymap('n', 'cs', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)',{})
api.nvim_set_keymap('x', 'cs', '<Plug>(operator-sandwich-replace)', {silent = true})
api.nvim_set_keymap('n', 'dsb', '<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',{})
api.nvim_set_keymap('n', 'csb', '<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)',{})
api.nvim_set_keymap('o', 'ib', '<Plug>(textobj-sandwich-auto-i)', {silent = true})
api.nvim_set_keymap('x', 'ib', '<Plug>(textobj-sandwich-auto-i)', {silent = true})
api.nvim_set_keymap('o', 'ab', '<Plug>(textobj-sandwich-auto-a)', {silent = true})
api.nvim_set_keymap('x', 'ab', '<Plug>(textobj-sandwich-auto-a)', {silent = true})
api.nvim_set_keymap('o', 'is', '<Plug>(textobj-sandwich-query-i)', {silent = true})
api.nvim_set_keymap('x', 'is', '<Plug>(textobj-sandwich-query-i)', {silent = true})
api.nvim_set_keymap('o', 'as', '<Plug>(textobj-sandwich-query-a)', {silent = true})
api.nvim_set_keymap('x', 'as', '<Plug>(textobj-sandwich-query-a)', {silent = true})
-- Hop
api.nvim_set_keymap('n', 's', "<cmd>lua require'hop'.hint_char1()<cr>", {silent = true})
api.nvim_set_keymap('n', '<CR>', "<cmd>lua require'hop'.hint_words()<cr>", {silent = true})
-- Barbar
api.nvim_set_keymap('n', ']b', ':BufferNext<CR>', opts)
api.nvim_set_keymap('n', '[b', ':BufferPrevious<CR>', opts)
api.nvim_set_keymap('n', '<S-x>', ':BufferClose<CR>', opts)

