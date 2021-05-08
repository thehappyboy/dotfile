local globals = {}

function globals:init()
    self.os_name         = vim.loop.os_uname().sysname
    self.is_gui          = vim.fn.has('gui_running')
    self.sep             = self.os_name == 'Windows' and '\\' or '/'
    self.home_dir        = vim.loop.os_homedir()
    self.nvim_config_dir = vim.fn.stdpath('config')
    self.data_dir        = vim.fn.stdpath('data')
    self.cache_dir       = vim.fn.stdpath('cache')

    self.caches = {
        swap = 'swap',
        undo = 'undo',
        backup = 'backup',
    }

    self.providers = {
        python3 = '/Users/john/miniconda3/envs/neovim/bin/python',
        clipboard = {
	    name = "macOS-clipboard",
	    copy = {
		["+"] = "pbcopy",
		["*"] = "pbcopy",
	    },
	    paste = {
		["+"] = "pbpaste",
		["*"] = "pbpaste",
	    },
	    cache_enabled = 0
        },
    }
end

globals:init()

return globals
