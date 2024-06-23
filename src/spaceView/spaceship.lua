-- Import libraries.
local g3d = require("libs.g3d")
local Object = require('libs.classic')
--------------------------------------
 
local Spaceship = Object:extend()
 
function Spaceship:new(scene)
    self.x, self.y, self.z = 0, 0, 0
    self.direction = 0
    self.pitch = 0
end

function Spaceship:update(scene, dt)
    self.camera.pitchTowards = self.camera.pitchTowards + 1 * dt

    g3d.camera.lookInDirection(self.x, self.y, self.z, self.direction, self.pitch)
end

function Spaceship:draw(scene)
    
end
 
return Spaceship