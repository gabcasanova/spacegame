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
    
    self.buildings = {}

    -- Create map grid.
    self.mapGrid = {
        {1,0,1,0,1,0,1,1,1,0,1,1,1,0,1,1,1},
        {1,0,1,0,1,0,0,1,0,0,1,0,1,0,1,0,1},
        {1,0,1,0,1,0,0,1,0,0,1,0,1,0,1,1,0},
        {0,1,0,0,1,0,0,1,0,0,1,1,1,0,1,0,1},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {1,0,0,0,1,0,0,1,0,0,1,0,0,0,1,0,0,1},
        {1,1,0,1,1,0,1,0,1,0,1,0,0,0,1,0,0,1},
        {1,0,1,0,1,0,1,1,1,0,1,0,0,0,1,0,0,1},
        {1,0,0,0,1,0,1,0,1,0,1,1,1,0,0,1,1,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
    }

    -- Grid tile size.
    self.offsetX = 2.4
    self.offsetY = 4
    self.gridSize = 87

    -- Iterate through the grid and create the necessary
    -- buildings in the isometric position.
    for i, v in ipairs(self.mapGrid) do
        for j, building in ipairs(v) do
            if building ~= 0 then
                local cartX = (j - 1) * self.gridSize
                local cartY = (i - 1) * self.gridSize

                -- Convert Cartesian coordinates to isometric coordinates
                local isoX = (cartX - cartY) / self.offsetX
                local isoY = (cartX + cartY) / self.offsetY  -- Adjust to fit the isometric perspective

                -- Create buildings in the desired position.
                table.insert(self.buildings, Building(isoX, isoY))
            end
        end
    end

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