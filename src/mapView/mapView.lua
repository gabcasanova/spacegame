-- Context: Game scene.
-- The isometric map gameplay part of the game.
-----------------------------------------------

-- Import libraries.
local Object = require("libs.classic")

-- Import scripts.
local Terrain = require("src.mapView.terrain")
local MapUI   = require("src.mapView.mapUI")
-----------------------------------------------

local MapView = Object:extend()

function MapView:new()
    -- Set the scene name.
    self.sceneName = "MapView"

    -- Grab mouse.
    love.mouse.setGrabbed(true)

    -- Setup map camera.
    self.camera = {
        x = 0,
        y = 0,
        scale = 0.5,
        maxScale = 1.5,
        minScale = 0.5,
        winWidth = love.graphics.getWidth(),
        winHeight = love.graphics.getHeight(),
        border = 10
    }

    -- Set up map background.
    self.background = _G.gameAsssets.graphics.spaceBackground
    self.backgroundQuad = love.graphics.newQuad(0, 0, self.camera.winWidth, self.camera.winHeight, self.background)
    self.background:setWrap("mirroredrepeat", "mirroredrepeat")

    self.ui = MapUI(self)
    self.terrain = Terrain(self)
end

function MapView:update(dt)
    -- Update the window size.
    self.camera.winWidth  = love.graphics.getWidth()
    self.camera.winHeight = love.graphics.getHeight()

    -- Edge scrolling.
    local edgeBorder = 10
    local edgeAmount = 300
    local mX, mY = love.mouse.getPosition()

    if (love.window.hasFocus() and love.mouse.isGrabbed()) then
        if (mX <= edgeBorder) then -- Horizontal edge scrolling.
            self.camera.x = self.camera.x + edgeAmount * dt
        elseif (mX >= self.camera.winWidth - edgeBorder) then
            self.camera.x = self.camera.x - edgeAmount * dt
        end
            
        if (mY <= edgeBorder) then -- Vertical edge Scrolling
            self.camera.y = self.camera.y + edgeAmount * dt
        elseif (mY >= self.camera.winHeight - edgeBorder) then
            self.camera.y = self.camera.y - edgeAmount * dt
        end 
    end

    -- Update map.
    self.terrain:update(self, dt)
    self.ui:update(self, dt)
end

function MapView:draw()
    -- Render background.
    love.graphics.draw(self.background, self.backgroundQuad, 0, 0)

    -- Render map.
    love.graphics.push("all")
        love.graphics.scale(self.camera.scale, self.camera.scale)
        love.graphics.translate(self.camera.x, self.camera.y)

        self.terrain:draw(self) -- Draw terrain.
    love.graphics.pop()
    
    -- Render UI.
    self.ui:draw(self)
end

function MapView:mousepressed(x, y, button, istouch, presses)
    -- Update UI mouse actions.
    self.ui:mousepressed(self, x, y, button, istouch, presses)
end

function MapView:resize(w, h)
    -- Resize background according to screen size.
    self.backgroundQuad = love.graphics.newQuad(0, 0, w, h, self.background)
    self.background:setWrap("mirroredrepeat", "mirroredrepeat")
end

return MapView