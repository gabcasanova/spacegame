-- Context: game object.
-- Create isometric buildings in the game by extending this class.
------------------------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")
------------------------------------------------------------------

local Building = Object:extend()

function Building:new(x, y, spritesheet, spriteQuantity, spriteIndex)
    self.x, self.y = x, y

    -- Set spritesheet. -------------------------------------------
    -- Default building sprite.
    if (spritesheet == nil) then
        self.spritesheet = _G.gameAsssets.graphics.isoCube
        self.spriteQuantity = 3
        self.spriteIndex = 1 
    else
        self.spritesheet = spritesheet
        self.spriteQuantity = spriteQuantity
        self.spriteIndex = spriteIndex
    end

    -- Get spritesheet size and set the sprite size based 
    -- on the length of the spritehseet. This means that 
    -- each sprite should have the same horizontal size.
    self.spritesheetWidth = self.spritesheet:getWidth()
    self.spritesheetHeight = self.spritesheet:getWidth()
    self.spriteWidth = self.spritesheetWidth / self.spriteQuantity
    self.spriteHeight = self.spritesheetHeight

    -- Store in a table all the sprite positions as quads.
    self.sprites = {}
    for i = 0, self.spriteQuantity, 1 do
        self.sprites[i+1] = love.graphics.newQuad(
            self.spriteWidth * i, 
            0, 
            self.spriteWidth, 
            self.spriteHeight, 
            self.spritesheet
        )
    end
    ---------------------------------------------------------------
end

function Building:update(dt)
    --
end

function Building:draw()
    -- Draw building.
    love.graphics.draw(self.spritesheet, self.sprites[self.spriteIndex], self.x, self.y)
end

return Building