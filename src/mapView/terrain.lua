-- Import libraries.
local Object = require("libs.classic")

-- Import Scripts.
local Building = require("src.mapView.building")
---------------------------------------

local Terrain = Object:extend()

function Terrain:new()
    screenW, screenH = love.graphics.getDimensions()

    -- Map look and feel.
    self.mapImage = _G.gameAsssets.graphics.terrain
    self.w, self.h = self.mapImage:getDimensions()
    self.x, self.y = 0, 0
    
    self.buildings = {}

    -- Create map grid.
    --[[self.buildingsGrid = {
        {1,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
        {0,0,0,0,0,0,0,0,0,0,0,0},
    }]]
    self.gridRows = 38/2
    self.gridColumns = 38/2
    for i = 1, self.gridRows, 1 do
        local buildings = {}
        for j = 1, self.gridColumns, 1 do
            table.insert(buildings, j, 1)
        end
        table.insert(self.buildingsGrid, i, buildings)
    end

    -- Grid tile size and offset.
    self.gridSize = 87
    self.buildingOffsetX = 2.4
    self.buildingOffsetY = 4

    self.mapOffsetX = self.x              -- Offset so that the buildings are created in the top-left  
    self.mapOffsetY = self.y+self.h/2-65  -- of the map. Currently, these are magic numbers. I have   
                                          -- to find a way to have a more logical approach to this.  

    -- Iterate through each row in the grid and go through
    -- each value inside the row, then, create the building 
    -- in the correct isometric position.
    for i, row in ipairs(self.buildingsGrid) do
        for j, building in ipairs(row) do
            if building == 1 then
                local cartX = (i - 1) * self.gridSize
                local cartY = (j - 1) * self.gridSize

                -- Convert cartesian coordinates to isometric coordinates
                local isoX = (cartX + cartY) / self.buildingOffsetX
                local isoY = (cartX - cartY) / self.buildingOffsetY

                -- Create buildings in the desired position.
                local desiredXPos = math.floor(isoX + self.mapOffsetX) -- Round position numbers.
                local desiredYPos = math.floor(isoY + self.mapOffsetY)
                table.insert(self.buildings, Building(desiredXPos, desiredYPos, 1, 1))
            end
        end
    end

    self.buildingsGrid[1][1] = 0

end

local function sortBuildings(a, b)
    if (a.y == b.y) then
        return a.x < b.x
    else
        return a.y < b.y
    end
end

function Terrain:update(dt)
    -- Keep the proper isometric perspective. Since objects 
    -- won't be able to be on top of each other, there's no
    -- need for a Z axis. There's only X and Y sorting.
    table.sort(self.buildings, sortBuildings)

    -- Update map buildings.
    for i, building in pairs(self.buildings) do
        building:update(dt)
    end
end

function Terrain:draw()
    -- Draw terrain.
    love.graphics.draw(self.mapImage, self.x, self.y)

    -- Draw map buildings.
    for i, building in pairs(self.buildings) do
        building:draw()
    end
end

return Terrain