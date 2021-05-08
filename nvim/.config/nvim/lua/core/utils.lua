local utils = {}
local globals = require('core.globals')

------------- \ mkdir / -------------------
utils.mkdir = vim.fn.mkdir

------------ \ join paths / ---------------
function utils.path_join(path1, path2, ...)
	local sep = globals.sep
	local joined = path1..sep..path2
	for _,path in ipairs({...}) do
		joined = joined..sep..path
	end
	return joined
end

--------- \ insepct variables /----------
function utils.inspect(item)
  print(vim.inspect(item))
end

-------------- \ get_os / ---------------
function utils.get_os()
    --[[
	--	 Target OS names:
	--	 	- Windows
	--	 	- Linux
	--	 	- OSX
	--	 	- BSD
	--	 	- POSIX
	--	 	- Other
	--]]
    return jit.os
end

--------- \ check_plugs_loaded / ---------
function utils.check_plugs_loaded(plug_name)
    if packer_plugins[plug_name].loaded then
        return true
    else
        return false
    end
end


return utils
