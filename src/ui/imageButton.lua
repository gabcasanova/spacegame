-- Context: UI object.
-- Base for creating buttons by extending this class.
-----------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local handyCode = require("src.handyCode")
-----------------------------------------------------

local ImageButton = Object:extend()

function ImageButton:new(x, y, spritesheet, spriteQuantity, spriteIndex)
    self.x, self.y = x, y
    self.w, self.h = 0, 0

    -- Properties.
    self.isHovered = false
    self.darkFact = 0.8

    -- SPRITESHEET ---------------------------------------------------------
    self.spritesheet = spritesheet
    self.spriteQuantity = spriteQuantity
    self.spriteIndex = spriteIndex

    -- Get spritesheet size and set the sprite size based 
    -- on the length of the spritehseet. This means that 
    -- each sprite should have the same horizontal size.
    self.spritesheetWidth = self.spritesheet:getWidth()
    self.spritesheetHeight = self.spritesheet:getHeight()
    self.w = self.spritesheetWidth / self.spriteQuantity
    self.h = self.spritesheetHeight

    -- Store in a table all the sprite positions as quads.
    self.sprites = {}
    for i = 0, self.spriteQuantity, 1 do
        self.sprites[i+1] = love.graphics.newQuad(
            self.w * i, 
            0, 
            self.w, 
            self.h, 
            self.spritesheet
        )
    end
    ------------------------------------------------------------------------
end

function ImageButton:checkMousePosition()
    -- Check if cursor is above.
    self.mX, self.mY = love.mouse.getPosition()
    if (handyCode.aabb(self.x, self.y, self.w, self.h, self.mX, self.mY, 0, 0)) then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function ImageButton:customUpdate(dt)
    -- This update is left blank because this function 
    -- is meant to be overwritten in case the developer
    -- needs a custom update function and yet doesn't
    -- feel like overriding the actual update function.
end

function ImageButton:update(dt)
    self:checkMousePosition()
    self:customUpdate(dt)
end

function ImageButton:draw()
    love.graphics.push("all")
        -- Draw rectangle.
        if not (self.isHovered) then -- Set color on mouse position.
            love.graphics.setColor(1, 1, 1)
        else
            love.graphics.setColor(self.darkFact, self.darkFact, self.darkFact)
        end
        love.graphics.draw(self.spritesheet, self.sprites[self.spriteIndex], self.x, self.y)

    love.graphics.pop()
end

function ImageButton:leftAction()
    -- This is where left button mouse action code shall go.
end

function ImageButton:rightAction()
    -- This is where left button mouse action code shall go.
end

function ImageButton:mousepressed(x, y, button, istouch, presses)
    -- Check if the mouse is above the button.
    if (self.isHovered) then
        if (button == 1) then -- Left button action.
            self:leftAction()
        elseif (button == 2) then -- Right button action
            self:rightAction()
        end
    end
end

return ImageButton