-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local handyCode = require("src.handyCode")
local Button = require ("src.ui.button")
------------------------------------------

local MapUI = Button:extend()

function MapUI:new(scene)
    -- Create buttons.
    self.buttons = {
        zoomIn = Button("Zoom In", 0, 0),
        zoomOut = Button("Zoom Out", 0, 0),
        building = Button("Create building", 0, 0)
    }

    -- Define button actions. --------------------------------
    -- Zoom in button.
    function self.buttons.zoomIn:customUpdate(dt)
        self.x = scene.camera.winWidth - self.w - self.border
        self.y = self.border
    end
    function self.buttons.zoomIn:leftAction()
        -- Ensure zoom doesn't go above max.
        if (scene.camera.scale < scene.camera.maxScale) then
            scene.camera.scale = scene.camera.scale + 0.5
        end
    end

    -- Zoom out button.
    function self.buttons.zoomOut:customUpdate(dt)
        self.x = scene.camera.winWidth - self.w - self.border
        self.y = 50
    end
    function self.buttons.zoomOut:leftAction()
        -- Ensure zoom doesn't go below min.
        if (scene.camera.scale > scene.camera.minScale) then
            scene.camera.scale = scene.camera.scale - 0.5
        end
    end

    -- Create building button.
    function self.buttons.building:customUpdate(dt)
        self.x = scene.camera.winWidth - self.w - self.border
        self.y = 100
    end
    function self.buttons.building:leftAction()
        --
    end
end

function MapUI:update(scene, dt)
    -- Update buttons.
    for index, btn in pairs(self.buttons) do
        btn:update(dt)
    end
end

function MapUI:draw(scene)
    -- Draw buttons.
    for index, btn in pairs(self.buttons) do
        btn:draw()
    end

    -- Draw debug information.
    local mX, mY = love.mouse.getPosition()
    if (_G.debug) then
        love.graphics.print(
            "DEBUG INFORMATION: \n\n" ..
            "FPS: " .. love.timer.getFPS() .. "\n\n" ..
            "Mouse X: " .. mX .. "\n" ..
            "Mouse Y: " .. mY .. "\n" ..
            "Zoom scale: " .. scene.camera.scale, 
        10, 10)
    end
end

function MapUI:mousepressed(scene, x, y, button, istouch, presses)
    -- Update button mouse action.
    for index, btn in pairs(self.buttons) do
        btn:mousepressed(x, y, button, istouch, presses)
    end
end

return MapUI