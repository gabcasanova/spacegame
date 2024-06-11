-- Import libraries.
local Object = require("libs.classic")

-- Import Scripts.
local handyCode = require("src.handyCode")
local Tile = require("src.mapView.tile")
---------------------------------------

local Terrain = Object:extend()

function Terrain:new(scene) -- Parse game scene.
    -- Get current screen size.
    local screenW, screenH = love.graphics.getDimensions()

    -- Map look and feel.
    self.mapImage = _G.gameAsssets.graphics.terrain
    self.w, self.h = self.mapImage:getDimensions()
    self.x, self.y = 0, 0
    
    -- MAP IMPORTING / GENERATION --------------------------------------------
    -- Create map grid.
    self.buildingsGrid = {}
    --[[ self.buildingsGrid = {
        {1,1,0,0,0,0,0,0,0,0,0,0},
        {1,1,0,0,0,0,0,0,0,0,0,0},
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
    } ]]
    self.gridRows = 38
    self.gridColumns = 38
    for i = 1, self.gridRows, 1 do
        local buildings = {}
        for j = 1, self.gridColumns, 1 do
            table.insert(buildings, j, 0)
        end
        table.insert(self.buildingsGrid, i, buildings)
    end

    self.buildingsGrid[3][3] = 1 -- *TEMPORARY*
    self.buildingsGrid[10][10] = 2 -- *TEMPORARY*

    -- Grid tile size and offset.
    self.gridSize = 87
    self.tileOffsetX = 2.4
    self.tileOffsetY = 4
    self.mapOffsetX = self.x              -- Offset so that the buildings are created in the top-left  
    self.mapOffsetY = self.y+self.h/2-65  -- of the map. Currently, these are magic numbers. I have   
                                          -- to find a way to have a more logical approach to this.  

    self.buildings = {}                   -- Table where the actual tile classes are stored.

    -- Iterate through each row in the grid and go through
    -- each value inside the row, then, create the tile in
    -- the correct isometric position.
    for i, row in ipairs(self.buildingsGrid) do
        for j, building in ipairs(row) do
            local desiredXPos, desiredYPos = handyCode.gridTileToIsometricTile(i, j, self.gridSize, self.tileOffsetX, self.tileOffsetY, self.mapOffsetX, self.mapOffsetY)
            
            if (building == 0) then
                table.insert(self.buildings, Tile(scene, self, desiredXPos, desiredYPos, false, 1, 1))
            elseif (building == 1) then
                table.insert(self.buildings, Tile(scene, self, desiredXPos, desiredYPos, false, 1, 1, _G.gameAsssets.graphics.isoCube, 3, 2))
            elseif (building == 2) then
                table.insert(self.buildings, Tile(scene, self, desiredXPos, desiredYPos, true, 2, 3, _G.gameAsssets.graphics.militaryDeposit, 1, 1))
            end
        end
    end
    --------------------------------------------------------------------------
end

local function sortBuildings(a, b)
    if (a.y == b.y) then
        return a.x < b.x
    else
        return a.y < b.y
    end
end

function Terrain:update(scene, dt)
    -- Keep the proper isometric perspective. Since objects 
    -- won't be able to be on top of each other, there's no
    -- need for a Z axis. There's only X and Y sorting.
    table.sort(self.buildings, sortBuildings)

    -- Update map buildings.
    for i, building in pairs(self.buildings) do
        building:update(scene, dt)
    end
end

function Terrain:draw(scene)
    -- Draw terrain.
    love.graphics.draw(self.mapImage, self.x, self.y)

    -- Draw map buildings.
    for i, building in pairs(self.buildings) do
        building:draw(scene)
    end
end

return Terrain