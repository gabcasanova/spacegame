_G.debugEnv = false

-- Check if in debug environiment & start debugger.
local debugger
if arg[2] == "debug" then
	_G.debugEnv = true
	debugger = require("lldebugger")
	debugger.start()
end
---------------------------------------------------

-- Import libraries.

-- Import scripts.
---------------------------------------------------

function love.load()
end

function love.update(dt)
end

function love.draw()
end

-- Show error in VSCode.
if (_G.debugEnv) then
	function love.errorhandler(msg)
    	error(msg, 2)
	end
end