-- Import libraries.
local Object = require("libs.classic")

-- Import Scripts.
local Building = require("src.mapView.building")
---------------------------------------

local Terrain = Object:extend()

function Terrain:new()
    self.image = _G.gameAsssets.graphics.terrain
    self.w, self.h = self.image:getDimensions()
    self.x, self.y = 0, 0
    
    self.buildings = {
        Building(800, 300)
    }
end

local function sortBuildings(a, b)
    if (a.y == b.y) then
        return a.x < b.x
    else
        return a.y < b.y
    end
end

function Terrain:update(dt)
    -- Keep the proper perspective. Since objects won't
    -- be able to be on top of each other, there's no need
    -- for a Z axis. There's only X and Y sorting.
    table.sort(self.buildings, sortBuildings)
end

function Terrain:draw()
    love.graphics.draw(self.image, self.x, self.y)

    for i, building in pairs(self.buildings) do
        building:draw()
    end
end

return Terrain