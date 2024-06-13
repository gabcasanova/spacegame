-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local handyCode = require("src.handyCode")
local Button = require ("src.ui.button")
local ImageButton = require("src.ui.imageButton")
local ZoomButtons = require("src.mapView.ui.zoomButtons")
-------------------------------------------------------

local MapUI = Object:extend()

function MapUI:new(scene)
    -- Get current screen size.
    local screenW, screenH = love.graphics.getDimensions()

    self.interfaceBackground = {}
    self.interfaceBackground.x = screenW - 128
    self.interfaceBackground.y = 0
    self.interfaceBackground.w = 128

    -- Create buttons.
    self.buttons = {
        zoomIn = ZoomButtons(scene, self, 0, 0, 1),
        zoomOut = ZoomButtons(scene, self, 0, 0, 2),
        move = ZoomButtons(scene, self, 0, 0, 3)
    }
end

function MapUI:update(scene, dt)
    -- Update background position.
    local screenW, screenH = love.graphics.getDimensions() -- Get current screen size.
    self.interfaceBackground.x = screenW - 128
    self.interfaceBackground.h = screenH

    -- Update buttons.
    for index, btn in pairs(self.buttons) do
        btn:update(scene, dt)
    end
end

function MapUI:draw(scene)
    love.graphics.push("all")
        -- Draw background.
        love.graphics.setColor(132/255, 126/255, 135/255)
        local bg = self.interfaceBackground
        love.graphics.rectangle("fill", bg.x, bg.y, bg.w, bg.h)

        -- Draw buttons.
        for index, btn in pairs(self.buttons) do
            btn:draw(scene)
        end

        -- Draw debug information.
        local mX, mY = love.mouse.getPosition()
        if (_G.debug) then
            love.graphics.setColor(1, 1, 1)
            love.graphics.print(
                "DEBUG INFORMATION: \n\n" ..
                "FPS: " .. love.timer.getFPS() .. "\n\n" ..
                "Mouse X: " .. mX .. "\n" ..
                "Mouse Y: " .. mY .. "\n" ..
                "Zoom scale: " .. scene.camera.scale, 
            10, 10)
        end
    love.graphics.pop()
end

function MapUI:mousepressed(scene, x, y, button, istouch, presses)
    -- Update button mouse action.
    for index, btn in pairs(self.buttons) do
        btn:mousepressed(scene, x, y, button, istouch, presses)
    end
end

return MapUI