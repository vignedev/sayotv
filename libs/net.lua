local json = require('./libs/json')
local http = require('socket.http')
local net = {}
local missing = love.image.newImageData('assets/missing_texture.png')

function net.loadImage(url)
    local result = lg.newImage(missing)
    result:setFilter('nearest', 'nearest')
    
    status, error = pcall(function()
        buffer, code, headers, status = http.request(url)
        code = 200
        if code == 200 then
            result = lg.newImage(lf.newFileData(buffer, url:match('([^/]+)$')))
        else
            print('(net.loadImage) HTTP request failed: ['..code..'] '..status..' ('..url..')')
        end
    end)
    if not status then print('(net.loadImage): '..error) end
    return result
end

function net.getJSON(url)
    local result = {}
    status, error = pcall(function()
        buffer, code, headers, status = http.request(url)
        code = 200
        if code == 200 then result = json.decode(buffer) else
            print('(net.getJSON) HTTP request failed: ['..code..'] '..status..' ('..url..')')
        end
    end)
    if not status then print('(net.getJSON): '..error) end
    return result
end

function net.resolveUrl(url)
    print(url, string.sub(url,1,1) == '/')
    if string.sub(url,1,1) == '/' or string.sub(url,1,4) ~= 'http' then
        return server..url
    else
        return url
    end
end

--[[function net.request(url)
    local result = nil
    status, error = pcall(function()
        buffer, code, headers, status = http.request(url)
        code = 200
        if code == 200 then
            result = buffer
        else
            error('HTTP request failed: ['..code..'] '..status..' ('..url..')')
        end
    end)
    return result, status, error
end]]--

return net