local devinfo = {}
local initTime = os.date('%c')
local classicFont = lg.getFont()

function devinfo.render(x,y)
	lg.setFont(classicFont)
	local o = "INIT: " .. initTime
	o=o.."\nFPS:  " .. love.timer.getFPS()
	lg.setColor(0, 0, 0)
	lg.print(o,x,y)
end

return devinfo