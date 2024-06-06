-- Import scripts.
local Terrain = require("src.terrain")

local MapUI = require("src.ui.mapUI")
--------------------------------------

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
    
    -- Setup map camera.
    _G.mapCamera = {
        x = 0,
        y = 0,
        scale = 1,
        winWidth = love.graphics.getWidth(),
        winHeight = love.graphics.getHeight(),
        border = 10
    }
    
    _G.gameObjects = {
        Terrain()
    }
    
    _G.mapUI = MapUI()
end

function love.update(dt)
    -- Update the window size.
    _G.mapCamera.winWidth = love.graphics.getWidth()
    _G.mapCamera.winHeight = love.graphics.getHeight()

    -- Update game objects.
    for i, object in pairs(_G.gameObjects) do
        object:update(dt)
    end

    -- Update UI.
    _G.mapUI:update(dt)
end

function love.draw()
    -- Render map.
    love.graphics.push("all")
        love.graphics.scale(_G.mapCamera.scale, _G.mapCamera.scale)

        for i, object in pairs(_G.gameObjects) do
            object:draw()
        end
    love.graphics.pop()

    -- Render UI.
    _G.mapUI:draw()
end

function love.mousepressed(x, y, button, istouch, presses)
    -- Update UI mouse actions.
    _G.mapUI:mousepressed(x, y, button, istouch, presses)
end