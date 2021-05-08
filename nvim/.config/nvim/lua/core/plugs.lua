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
        compile_path = packer_compiled
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
            {'simrat39/symbols-outline.nvim', cmd = 'SymbolsOutline', config = "require'plugs.outline'"},
        }
        -- ## Autocomplate
        use {
            {'steelsojka/pears.nvim', config = "require'plugs.nvim-pears'"},
            {'rafamadriz/friendly-snippets', event = 'InsertEnter'},
            {'hrsh7th/vim-vsnip', event = 'InsertCharPre'},
            {"hrsh7th/nvim-compe", event = 'InsertEnter', config = "require'plugs.compe'"}
        }
        -- ## Debug
        use {
            {'nvim-telescope/telescope-dap.nvim', opt=true},
            {'theHamsta/nvim-dap-virtual-text', opt=true},
            {'mfussenegger/nvim-dap-python', ft = 'python'},
            {'mfussenegger/nvim-dap', ft='python', config = "require'plugs.dap'"},
        }

        -- ####################################################
        -- ## UI
        -- ####################################################
        -- ## Icons
        use {'kyazdani42/nvim-web-devicons', config = "require'plugs.nvim-devicons'"}
        -- ## Status Line & Bufferline
        use {
            {'romgrk/barbar.nvim', config = "require'plugs.barbar'"},
            {'glepnir/galaxyline.nvim', config = "require'plugs.galaxyline'"}
        }
        -- ## Color
        use {
            'christianchiarulli/nvcode-color-schemes.vim',
            'sainnhe/sonokai',
            'sainnhe/edge',
            'sainnhe/everforest',
            'wadackel/vim-dogrun',
            'joshdick/onedark.vim',
            'ajmwagar/vim-deus',
        }
        use {'norcalli/nvim-colorizer.lua', config = "require'plugs.colorizer'",
            ft = {'lua','html','css','sass','vim','typescript','typescriptreact'}
        }
        -- ## Indentline
        use {
            'lukas-reineke/indent-blankline.nvim', branch = 'lua', event = 'BufRead',
            config ="require'plugs.nvim-indentline'"
        }
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
            -- Comment Toggle
            {'terrortylor/nvim-comment', keys = {'gc', 'gcc'}, cmd = 'CommentToggle', config = "require'nvim_comment'.setup({comment_empty=false})"},

            -- ## Navigation Tools
            -- Window navigation
            {'numToStr/Navigator.nvim', config = "require'Navigator'.setup({auto_save=true, disable_on_zoom=true})"},
            {'t9md/vim-choosewin', cmd = {'ChooseWin', 'ChooseWinSwapStay'}, config = "require'plugs.choosewin'"},
            -- QuickFix better
            {'kevinhwang91/nvim-bqf', opt=true},
            -- Undo Operation
            {'mbbill/undotree', cmd = 'UndotreeToggle', config = "vim.g.undotree_SetFocusWhenToggle = 1"},

            -- ## Enhancement
            -- File Explorer
            {'kyazdani42/nvim-tree.lua', config = "require'plugs.nvim_tree'"},
            -- Term
            {'akinsho/nvim-toggleterm.lua', config = "require'plugs.nvim-toggleterm'"},
            -- {'numtostr/FTerm.nvim', config = "require('FTerm').setup()"},
            -- {'beauwilliams/focus.nvim', branch = 'cust_filetypes', cmd = 'ToggleFocus', config = "require'plugs.focus'"},
       }


       -- ## Key binds
       use {'folke/which-key.nvim', config ="require'plugs.whichkey'"}

       -- ### Fuzzy Search
       use {
           {'nvim-lua/popup.nvim', opt = true},
           {'nvim-lua/plenary.nvim', opt = true},
           {'nvim-telescope/telescope-fzy-native.nvim', opt=true},
           {'nvim-telescope/telescope.nvim', cmd = 'Telescope', config = "require'plugs.telescope'"},
       }

       -- ### Treesitter
       use {
           {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', event='VimEnter', config = "require'plugs.treesitter'"},
           {'nvim-treesitter/nvim-treesitter-textobjects', opt=true},
           -- {'romgrk/nvim-treesitter-context', opt=true},
           {'p00f/nvim-ts-rainbow', opt=true},
           -- {'theHamsta/nvim-treesitter-pairs', opt=true},
           -- {'JoosepAlviste/nvim-ts-context-commentstring', opt=true}
       }

    end)
end


function plugs:init()
    self.check_manager()
    self.load_plugs()
    packer.install()
    packer.compile()
end

return plugs
