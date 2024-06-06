-- Import scripts.
local MapView = require("src.mapView.mapView")
----------------------------------------------

function love.load()
    -- Disable engine filtering.
    love.graphics.setDefaultFilter("nearest", "nearest")

    -- Load game assets.
    _G.gameAsssets = {
        fonts = {
            genericFont = love.graphics.newFont(15)
        },
        graphics = {
            terrain_image = love.graphics.newImage("assets/terrain.png")
        }
    }

    -- Set the current scene.
    _G.currentScene = MapView()
end

function love.update(dt)
    -- Update the current scene.
    _G.currentScene:update(dt)
end

function love.draw()
    -- Draw the current scene.
    _G.currentScene:draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    -- Update current mouse actions.
    _G.currentScene:mousepressed(x, y, button, istouch, presses)
end