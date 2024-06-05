-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local Button = require ("src.ui.button")
----------------------------------------

local MapUI = Button:extend()

function MapUI:new()
    -- Create buttons.
    self.buttons = {
        zoomIn = Button("Zoom In", 0, 0)
    }


    -- Define button functions.
    function self.buttons.zoomIn:customUpdate(dt)
        self.x = _G.gameCamera.winWidth - self.w - self.border
        self.y = self.border
    end

end

function MapUI:update(dt)
    -- Update buttons.
    for k, button in pairs(self.buttons) do
        button:update(dt)
    end
end

function MapUI:draw()
    -- Draw buttons.
    for k, button in pairs(self.buttons) do
        button:draw()
    end
end

function MapUI:mousepressed(x, y, button, istouch, presses)
    -- Update button mouse action.
    for k, button in pairs(self.buttons) do
        button:mousepressed(x, y, button, istouch, presses)
    end
end

return MapUI