-- Context: Game scene.
-- The 3D spaceship view gameplay part of the game.
---------------------------------------------------

-- Import libraries.
local Object = require("libs.classic")
local g3d = require("libs/g3d")

-- Import scripts.
---------------------------------------------------

local SpaceView = Object:extend()

function SpaceView:new()
    -- Set the scene name.
    self.sceneName = "SpaceView"

    -- Grab mouse.
    love.mouse.setGrabbed(true)

    self.earth = g3d.newModel("assets/models/sphere.obj", "assets/earth.png", {0,0,4})
    self.moon = g3d.newModel("assets/models/sphere.obj", "assets/moon.png", {5,0,4}, nil, {0.5,0.5,0.5})
    self.background = g3d.newModel("assets/models/sphere.obj", "assets/starfield.png", {0,0,0}, nil, {500,500,500})
    self.timer = 0
end

function SpaceView:update(dt)
    self.timer = self.timer + dt
    self.moon:setTranslation(math.cos(self.timer)*5, 0, math.sin(self.timer)*5 +4)
    self.moon:setRotation(0, math.pi - self.timer, 0)
    g3d.camera.firstPersonMovement(dt)
end

function SpaceView:draw()
    self.earth:draw()
    self.moon:draw()
    self.background:draw()
end

function SpaceView:mousepressed(x, y, button, istouch, presses)
    
end

function SpaceView:resize(w, h)
    
end

function SpaceView:mousemoved(x, y, dx, dy)
    g3d.camera.firstPersonLook(dx,dy)
end

return SpaceView