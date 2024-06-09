-- Context: game object.
-- Create isometric buildings in the game by extending this class.
------------------------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")

-- Import Scripts.
local handyCode = require("src.handyCode")
------------------------------------------------------------------

local Building = Object:extend()

function Building:new(x, y, tw, th, spritesheet, spriteQuantity, spriteIndex)
    self.x, self.y = x, y
    self.tileWidth, self.tileHeight = tw, th -- Tile size of the building in the grid.

    -- Set spritesheet. -------------------------------------------
    -- Default building sprite.
    if (spritesheet == nil) then
        self.spritesheet = _G.gameAsssets.graphics.isoCube
        self.spriteQuantity = 4
        self.spriteIndex = 1
        self.tileWidth, self.tileHeight = 1, 1
    else
        self.spritesheet = spritesheet
        self.spriteQuantity = spriteQuantity
        self.spriteIndex = spriteIndex
    end

    -- Get spritesheet size and set the sprite size based 
    -- on the length of the spritehseet. This means that 
    -- each sprite should have the same horizontal size.
    self.spritesheetWidth = self.spritesheet:getWidth()
    self.spritesheetHeight = self.spritesheet:getHeight()
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

    -- Mouse collision mask.
    -- The mask should be at the bottom of the sprite, a and a    
    -- little bit than half of it's vertical and horizontal size.
    self.maskX = self.x + self.spriteWidth/4
    self.maskY = self.y+self.spriteHeight/2
    self.maskW = self.spriteWidth/2-5             -- Currently, since my masks are a little bit bigger than they
    self.maskH = self.spriteHeight/2-1.5          -- should be, i'm using some magic numbers to make them fit
                                                  -- nicely. Magic numbers are NOT recommended and i shall redo
                                                  -- for a more logical approach this once i have newer graphics!
    ---------------------------------------------------------------

    -- Building variables.
    self.isHovered = false
    self.hoverDim = 0.8                           -- How dark the building will be when hovered.
end

function Building:update(dt)
    -- Get the mouse position.
    local mX, mY = love.mouse.getPosition()
    local MapCamera = _G.currentScene.camera
    local translatedX, translatedY = handyCode.mousePosToCamPos(mX, mY, MapCamera.x, MapCamera.y, MapCamera.scale)

    -- Check if mouse is hovering the building.
    if (handyCode.aabb(translatedX,translatedY,1,1, self.maskX, self.maskY, self.maskW, self.maskH)) then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function Building:draw()
    love.graphics.push("all")
        -- Draw building.
        if (self.isHovered) then -- Make sprite darker if cursor hovering tile.
            love.graphics.setColor(self.hoverDim, self.hoverDim, self.hoverDim)
        else                     -- Make sprite brighter if not.
            love.graphics.setColor(1,1,1)
        end
        love.graphics.draw(self.spritesheet, self.sprites[self.spriteIndex], self.x, self.y)

        -- Debug.
        if (_G.debug and self.isHovered) then
            -- Sprite size.
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("line", self.x, self.y, self.spriteWidth, self.spriteHeight)

            -- Position and size info.
            love.graphics.setColor(1,1,1)
            love.graphics.print(
                "X: " .. self.x .. "\n" ..
                "Y: " .. self.y .. "\n" ..
                "Size: " .. self.tileWidth .. "," .. self.tileHeight,
                self.x, self.y - 50
            )

            -- Mouse collision mask.
            love.graphics.rectangle("line", self.maskX, self.maskY, self.maskW, self.maskH) 
            
            -- Sprite origin.
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill", self.x, self.y, 5, 5) 
        end
    love.graphics.pop()
end

return Building