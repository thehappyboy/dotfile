local R = require('pears.rule')

require('pears').setup(function(conf)
	conf.pair('(', ')')
	conf.pair('{', '}')
	conf.pair('[', ']')
	conf.pair("'", {
		close = "'",
		should_expand = R.all_of(
			-- Don't expand a quote if it comes after an alpha character
			R.not_(R.start_of_context('[a-zA-Z]')),
			-- Only expand when in a treesitter "string" node
			R.child_of_node('string')
		),
	})
	conf.pair('"', {
		close = '"',
		should_expand = R.all_of(
			-- Don't expand a quote if it comes after an alpha character
			R.not_(R.start_of_context('[a-zA-Z]')),
			-- Only expand when in a treesitter "string" node
			R.child_of_node('string')
		),
	})
	conf.preset('tag_matching')
	-- Completion integration with nvim-compe
	conf.on_enter(function(pears_handle)
		if vim.fn.pumvisible() and vim.fn.complete_info().selected ~= -1 then
			return vim.fn['compe#confirm']('<CR>')
		else
			pears_handle()
		end
	end)
end)
