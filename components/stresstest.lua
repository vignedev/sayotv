local stresstest = {}
local image = lg.newImage('assets/2kTest.png')
local image2 = lg.newImage('assets/2kTest_flip.png')
local image3 = lg.newImage('assets/2kTest_rotate.png')
local amount = 0

function stresstest.render()
    local scale = width/image:getWidth()
    local time = (math.sin(os.clock() * 1) + 1)/2
    local img_width = image:getWidth()*scale
    local img_height = image:getHeight()*scale

    lg.setColor(1,1,1)
    for y = 0, amount, 1 do
        --lg.draw(image, img_width*time + img_width * y, headerHeight, time, scale * time)
        if y % 2 == 0 then
            lg.draw(image, 0, headerHeight+y*img_height - time*(img_height*amount), 0, scale)
        elseif y % 3 == 0 then
            lg.draw(image2, 0, headerHeight+y*img_height - time*(img_height*amount), 0, scale)
        else
            lg.draw(image3, 0, headerHeight+y*img_height - time*(img_height*amount), 0, scale)
        end
    end
end

function love.keypressed(key)
    if key == 'w' then
        amount = amount + 1
    end
    if key == 's' then
        amount = amount - 1
    end

    if key == 'e' then
        if image:getHeight() == 2048 then
            image:release()
            image = lg.newImage('assets/4kTest.png')
        else
            image:release()
            image = lg.newImage('assets/2kTest.png')
        end
    end
end

return stresstest