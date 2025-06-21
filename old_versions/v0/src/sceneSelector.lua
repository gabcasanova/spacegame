-- Context: Game scene.
-- Scene selector for debug purposes.
---------------------------------------

-- Import libraries.
local Object = require("libs.classic")
local flux = require("libs.flux")

-- Import scripts.
local Button = require("src.ui.button")
---------------------------------------

local SceneSelector = Object:extend()

function SceneSelector:new()
    -- Set the scene name.
    self.sceneName = "SceneSelector"
    love.mouse.setGrabbed(false)

    -- Load scenes.
    self.sceneList = {
        {name = "MapView",   scene = require("src.mapView.mapView")},
        {name = "SpaceView", scene = require("src.spaceView.spaceView")},
    }

    self.sceneString = "" -- Create scene list string.
    for i, v in ipairs(self.sceneList) do
        self.sceneString = self.sceneString .. "\n" .. i .. " - " .. v.name
    end
end

function SceneSelector:update(dt)
    flux.update(dt)
end

function SceneSelector:draw()
    local winW, winH = love.graphics.getDimensions()

    love.graphics.push("all")
        -- Draw background.
        love.graphics.setColor(0,0,132/255)
        love.graphics.rectangle("fill", 0, 0, winW, winH)

        -- Draw text.
        love.graphics.setColor(1,1,1)
        love.graphics.setFont(_G.gameAsssets.fonts.chicago)
        love.graphics.printf(
            "WELCOME TO STARFOLD v.ALPHA \n" ..
            "(c) 2024 Gabriel Casanova.\n\n\n" ..
            "----------------- Dev Menu -----------------\n\n\n"..
            "Scene List:\n" .. self.sceneString .. "\n"
        , 10, 10, winW, "center")
    love.graphics.pop()
end

function SceneSelector:mousepressed(x, y, button, istouch, presses)
    --
end

function SceneSelector:keypressed(key, scancode, isrepeat)
    -- Change scene.
    for i, scene in ipairs(self.sceneList) do
        if (i == tonumber(key)) then
            _G.currentScene = self.sceneList[i].scene()
        end
    end
end

function SceneSelector:resize(w, h)
    --
end

function SceneSelector:mousemoved(x, y, dx, dy)
    --
end

return SceneSelector