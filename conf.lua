server = 'http://wigymtv.herokuapp.com/'
vertigoMode = false
vertigoOrientation = 1  --1=clockwise, -1=counter-clockwise, 0=please dont
scale = .5
scrWidth = 1920
scrHeight = 1080
primaryColor = { 0.12941176470588235294117647058824, 0.58823529411764705882352941176471, 0.95294117647058823529411764705882 }

-- If it's Linux, assume it's an RPi
if love._os == 'Linux' then
    vertigoMode = true
    scale = 1
end

function love.conf(t)
   	t.window.resizable = true
    t.console = true
    if vertigoMode then
        t.window.width  = scrWidth * scale
        t.window.height = scrHeight * scale
    else
        t.window.height = scrWidth * scale
        t.window.width  = scrHeight * scale
    end
    t.window.fullscreen = love._os == 'Linux'
    t.window.fullscreentype = 'exclusive'
    t.accelerometerjoystick = false
    t.window.vsync = 1

    t.modules.audio = false
    --t.modules.event = false
    t.modules.joystick = false
    t.modules.keyboard = false
    t.modules.mouse = false
    t.modules.physics = false
    t.modules.sound = false
    t.modules.touch = false
    t.modules.video = false
end