local options = {}

local utils = require('core.utils')
local globals = require('core.globals')


options.g = {
    termguicolors = true,		-- enable 24bit true color
    background = 'dark',
    mouse = 'nv',				-- enable mouse in normal and visual mode
    errorbells = false,
    visualbell = false,
    hidden = true,
    magic = true,
    virtualedit = 'block',
    encoding = 'utf-8',
    syntax = 'on',
    backspace = 'indent,eol,start',
    fillchars = 'vert:│',
    viewoptions = 'folds,cursor,curdir,slash,unix',
    clipboard = 'unnamedplus',		-- copy paste between vim and everything else
    wildignorecase = true,
    wildmenu = true,
    wildignore = '.git,*.pyc,*.o,**/tmp/**,*.DS_Store,**/node_modules/**',
    backup = false,
    writebackup = false,
    directory = utils.path_join(globals.cache_dir, globals.caches.swap),
    undodir = utils.path_join(globals.cache_dir, globals.caches.undo),
    backupdir = utils.path_join(globals.cache_dir, globals.caches.backup),
    history = 1000,
    smarttab = true,
    shiftround = true,
    timeout = true,
    ttimeout = true,
    timeoutlen = 400,
    ttimeoutlen = 400,
    updatetime = 400,   -- Faster completion
    redrawtime = 500,
    ignorecase = true,
    smartcase = true,
    infercase = true,
    incsearch = true,
    wrapscan = true,
    splitbelow = true,			-- Horizontal splits will automatically be below
    splitright = true,			-- Vertical splits will automatically be to the right
    showtabline = 0,			-- Hidden tabline
    showmode = false,			-- Hidden --INSERT,NORMAL mode
    shortmess = 'acAIF',		-- Donot pass messages such as |ins-completion-menu|
    scrolloff = 3,
    sidescrolloff = 5,
    foldlevelstart = 99,
    pumheight = 10, -- make popup menu smaller
    cmdwinheight = 2, -- More space for displaying messages
    laststatus = 2,
    showbreak = '↳  ',
    completeopt = 'noselect,menuone',
    listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←,eol:↲',
    title = true,
    titlestring = '%<%F%=%l/%L - nvim',
    inccommand= 'split',
    whichwrap = 'h,l,<,>,[,],~',
}

options.w = {
    foldlevel = 99,
    conceallevel = 2,
    wrap = false,				-- Display long lines as just one line
    number = true,				-- Show line number
    relativenumber = true,		-- Show line relativenumber
    cursorline = true,			-- Enable highlighting of the current line
    colorcolumn = '120',
    signcolumn = 'yes',			-- Always show signcolumn
    listchars = 'tab:»·,eol:↲,nbsp:+,trail:·,extends:→,precedes:←',
    list = true,                -- display listchars
}

options.b = {
    swapfile = false,
    undofile = true,
    expandtab = true,	-- translate tabs to spaces
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    autoindent = true,
    smartindent = true,
    fileencoding = 'utf-8' -- the encoding written to file
}

function options:init()
    vim.cmd([[set iskeyword+=-]]) -- treat dash seperate words as a word text object

    for option, value in pairs(self.g) do
        vim.o[option] = value
    end

    for option, value in pairs(self.w) do
        vim.wo[option] = value
    end

    for option, value in pairs(self.b) do
        vim.bo[option] = value
        vim.o[option] = value
    end
end

return options


