local fn, api = vim.fn, vim.api
local install_dir  = ('%s/site/'):format(vim.fn.stdpath('data'))
local packer_compiled = install_dir..'plugs/packer_compiled.vim'
local packer_dir = install_dir..'pack/packer/opt/packer.nvim'
local packer = nil

local plugs = {}

function plugs.check_manager()
    if fn.empty(fn.glob(install_dir)) > 0 then
        local cmd = '!git clone https://github.com/wbthomason/packer.nvim ' ..packer_dir
        api.nvim_command(cmd)
        api.nvim_command('packadd packer.nvim')
    end
end


function plugs.load_plugs()
    if not packer then
        api.nvim_command('packadd packer.nvim')
        packer = require('packer')
    end

    packer.init({
        compile_path = packer_compiled,
        display = {
            open_fn = require'packer.util'.float,
        },
    })

    packer.reset()

    return packer.startup(function(use)
        -- Packer can manage itself as an optional plugin
        use {'wbthomason/packer.nvim', opt = true}

        -- ####################################################
        -- ## Language Servers/ Autocomplete / Snippets / Debug
        -- ####################################################
       -- ## Lsp
        use {
            {'glepnir/lspsaga.nvim', opt=true},
            {'neovim/nvim-lspconfig', config = "require'plugs.lsp'"},
            {'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline', config = "require'plugs.nvim-outline'"},
            'folke/lsp-colors.nvim',
        }
        -- ## Autocomplate
        use {
            {'steelsojka/pears.nvim', config = "require'plugs.nvim-pears'"},
            {'thehappyboy/friendly-snippets', event = 'InsertEnter'},
            {'hrsh7th/vim-vsnip', event = 'InsertCharPre', config = "require'plugs.nvim-vsnip'"},
            {'hrsh7th/vim-vsnip-integ', opt=true},
            {"hrsh7th/nvim-compe", event = 'InsertEnter', config = "require'plugs.nvim-compe'"}
        }
        -- ## Debug
        use {
            {'nvim-telescope/telescope-dap.nvim', opt=true},
            {'theHamsta/nvim-dap-virtual-text', opt=true},
            {'mfussenegger/nvim-dap-python', ft = 'python'},
            {'mfussenegger/nvim-dap', ft='python', config = "require'plugs.nvim-dap'"},
        }

        -- ####################################################
        -- ## UI
        -- ####################################################
        -- ## Icons
        use {'kyazdani42/nvim-web-devicons', config = "require'plugs.nvim-devicons'"}
        -- ## Status Line & Bufferline
        use {
            {'romgrk/barbar.nvim', config = "require'plugs.nvim-barbar'"},
            {'glepnir/galaxyline.nvim', config = "require'plugs.nvim-galaxyline'"}
        }
        -- ## Color
        use {
            {'christianchiarulli/nvcode-color-schemes.vim', opt=true},
            {'sainnhe/everforest', opt=true},
        }
        use {'norcalli/nvim-colorizer.lua', config = "require'plugs.nvim-colorizer'",
            ft = {'lua','html','css','sass','vim','typescript','typescriptreact'}
        }
        -- ## Indentline
        use {
            'lukas-reineke/indent-blankline.nvim', branch = 'lua', event = 'BufRead',
            config ="require'plugs.nvim-indentline'"
        }
        use 'wfxr/minimap.vim'

        -- ####################################################
        -- ## Tools
        -- ####################################################
        -- ## Edit Tools
        use {
            -- Add surround to textobjects
            {'machakann/vim-sandwich', config = "vim.g.sandwich_no_default_key_mappings = 1"},
            -- Using dot to repeat operation
            'tpope/vim-repeat',
            -- Jump to edit position
            {'phaazon/hop.nvim', branch = 'pre-extmarks', cmd = {'HopWord', 'HopLine', 'HopChar1', 'HopChar2', 'HopPattern'}},
            'rhysd/clever-f.vim',
            'rhysd/accelerated-jk',
            -- Comment Toggle
            {'terrortylor/nvim-comment', keys = {'gc', 'gcc'}, cmd = 'CommentToggle', config = "require'nvim_comment'.setup({comment_empty=false})"},

            -- ## Navigation Tools
            -- Window navigation
            {'numToStr/Navigator.nvim', config = "require'Navigator'.setup({auto_save=true, disable_on_zoom=true})"},
            {'t9md/vim-choosewin', cmd = {'ChooseWin', 'ChooseWinSwapStay'}, config = "require'plugs.nvim-choosewin'"},
            -- QuickFix better
            {'kevinhwang91/nvim-bqf', opt=true},
            -- Undo Operation
            {'mbbill/undotree', cmd = 'UndotreeToggle', config = "vim.g.undotree_SetFocusWhenToggle = 1"},
            -- Align
            'junegunn/vim-easy-align',

            -- ## Enhancement
            -- File Explorer
            {'kyazdani42/nvim-tree.lua', config = "require'plugs.nvim-tree'"},
            -- Term
            {'numtostr/FTerm.nvim', config = "require'plugs.nvim-fterm'"},
            'editorconfig/editorconfig-vim'
       }


        -- ## Key binds
        use {'folke/which-key.nvim', config ="require'plugs.nvim-whichkey'"}

        -- ### Fuzzy Search
        use {
            {'nvim-lua/popup.nvim', opt = true},
            {'nvim-lua/plenary.nvim', opt = true},
            {'nvim-telescope/telescope-fzy-native.nvim', opt=true},
            {'nvim-telescope/telescope.nvim', cmd = 'Telescope', config = "require'plugs.nvim-telescope'"},
        }

        -- ### Treesitter
        use {
            {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', event='VimEnter', config = "require'plugs.nvim-treesitter'"},
            {'nvim-treesitter/nvim-treesitter-textobjects', opt=true},
            {'p00f/nvim-ts-rainbow', opt=true},
            -- {'JoosepAlviste/nvim-ts-context-commentstring', opt=true}
        }

        -- FilteType
        use { 'npxbr/glow.nvim', ft='markdown' }

    end)
end


function plugs:init()
    self.check_manager()
    self.load_plugs()
    packer.install()
    packer.compile()
end

return plugs
