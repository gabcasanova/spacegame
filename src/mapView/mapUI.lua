-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local handyCode = require("src.handyCode")
local Button = require ("src.ui.button")
local Building = require("src.mapView.building")
----------------------------------------

local MapUI = Button:extend()

function MapUI:new()
    local MapView = _G.currentScene

    -- Create buttons.
    self.buttons = {
        zoomIn = Button("Zoom In", 0, 0),
        zoomOut = Button("Zoom Out", 0, 0),
        building = Button("Create building", 0, 0)
    }

    -- Define button actions. --------------------------------
    -- Zoom in button.
    function self.buttons.zoomIn:customUpdate(dt)
        local MapView = _G.currentScene
        self.x = MapView.camera.winWidth - self.w - self.border
        self.y = self.border
    end
    function self.buttons.zoomIn:leftAction()
        local MapView = _G.currentScene
        MapView.camera.scale = MapView.camera.scale + 0.5
    end

    -- Zoom out button.
    function self.buttons.zoomOut:customUpdate(dt)
        local MapView = _G.currentScene
        self.x = MapView.camera.winWidth - self.w - self.border
        self.y = 50
    end
    function self.buttons.zoomOut:leftAction()
        local MapView = _G.currentScene
        MapView.camera.scale = MapView.camera.scale - 0.5
    end

    -- Create building button.
    function self.buttons.building:customUpdate(dt)
        local MapView = _G.currentScene
        self.x = MapView.camera.winWidth - self.w - self.border
        self.y = 100
    end
    function self.buttons.building:leftAction()
        --
    end
end

function MapUI:update(dt)
    -- Update buttons.
    for index, btn in pairs(self.buttons) do
        btn:update(dt)
    end
end

function MapUI:draw()
    -- Draw buttons.
    for index, btn in pairs(self.buttons) do
        btn:draw()
    end

    -- Draw debug information.
    local MapView = _G.currentScene
    local mX, mY = love.mouse.getPosition()
    if (_G.debug) then
        love.graphics.print(
            "DEBUG INFORMATION: \n\n" ..
            "Mouse X: " .. mX .. "\n" ..
            "Mouse Y: " .. mY .. "\n" ..
            "Zoom scale: " .. MapView.camera.scale, 
        10, 10)
    end

    love.graphics.rectangle("line", mX, mY, 79, 87)
end

function MapUI:mousepressed(x, y, button, istouch, presses)
    -- Update button mouse action.
    for index, btn in pairs(self.buttons) do
        btn:mousepressed(x, y, button, istouch, presses)
    end

    camX, camY = handyCode.mousePosToCamPos(x, y, _G.currentScene.camera.x, _G.currentScene.camera.y, _G.currentScene.camera.scale)

    local mousex, mousey = x, y
    table.insert(_G.currentScene.terrain.buildings, Building(
        camX, 
        camY
    ))
end

return MapUI