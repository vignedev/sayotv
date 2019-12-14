local slideshow = {}
local net = require('../libs/net')

local source = 'http://192.168.1.182:89'
local data = {}     --original data
local slides = {}   --cached slide images
local slideHeight = 0
local currentIndex = 1
local position = 0

function slideshow.loadNewData()
    data = net.getJSON(source..'/api/info')
    if data.marquee ~= nil then marquee.set(data.marquee) end
    slideshow.loadBullet()
    --[[for key,value in pairs(data) do
        if key == 'marquee' then marquee.set(value) end
        if key == 'slides' then
            for index,slide in ipairs(value) do
                
            end
        end
    end]]--
end

function slideshow.loadBullet()
    if data.slides == nil then return end
    if currentIndex > #data.slides then currentIndex = 1 end

    for index,image in pairs(slides) do image:release() end
    slideHeight = 0
    slides = {}

    for index,image in pairs(data.slides[currentIndex].images) do
        local image = net.loadImage(source..image)
        local scale = width/image:getWidth()
        slideHeight = slideHeight + image:getHeight()*scale
        table.insert(slides, image)
    end

    currentIndex = currentIndex + 1
end

function slideshow.render()
    lg.setColor(1,1,1)
    local buildup = 0
    for i,image in ipairs(slides) do
        local scale = width/image:getWidth()
        lg.draw(image, 0, headerHeight+buildup+position, 0, scale)
        buildup = buildup + image:getHeight()*scale
    end
end

function love.wheelmoved(x, y)
    position = position + y * 10
end

return slideshow