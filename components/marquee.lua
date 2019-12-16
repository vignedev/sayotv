local marquee = {}
local desiredFont = lg.newFont('assets/OpenSans-Regular.ttf', 24)

marquee.text = ""
marquee.length = 0
marquee.height = desiredFont:getHeight()
function marquee.set(text)
    marquee.text = text
    marquee.length = desiredFont:getWidth(text)
end

marquee.x = 0
function marquee.update(speed)
    marquee.x = marquee.x - speed
    if marquee.x < -marquee.length then
        marquee.x = width
    end
end
function marquee.render()
    marquee.update(2)
    lg.setFont(desiredFont)
    lg.setColor(1,1,1)
    lg.print(marquee.text, marquee.x, (height - 64 + (64-marquee.height)/2) )
end

return marquee