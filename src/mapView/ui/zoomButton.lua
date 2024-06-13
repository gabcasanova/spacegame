-- Import scripts.
local ImageButton = require("src.ui.imageButton")
-------------------------------------------------

local ZoomButton = ImageButton:extend()

function ZoomButton:new(scene, x, y, type)
    ZoomButton.super.new(self, scene, x, y, _G.gameAsssets.graphics.zoomButton, 2, 1)
    self.zoomType = type
end

function ZoomButton:customUpdate(scene, dt)
    
end

function ZoomButton:leftAction(scene)
    if (self.zoomType == 1 and scene.camera.scale < scene.camera.maxScale) then -- Zoom In.
        scene.camera.scale = scene.camera.scale + scene.camera.scaleAmount
    elseif (self.zoomType == 2 and scene.camera.scale > scene.camera.minScale) then
        scene.camera.scale = scene.camera.scale - scene.camera.scaleAmount
    end
end

return ZoomButton