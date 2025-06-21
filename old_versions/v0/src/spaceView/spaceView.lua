-- Context: Game scene.
-- The 3D spaceship view gameplay part of the game.
---------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")
local g3d = require("libs.g3d")

-- Import scripts.
local Spaceship = require("src.spaceView.spaceship")
----------------------------------------------------

local SpaceView = Object:extend()

function SpaceView:new()
    -- Set the scene name.
    self.sceneName = "SpaceView"

    -- Grab mouse.
    love.mouse.setGrabbed(false)

    self.earth = g3d.newModel("assets/models/sphere.obj", "assets/graphics/textures/earth.png", {4,0,0})
    self.moon = g3d.newModel("assets/models/sphere.obj", "assets/graphics/textures/moon.png", {5,0,4}, nil, {0.5,0.5,0.5})
    self.background = g3d.newModel("assets/models/sphere.obj", "assets/graphics/textures/starfield.png", {0,0,0}, nil, {500,500,500})
    self.timer = 0

    self.spaceship = Spaceship(self)
end

function SpaceView:update(dt)
    self.spaceship:update(self, dt)

    self.timer = self.timer + dt
    self.moon:setTranslation(math.cos(self.timer)*5 + 4, math.sin(self.timer)*5, 0)
    self.moon:setRotation(0, 0, self.timer - math.pi/2)
end

function SpaceView:draw()
    self.earth:draw()
    self.moon:draw()
    self.background:draw()

    self.spaceship:draw(self)
end

function SpaceView:mousepressed(x, y, button, istouch, presses)
    --
end

function SpaceView:keypressed(key, scancode, isrepeat)
    --
end

function SpaceView:resize(w, h)
    --
end

function SpaceView:mousemoved(x, y, dx, dy)
    --
end

return SpaceView