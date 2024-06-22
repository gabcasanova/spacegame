-- Import scripts.
local SceneSelector = require("src.sceneSelector")
--------------------------------------------------

function love.load()
    -- Set game variables.
    love.graphics.setDefaultFilter("linear", "linear")
    _G.debug = false
    love.mouse.setGrabbed(false)

    -- Load game assets.
    _G.gameAsssets = {
        fonts = {
            genericFont = love.graphics.newFont(15),
            chicago = love.graphics.newFont("assets/fonts/ChicagoFLF.ttf", 16),
            bigChicago = love.graphics.newFont("assets/fonts/ChicagoFLF.ttf", 36),
        },
        graphics = {
            -- UI.
            debugBackground = love.graphics.newImage("assets/graphics/ui/debugBackground.png"),
            zoomButtons = love.graphics.newImage("assets/graphics/ui/zoomButtons.png"),
            tyrannyDiplomacy = love.graphics.newImage("assets/graphics/ui/tyrannyDiplomacy.png"),

            -- Planets.
            spaceBackground = love.graphics.newImage("assets/graphics/skies/dirtPlanetSky.png"),
            terrain = love.graphics.newImage("assets/graphics/terrains/dirtPlanetTerrain.png"),

            -- Buildings.
            isoCube = love.graphics.newImage("assets/graphics/buildings/isoCube.png"),
            tile    = love.graphics.newImage("assets/graphics/buildings/tile.png"),
            militaryDeposit = love.graphics.newImage("assets/graphics/buildings/militaryDeposit.png")
        }
    }

    -- Set the current scene.
    _G.currentScene = SceneSelector()
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
    -- Update current scene mouse actions.
    _G.currentScene:mousepressed(x, y, button, istouch, presses)
end

function love.keypressed(key, scancode, isrepeat)
    -- Global keys.
    if (key == "escape") then
        -- Quit game.
        love.event.quit()
    elseif (key == "q") then
        -- Deactivate debug.
        if (_G.debug) then _G.debug = false else _G.debug = true end
    elseif (key == "home") then
        -- Restart scene.
        _G.currentScene = SceneSelector()
        collectgarbage("collect")
    end

    -- Update scene keypress.
    _G.currentScene:keypressed(key, scancode, isrepeat)
end

function love.resize(w, h)
    -- Resize current scene.
    _G.currentScene:resize(w, h)
end

function love.mousemoved(x, y, dx, dy)
    -- Update mouse movement.
    _G.currentScene:mousemoved(x, y, dx, dy)
end