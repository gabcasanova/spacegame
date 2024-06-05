-- Import scripts.
local Terrain = require("src.terrain")
local Button = require("src.button")
--------------------------------------

_G.gameCamera = {
    x = 0,
    y = 0,
    windowWidth = love.graphics.getWidth(),
    windowHeight = love.graphics.getHeight(),
    border = 10
}

_G.gameAsssets = {
    graphics = {
        terrain_image = love.graphics.newImage("assets/terrain.png")
    }
}

_G.gameObjects = {
    Terrain()
}

_G.gameInterface = {
    Button("Zoom", 0, 0, 32, 32)
}

function love.load()

end

function love.update(dt)
    -- Update game objects.
    for i, object in pairs(_G.gameObjects) do
        object:update(dt)
    end

    -- Update interface.
    for i, object in pairs(_G.gameInterface) do
        object:update(dt)
    end
end

function love.draw()
    -- Render game.
    love.graphics.push("all")
        for i, object in pairs(_G.gameObjects) do
            object:draw()
        end
    love.graphics.pop()

    -- Render interface.
    for i, object in pairs(_G.gameInterface) do
        object:draw()
    end
end