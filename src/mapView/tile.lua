-- Context: game object.
-- Create isometric buildings in the game by extending this class.
------------------------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")

-- Import Scripts.
local handyCode = require("src.handyCode")
------------------------------------------------------------------

local Tile = Object:extend()

function Tile:new(scene, terrain, row, column, x, y, tilewidth, tileheight, spritesheet, spriteQuantity, spriteIndex)
    self.x, self.y = x, y
    self.rowNum, self.columnNum = row, column               -- Where is the tile placed in the grid.
    self.tileWidth, self.tileHeight = tilewidth, tileheight -- Tile size in the grid.

    self.isHovered = false
    self.hoverDim = 0.8 -- How dark the tile will be when hovered.
    self.destroyable = false

    -- TILE MASK -----------------------------------------------------------
    -- Tile border sprite.
    -- Displays below the tile and is the graphic used as a
    -- base for mouse collision masks.
    self.tileSprite = _G.gameAsssets.graphics.tile
    self.tileSpriteWidth  = self.tileSprite:getWidth()
    self.tileSpriteHeight = self.tileSprite:getHeight()

    -- Mouse collision mask.
    -- The mask should be at the bottom of the sprite, a and a    
    -- little bit than half of it's vertical and horizontal size.
    self.maskX = self.x + self.tileSpriteWidth/4
    self.maskY = self.y + self.tileSpriteHeight/2
    self.maskW = self.tileSpriteWidth/2-5         -- Currently, since my masks are a little bit bigger than they
    self.maskH = self.tileSpriteHeight/2-1.5      -- should be, i'm using some magic numbers to make them fit
                                                  -- nicely. Magic numbers are NOT recommended.

    -- Create collision masks depending on the vertical and 
    -- horizontal size of the tile, all in a single tile.
    local gridSize    = terrain.gridSize
    local tileOffsetX = terrain.tileOffsetX
    local tileOffsetY = terrain.tileOffsetY
    local mapOffsetX  = terrain.mapOffsetX
    local mapOffsetY  = 0

    self.masks = {}                               -- This works pretty much like the grid importer from
    for row = 1, self.tileWidth, 1 do             -- mapview/terrain.lua.
        for column = 1, self.tileHeight, 1 do
            local desiredXPos, desiredYPos = handyCode.gridTileToIsometricTile(
                row, column, gridSize, tileOffsetX, tileOffsetY, mapOffsetX, mapOffsetY
            )
            table.insert(self.masks, {x = self.maskX + desiredXPos, y = self.maskY + desiredYPos})
        end
    end
    ------------------------------------------------------------------------

    -- TILE SPRITESHEET ----------------------------------------------------
    -- Check if tile has a building sprite.
    if (spritesheet ~= nil) then
        self.displaySprite = true
        self.spritesheet = spritesheet
        self.spriteQuantity = spriteQuantity
        self.spriteIndex = spriteIndex

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
    end
    ------------------------------------------------------------------------
end

function Tile:update(scene, dt)
    -- Get the mouse position.
    local mX, mY = love.mouse.getPosition()
    local translatedX, translatedY = handyCode.mousePosToCamPos(mX, mY, scene.camera.x, scene.camera.y, scene.camera.scale)

    -- Check if mouse is hovering the tile(s).
    self.isHovered = false
    for i, mask in pairs(self.masks) do
        if (handyCode.aabb(translatedX,translatedY,1,1, self.masks[i].x, self.masks[i].y, self.maskW, self.maskH)) then
            self.isHovered = true
        end
    end
end

function Tile:draw(scene)
    love.graphics.push("all")
        -- Draw tile.
        if (self.isHovered) then -- Make sprite darker if cursor hovering tile.
            love.graphics.setColor(self.hoverDim, self.hoverDim, self.hoverDim)
        else                     -- Make sprite brighter if not.
            love.graphics.setColor(1,1,1)
        end
        love.graphics.draw(self.tileSprite, self.x, self.y)

        -- Draw building sprite.
        if (self.displaySprite == true) then
            love.graphics.draw(self.spritesheet, self.sprites[self.spriteIndex], self.x, self.y + (self.tileSpriteHeight - self.spriteHeight))
        end

        -- Debug. 
        if (_G.debug and self.isHovered) then
            -- Sprite size.
            love.graphics.setColor(0,0,0)
            love.graphics.rectangle("line", self.x, self.y, self.tileSpriteWidth, self.tileSpriteHeight)

            -- Position and size info.
            love.graphics.setColor(1,1,1)
            love.graphics.print(
                "X: " .. self.x .. "\n" ..
                "Y: " .. self.y .. "\n",
                self.x, self.y - 50
            )

            -- Mouse collision mask(s).
            for i, mask in pairs(self.masks) do
                love.graphics.rectangle("line", self.masks[i].x, self.masks[i].y, self.maskW, self.maskH)     
            end
            
            -- Sprite origin.
            love.graphics.setColor(1,0,0)
            love.graphics.rectangle("fill", self.x, self.y, 5, 5) 
        end
    love.graphics.pop()
end

return Tile