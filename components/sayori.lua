local sayo = {}

-- Typestting
local fontSize = 18
f_hashtag = love.graphics.newFont("assets/Hashtag.ttf", fontSize + fontSize/2)
f_hashtag:setLineHeight(.5)
function sayo.print ( text, x, y, r, sx, sy, ox, oy, kx, ky )
	love.graphics.setFont(f_hashtag)
	love.graphics.print(text, x, y - fontSize/2, r, sx, sy, ox, oy, kx, ky)
end

function sayo.printf ( text, x, y, limit, align, r, sx, sy, ox, oy, kx, ky )
	love.graphics.setFont(f_hashtag)
	love.graphics.printf( text, x, y - fontSize/2, limit, align, r, sx, sy, ox, oy, kx, ky )
end

return sayo