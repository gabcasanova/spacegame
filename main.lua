-- Import scripts.
local MapView = require("src.mapView.mapView")
----------------------------------------------

function love.load()
    -- Set game variables.
    love.graphics.setDefaultFilter("linear", "linear")
    _G.debug = true
    love.mouse.setGrabbed(true)

    -- Load game assets.
    _G.gameAsssets = {
        fonts = {
            genericFont = love.graphics.newFont(15)
        },
        graphics = {
            terrain = love.graphics.newImage("assets/terrain.png"),
            isoCube = love.graphics.newImage("assets/isoCube.png")
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

function love.keypressed(key, scancode, isrepeat)
    -- Quit game.
    if (key == "escape") then
        love.event.quit()
    end
end