-- Import scripts.
local ImageButton = require("src.ui.imageButton")
-------------------------------------------------

local ZoomButtons = ImageButton:extend()

function ZoomButtons:new(scene, ui, x, y, type)
    ZoomButtons.super.new(self, scene, x, y, _G.gameAsssets.graphics.zoomButtons, 3, type)
    self.ui = ui
    self.zoomType = type
    self.buttonBorder = 6;
end

function ZoomButtons:customUpdate(scene, dt)
    -- Button positions.
    if (self.zoomType == 1) then
        self.x = self.buttonBorder*1 + self.ui.interfaceBackground.x -- Zoom in.
    elseif (self.zoomType == 2) then
        self.x = self.buttonBorder*2 + self.ui.interfaceBackground.x + self.w -- Zoom out.
    elseif (self.zoomType == 3) then
        self.x = self.buttonBorder*3 + self.ui.interfaceBackground.x + self.w*2 -- Move.
    end
        
end

function ZoomButtons:leftAction(scene)
    -- Button actions.
    if (self.zoomType == 1 and scene.camera.scale < scene.camera.maxScale) then -- Zoom In.
        scene.camera.scale = scene.camera.scale + scene.camera.scaleAmount
    elseif (self.zoomType == 2 and scene.camera.scale > scene.camera.minScale) then -- Zoom out.
        scene.camera.scale = scene.camera.scale - scene.camera.scaleAmount
    end
end

return ZoomButtons