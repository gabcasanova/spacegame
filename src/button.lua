-- Import libraies.
local Object = require("libs.classic")
---------------------------------------

Button = Object:extend()

function Button:new(text, x, y, w, h)
    self.x, self.y = x, y
    self.w, self.h = w, h
    self.text = text
end

function Button:update()
    
end

function Button:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end

return Button