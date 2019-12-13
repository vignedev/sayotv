local staticparts = {}
local logo = lg.newImage('assets/logo.png')

headerHeight = 96
footerHeight = 64

function staticparts.render()
    lg.setColor(1, 0.3, 0)
    lg.rectangle('fill', 0, 0, width, headerHeight)           --top bar
    lg.rectangle('fill', 0, height-footerHeight, width, footerHeight)   --bottom bar
    lg.setColor(1, 1, 1)
    lg.draw(logo, (width-logo:getWidth())/2, (96-logo:getHeight())/2)
end

return staticparts