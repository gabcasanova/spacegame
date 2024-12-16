-- Import libraries.
local Object = require('libs.classic')
local g3d = require("libs.g3d")
local flux = require("libs.flux")
--------------------------------------
 
local Spaceship = Object:extend()
 
function Spaceship:new(scene)
    self.x, self.y, self.z = 0, 0, 0
    self.direction = 0
    self.pitch = 0

    self.maxSpeed = 1
    self.moveSpeed = 0
    self.strafeSpeed = 0
    self.dirSpeed = 0
    self.pitchSpeed = 0
end

function Spaceship:update(scene, dt)
    flux.update(dt)

    local isDown = love.keyboard.isDown
    local bind = _G.gameKeybind.ship

    local maxPitch = 1.55
    if (self.pitch > maxPitch or self.pitch < -maxPitch) then
        flux.to(self, 1, {pitch = -self.pitch+1, direction = -self.direction})
    end

    -- Keyboard controls.
    self.moveSpeed = 0
    if (isDown(bind.moveForward)) then
        self.moveSpeed = self.maxSpeed
    elseif (isDown(bind.moveBackward)) then
        self.moveSpeed = -self.maxSpeed
    end

    self.strafeSpeed = 0
    if (isDown(bind.moveLeft)) then
        self.strafeSpeed = -self.maxSpeed
    elseif (isDown(bind.moveRight)) then
        self.strafeSpeed = self.maxSpeed
    end

    self.dirSpeed = 0
    if (isDown(bind.turnLeft)) then
        self.dirSpeed = self.maxSpeed
    elseif (isDown(bind.turnRight)) then
        self.dirSpeed = -self.maxSpeed
    end

    self.pitchSpeed = 0
    if (isDown(bind.turnUp)) then
        self.pitchSpeed = self.maxSpeed
        print(self.pitch)
    elseif (isDown(bind.turnDown)) then
        self.pitchSpeed = -self.maxSpeed
    end

    -- Move ship based on direction and pitch.
    local perpDirectionX = math.cos(self.direction - math.pi/2)  -- perpendicular direction X
    local perpDirectionY = math.sin(self.direction - math.pi/2)  -- perpendicular direction Y

    -- Update position considering both direction and pitch
    self.x = self.x + (self.moveSpeed * math.cos(self.direction) + self.strafeSpeed * perpDirectionX) * dt
    self.y = self.y + (self.moveSpeed * math.sin(self.direction) + self.strafeSpeed * perpDirectionY) * dt
    self.z = self.z + (self.moveSpeed * math.sin(self.pitch)) * dt

    -- Update direction and pitch (if needed)
    self.direction = self.direction + self.dirSpeed * dt
    self.pitch = self.pitch + self.pitchSpeed * dt

    -- Move camera.
    g3d.camera.lookInDirection(self.x, self.y, self.z, self.direction, self.pitch)
end

function Spaceship:draw(scene)
    -- Debug.
    if (_G.debug) then
        love.graphics.print(
            "CAMERA INFO: \n" ..
            "X: " .. self.x .. "\n" ..
            "Y: " .. self.y .. "\n" ..
            "Z: " .. self.z .. "\n" ..
            "Direction: " .. self.direction .. "\n" ..
            "Pitch: " .. self.pitch .. "\n"

        , 10, 10)
    end
end
 
return Spaceship