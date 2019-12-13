vertigoMode = false
scale = 0.5
scrWidth = 1920
scrHeight = 1080

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
    t.window.fullscreen = false-- love._os == "Android" or love._os == "iOS" or love._os == "Linux"
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