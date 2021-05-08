local prepare     = require('core.prepare')
local options     = require('core.options')
local plugs       = require('core.plugs')
local autocmds    = require('core.autocmds')


prepare:init()
options:init()
plugs:init()
autocmds:init()

vim.cmd('colorscheme deus')
