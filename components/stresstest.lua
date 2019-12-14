local stresstest = {}

net = require('../libs/net')

local image = net.loadImage('http://localhost:89/images/test_1.png')--lg.newImage('assets/2kTest.png')
local amount = 0

local data = net.getJSON('http://localhost:89/api/info')
print('marquee:', data['marquee'])
print('slides:')
for k,v in ipairs(data['slides']) do
    print(k, v, #v)
end

function stresstest.render()
    local scale = width/image:getWidth()
    local time = (math.sin(os.clock() * 1) + 1)/2
    local img_width = image:getWidth()*scale
    local img_height = image:getHeight()*scale

    lg.setColor(1,1,1)
    for y = 0, amount, 1 do
        lg.draw(image, 0, headerHeight+y*img_height - time*(img_height*amount), 0, scale)
    end
end

function love.keypressed(key)
    if key == 'w' then
        amount = amount + 1
    end
    if key == 's' then
        amount = amount - 1
    end

    --[[if key == 'e' then
        if image:getHeight() == 2048 then
            image:release()
            image = lg.newImage('assets/4kTest.png')
        else
            image:release()
            image = lg.newImage('assets/2kTest.png')
        end
    end]]--
end

return stresstest