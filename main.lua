-- Import scripts.
local Terrain = require("src.terrain")

local MapUI = require("src.ui.mapUI")
--------------------------------------

function love.load()
    _G.gameAsssets = {
        fonts = {
            genericFont = love.graphics.newFont(15)
        },
        graphics = {
            terrain_image = love.graphics.newImage("assets/terrain.png")
        }
    }
    
    _G.gameCamera = {
        x = 0,
        y = 0,
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
    _G.gameCamera.winWidth = love.graphics.getWidth()
    _G.gameCamera.winHeight = love.graphics.getHeight()

    -- Update game objects.
    for i, object in pairs(_G.gameObjects) do
        object:update(dt)
    end

    -- Update UI.
    _G.mapUI:update(dt)
end

function love.draw()
    -- Render game.
    love.graphics.push("all")
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