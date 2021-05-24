local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
    for group_name, definition in pairs(definitions) do
        vim.api.nvim_command('augroup '..group_name)
        vim.api.nvim_command('autocmd!')
        for _, def in ipairs(definition) do
            local cmd = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
            vim.api.nvim_command(cmd)
        end
        vim.api.nvim_command('augroup END')
    end
end


function autocmd:define_autocmds()
    self.definitions = {
        _general = {
            -- return to last edit position when opening files
            {"BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]},
            -- -- Highlight current line only on focused window
            -- {"WinEnter,BufEnter,InsertLeave", "*", [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]]},
            -- {"WinLeave,BufLeave,InsertEnter", "*", [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]]},
            -- Equalize window dimensions when resizing vim window
            {"VimResized", "*", [[tabdo wincmd =]]},
            -- Check if file changed when its window is focus, more eager than 'autoread'
            {"FocusGained", "* checktime"},
            -- Highlight yanked text for 200ms
            {"TextYankPost", [[* silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=200})]]},
        },

--         _dashboard = {
--             -- seems to be nobuflisted that makes my stuff disapear will do more testing
--             {
--                 'FileType', 'dashboard',
--                 'setlocal nocursorline noswapfile synmaxcol& signcolumn=no norelativenumber nocursorcolumn nospell  nolist  nonumber bufhidden=wipe colorcolumn= foldcolumn=0 matchpairs= '
--             }, {'FileType', 'dashboard', 'set showtabline=0 | autocmd BufLeave <buffer> set showtabline=2'}
--         },

        _markdown = {{'FileType', 'markdown', 'setlocal wrap'}, {'FileType', 'markdown', 'setlocal spell'}},

        -- _django = {
        --     {"BufNewFile,BufRead", "*.html", "set filetype=html.htmldjango"},
        --     {"BufNewFile,BufRead", "*.py", "set filetype=python.django"},
        -- },

        _buffer_bindings = {
            -- {'FileType', 'dashboard', 'nnoremap <silent> <buffer> q :q<CR>'},
            {'FileType', 'lspinfo', 'nnoremap <silent> <buffer> q :q<CR>'},
            {'FileType', 'floaterm', 'nnoremap <silent> <buffer> q :q<CR>'},
        }
    }
end

function autocmd:init()
    self:define_autocmds()
    self.nvim_create_augroups(self.definitions)
end

return autocmd
