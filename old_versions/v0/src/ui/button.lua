-- Context: UI object.
-- Base for creating buttons by extending this class.
-----------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local handyCode = require("src.handyCode")
-----------------------------------------------------

local Button = Object:extend()

function Button:new(scene, string, x, y, color)
    self.x, self.y = x, y

    -- Create text.
    self.string = string
    self.textColor = {0,0,0}
    self.font = _G.gameAsssets.fonts.genericFont
    self.text = love.graphics.newText(self.font, self.string)
    self.textW = self.text:getWidth()
    self.textH = self.text:getHeight()

    -- Look and feel.
    if not (color == nil) then
        self.bgColor = color
    else
        self.bgColor = {0.7, 0.7, 0.7}
    end
    self.darkFact = 0.7 -- Make a darker variation of the chosen color for when the mouse is above the button.
    self.darkBgColor = {self.bgColor[1]*self.darkFact, self.bgColor[2]*self.darkFact, self.bgColor[3]*self.darkFact}

    self.border = 5
    self.w = self.textW + self.border*2
    self.h = self.textH + self.border*2

    -- Properties.
    self.isHovered = false
end

function Button:checkMousePosition()
    -- Check if cursor is above.
    self.mX, self.mY = love.mouse.getPosition()
    if (handyCode.aabb(self.x, self.y, self.w, self.h, self.mX, self.mY, 0, 0)) then
        self.isHovered = true
    else
        self.isHovered = false
    end
end

function Button:customUpdate(scene, dt)
    -- This update is left blank because this function 
    -- is meant to be overwritten in case the developer
    -- needs a custom update function and yet doesn't
    -- feel like overriding the actual update function.
end

function Button:update(scene, dt)
    self:checkMousePosition()
    self:customUpdate(scene, dt)
end

function Button:draw(scene)
    love.graphics.push("all")
        -- Draw rectangle.
        if not (self.isHovered) then -- Set color on mouse position.
            love.graphics.setColor(self.bgColor[1], self.bgColor[2], self.bgColor[3])
        else
            love.graphics.setColor(self.darkBgColor[1], self.darkBgColor[2], self.darkBgColor[3])
        end
        love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)

        -- Draw text.
        love.graphics.setColor(self.textColor[1], self.textColor[2], self.textColor[3])
        love.graphics.draw(self.text, self.x + self.border, self.y + self.border) -- Draw text at the center.
    love.graphics.pop()
end

function Button:leftAction(scene)
    -- This is where left button mouse action code shall go.
end

function Button:rightAction(scene)
    -- This is where left button mouse action code shall go.
end

function Button:mousepressed(scene, x, y, button, istouch, presses)
    -- Check if the mouse is above the button.
    if (self.isHovered) then
        if (button == 1) then -- Left button action.
            self:leftAction(scene)
        elseif (button == 2) then -- Right button action
            self:rightAction(scene)
        end
    end
end

return Button