local staticparts = {}
local logo = lg.newImage('assets/logo.png')

headerHeight = 96
footerHeight = 64

function staticparts.render()
    lg.setColor(primaryColor)
    lg.rectangle('fill', 0, 0, width, headerHeight)           --top bar
    lg.rectangle('fill', 0, height-footerHeight, width, footerHeight)   --bottom bar
    lg.setColor(1, 1, 1)
    lg.draw(logo, (width-logo:getWidth())/2, (headerHeight-logo:getHeight())/2)
end

return staticparts