local prepare = {}

local globals = require('core.globals')
local utils = require('core.utils')


function prepare.check_dirs()

    if vim.fn.isdirectory(globals.cache_dir) == 0 then
		utils.mkdir(globals.cache_dir)
    end

    for _, dir in pairs(globals.caches) do
		local cache_dir = utils.path_join(globals.cache_dir, dir)
		if vim.fn.isdirectory(cache_dir) == 0 then
			utils.mkdir(cache_dir)
		end
    end

end

function prepare.set_providers()
    vim.g.python3_host_prog = globals.providers.python3
    vim.g.loaded_python_provider = 0
    vim.g.loaded_perl_provider = 0
    vim.g.loaded_ruby_provider = 0

    vim.g.clipboard = globals.providers.clipboard
end

function prepare.set_leaders()
    vim.g.mapleader = ' '
    vim.g.maplocalleader = ','
    vim.api.nvim_set_keymap('n', ' ', '',{noremap = true})
    vim.api.nvim_set_keymap('x', ' ', '',{noremap = true})
    vim.api.nvim_set_keymap('n', ',', '',{noremap = true})
    vim.api.nvim_set_keymap('x', ',', '',{noremap = true})
    vim.api.nvim_set_keymap('n', '<CR>', '',{noremap = true})
    vim.api.nvim_set_keymap('n', 's', '',{noremap = true})
end

function prepare.disable_distribute_plugs()
    vim.g.loaded_gzip              = 1
    vim.g.loaded_tar               = 1
    vim.g.loaded_tarPlugin         = 1
    vim.g.loaded_zip               = 1
    vim.g.loaded_zipPlugin         = 1
    vim.g.loaded_getscript         = 1
    vim.g.loaded_getscriptPlugin   = 1
    vim.g.loaded_vimball           = 1
    vim.g.loaded_vimballPlugin     = 1
    -- vim.g.loaded_matchit           = 1
    -- vim.g.loaded_matchparen        = 1
    vim.g.loaded_2html_plugin      = 1
    vim.g.loaded_logiPat           = 1
    vim.g.loaded_rrhelper          = 1
    vim.g.loaded_netrw             = 1
    vim.g.loaded_netrwPlugin       = 1
    vim.g.loaded_netrwSettings     = 1
    vim.g.loaded_netrwFileHandlers = 1
end

function prepare:init()
    self.check_dirs()
    self.set_providers()
    self.disable_distribute_plugs()
    self.set_leaders()
end

return prepare
