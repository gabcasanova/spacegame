-- Import scripts.
local Tile = require("src.mapView.tile")
----------------------------------------

local function createTiles(scene, terrain, id, buildingsTable, row, column, x, y) 
    -- Generic grid tile.
    if (id == 0) then
        table.insert(buildingsTable, Tile(scene, terrain, row, column, x, y, 1, 1))

    -- Isometric cube.
    elseif (id == 1) then
        table.insert(buildingsTable, Tile(scene, terrain, row, column, x, y, 1, 1, _G.gameAsssets.graphics.isoCube, 3, 2))

    -- Military deposit unit.
    elseif (id == 2) then
        table.insert(buildingsTable, Tile(scene, terrain, row, column, x, y, 2, 3, _G.gameAsssets.graphics.militaryDeposit, 1, 1))
    end
end

return createTiles