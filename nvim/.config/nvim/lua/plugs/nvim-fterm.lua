require'FTerm'.setup({
  dimensions  = {
    height = 0.8,
    width = 0.8,
    x = 0.5,
    y = 0.5
  },
  border = 'double' -- or 'single'
})


local term = require('FTerm.terminal')
local lazygit = term:new():setup({
    cmd = 'lazygit'
})

local fterm = {}
function fterm:lazygit_toggle()
    lazygit:toggle()
end

return fterm
