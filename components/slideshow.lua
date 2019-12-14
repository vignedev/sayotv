local slideshow = {}
local net = require('../libs/net')

local source = 'http://192.168.1.182:89'
local data = {}     --original data
local slides = {}   --cached slide images
local slideHeight = 0
local currentIndex = 1
local position = 0

local speed = 2
local waitAtEnd = 60 * 3 -- 5 seconds * 60 FPS
local direction = 1
local timer_atEnd = 0

function slideshow.loadNewData()
    data = net.getJSON(source..'/api/info')
    if data.marquee ~= nil then marquee.set(data.marquee) end
    slideshow.loadBullet()
end

function slideshow.loadBullet()
    if data.slides == nil then return end
    if currentIndex > #data.slides then currentIndex = 1 end

    for index,image in pairs(slides) do
        image:release()
        slides[index] = nil
    end

    slideHeight = 0
    position = -1
    timer_atEnd = waitAtEnd
    direction = -1

    for index,url in pairs(data.slides[currentIndex].images) do
        local image = net.loadImage(source..url)
        local scale = width/image:getWidth()
        slideHeight = slideHeight + image:getHeight()*scale
        table.insert(slides, image)
    end

    currentIndex = currentIndex + 1
end

function slideshow.render()
    lg.setColor(1,1,1)
    if slideHeight > height then
        local maxPosition = -(slideHeight-height+footerHeight+headerHeight)
        if timer_atEnd <= 0 then
            position = position + direction*speed
            if position > 0 or position < maxPosition then timer_atEnd = waitAtEnd end
            if position > 0 then direction = -1; position=0 end
            if position < maxPosition then direction = 1; position=maxPosition end
        else timer_atEnd = timer_atEnd - 1 end
    else
        position = (height-headerHeight-footerHeight-slideHeight)/2
    end

    
    local buildup = 0
    for i,image in ipairs(slides) do
        local scale = width/image:getWidth()
        lg.draw(image, 0, headerHeight+buildup+position, 0, scale)
        buildup = buildup + image:getHeight()*scale
    end
end

function love.wheelmoved(x, y)
    position = position + y * 4
end
function love.keypressed(key)
    if key == 'n' then
        slideshow.loadBullet()
    end
    if key == 'm' then
        position = -(slideHeight-height+footerHeight+headerHeight)
    end
end
return slideshow