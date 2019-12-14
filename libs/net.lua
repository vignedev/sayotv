local json = require('./libs/json')
local http = require('socket.http')
local net = {}
local missing = lg.newImage('assets/missing_texture.png')
missing:setFilter('nearest', 'nearest')

function net.loadImage(url)
    local result = missing
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