lg = love.graphics
lf = love.filesystem

sayo = require('components/sayori')
staticparts = require('components/staticparts')
devinfo = require('components/devinfo')
marquee = require('components/marquee')
slideshow = require('components/slideshow')

monoFont = lg.newFont('assets/FiraCode-Retina.ttf')

function love.load()
	updateDimensions()						--for convinience, use width, height props, which are swapped in proper orientation
	love.graphics.setBackgroundColor(1,1,1)	--set bg color
	marquee.set("All those beautiful Sayori's holding the beverage that is needed to keep me awake durin this trying times is in a resolution of 2048x2048. You can switch it up to 4096x4096 by changing the filename in stresstest.lua.")
	slideshow.loadNewData()
end

--function love.update(dt) marquee.update(2) end
function love.update(dt)
	local time = os.date('*t')
	local morning = time.hour == 7 and time.min == 0 and time.sec >= 0 and time.sec <= 1
	if(morning) then
		love.event.quit('restart')
	end
end

function love.draw()
	updateDimensions()	--for testing purposes, can be removed in production with set resolution
	vertigo()			--rotates canvas rendering style

	slideshow.render()
	staticparts.render()
	marquee.render()
	--devinfo.render(10, 10)
end

function updateDimensions()
	_width = lg:getPixelWidth()
	_height = lg:getPixelHeight()

	if vertigoMode then
		width = _height
		height = _width
	else
		width = _width
		height = _height
	end
end
function vertigo()
	if not vertigoMode then return end
	--lg.translate(_width/2, _height/2)
	--lg.rotate(-math.pi/2)
	--lg.translate(-_height/2, -_width/2)

	lg.translate(_width/2, _height/2)
	lg.rotate(vertigoOrientation*math.pi/2)
	lg.translate(-_height/2, -_width/2)
end