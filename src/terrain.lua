-- Import libraries.
local Object = require("libs.classic")
---------------------------------------

Terrain = Object:extend()

function Terrain:new()
    self.image = _G.gameAsssets.graphics.terrain_image
    self.w, self.h = self.image:getDimensions()
    self.x, self.y = 0, 0
    
end

function Terrain:update(dt)
    
end

function Terrain:draw()
    

    love.graphics.draw(self.image, self.x, self.y)
end

return Terrain