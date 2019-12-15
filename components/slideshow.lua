local slideshow = {}
local net = require('../libs/net')

local data = {}     --original data
local slides = {}   --cached slide images
local slideHeight = 0
local currentIndex = 1
local position = 0
local currentTurns = 0
local direction = 1

slideshow.speed = 8
slideshow.numberOfTurns = 4
slideshow.defaultTimeout = 60 * 10
slideshow.delayAtEnd = 60 * 3 -- 3 seconds * 60 FPS

local timer_atEnd = 0
local timer_timeout = 0

function slideshow.loadNewData()
    print('Loading new data...')
    data = net.getJSON(server..'/api/info')
    print('Loaded data.')
    if data.marquee ~= nil then marquee.set(data.marquee) end
    slideshow.loadBullet()
end
function slideshow.loadBullet()
    if data.slides == nil then return end
    if #data.slides == 0 then return end
    if currentIndex > #data.slides then
        currentIndex = 1
        slideshow.loadNewData()
    end

    for index,image in pairs(slides) do
        image:release()
        slides[index] = nil
    end

    slideHeight = 0
    position = -1
    timer_atEnd = slideshow.delayAtEnd
    timer_timeout = slideshow.defaultTimeout
    direction = -1
    currentTurns = 0

    for index,url in pairs(data.slides[currentIndex].images) do
        local image = net.loadImage(server..url)
        local scale = width/image:getWidth()
        slideHeight = slideHeight + image:getHeight()*scale
        table.insert(slides, image)
    end

    currentIndex = currentIndex + 1
end
function slideshow.render()
    lg.setColor(1,1,1)
    if #slides == 0 then slideshow.loadBullet() end

    if slideHeight > height then
        local maxPosition = -(slideHeight-height+footerHeight+headerHeight)
        if timer_atEnd <= 0 then
            if currentTurns == slideshow.numberOfTurns then slideshow.loadBullet() end
            position = position + direction*slideshow.speed
            if position > 0 or position < maxPosition then
                timer_atEnd = slideshow.delayAtEnd
                currentTurns = currentTurns + 1
            end
            if position > 0 then direction = -1; position=0 end
            if position < maxPosition then direction = 1; position=maxPosition end
        else timer_atEnd = timer_atEnd - 1 end
    else
        position = (height-headerHeight-footerHeight-slideHeight)/2
        if timer_timeout <= 0 then slideshow.loadBullet()
        else timer_timeout = timer_timeout - 1 end
    end

    local buildup = 0
    for i,image in ipairs(slides) do
        local scale = width/image:getWidth()
        lg.draw(image, 0, headerHeight+buildup+position, 0, scale)
        buildup = buildup + image:getHeight()*scale
    end
end

--debug functions
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