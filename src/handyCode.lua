local handyCode = {}

-- Collision detection function:
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function handyCode.aabb(x1,y1,w1,h1, x2,y2,w2,h2)
    return x1 < x2+w2 and
           x2 < x1+w1 and
           y1 < y2+h2 and
           y2 < y1+h1
    -- source: https://www.love2d.org/wiki/BoundingBox.lua
end

-- Translate mouse coordinates to camera coordinates.
-- Keeps scaling and translation in mind.
function handyCode.mousePosToCamPos(mouseX, mouseY, camX, camY, camScale)
    translatedX = (mouseX / camScale) - camX
    translatedY = (mouseY / camScale) - camY
    return translatedX, translatedY
end

return handyCode