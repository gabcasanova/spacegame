-- Context: Game scene.
-- The isometric map gameplay part of the game.
-----------------------------------------------

-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local Terrain = require("src.mapView.terrain")
local MapUI   = require("src.mapView.mapUI")
-----------------------------------------------

local MapView = Object:extend()

function MapView:new()
    -- Set the scene name.
    self.sceneName = "MapView"

    -- Setup map camera.
    self.camera = {
        x = 0,
        y = 0,
        scale = 1,
        winWidth = love.graphics.getWidth(),
        winHeight = love.graphics.getHeight(),
        border = 10
    }

    self.terrain = Terrain()
    self.ui = MapUI()
end

function MapView:update(dt)
    self.terrain:update(dt)
    self.ui:update(dt)
end

function MapView:draw()
    -- Update the window size.
    self.camera.winWidth  = love.graphics.getWidth()
    self.camera.winHeight = love.graphics.getHeight()

    -- Render map.
    love.graphics.push("all")
        love.graphics.scale(self.camera.scale, self.camera.scale)
        love.graphics.translate(self.camera.x, self.camera.y)

        self.terrain:draw() -- Draw terrain.
    love.graphics.pop()
    
    -- Render UI.
    self.ui:draw()
end

function MapView:mousepressed(x, y, button, istouch, presses)
    -- Update UI mouse actions.
    self.ui:mousepressed(x, y, button, istouch, presses)
end

return MapView