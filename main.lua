--"C:\Program Files\LOVE\love.exe" "D:Harvard\Game2"

_G. love = require("love")

function love.load()
    _G.jack = {
        x = 0,
        y = 0,
        sprite = love.graphics.newImage("sprites/running.png"),
        animation = {
            direction = "right",
            idle = true,
            frame = 1,
            max_frames = 8,
            speed = 20,
            timer = 0.1
        }
    }

    --5352x569 dimensiones reales del png, visibles en propiedades
    SPRITE_WIDTH, SPRITE_HEIGHT = 5352, 569
    QUAD_WIDTH = 669 --sprite_wid0ht/number of images in the sprite running = 5352/8
    QUAD_HEIGHT = SPRITE_HEIGHT

    love.graphics.newQuad(0, 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT) -- first two numbers are the location of the first bite (x=0, y=0)

    quads = {}

    for i = 1, jack.animation.max_frames do
       quads[i] = love.graphics.newQuad(QUAD_WIDTH* (i - 1), 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT) -- first two numbers are the location of the first bite (x=QUAD_WIDTH* (i - 1), y=0), this will allow to avoid copy-paste 8 times (1 per sprint)
    end

end

function love.update(dt)

    if love.keyboard.isDown("left") then
        jack.animation.idle = false
        jack.animation.direction = "left"
    elseif love.keyboard.isDown("right") then
        jack.animation.idle = false
        jack.animation.direction = "right"
    else
        jack.animation.idle = true
        jack.animation.frame = 1
        
        
    end

    if not jack.animation.idle then
        jack.animation.timer = jack.animation.timer + dt

        if jack.animation.timer > 0.2 then
            jack.animation.timer = 0.1

            jack.animation.frame = jack.animation.frame + 1 -- this will change the frame every time the timer hits 0.2

            if jack.animation.direction == "right" then
                jack.x = jack.x + jack.animation.speed
            elseif jack.animation.direction == "left" then
                jack.x = jack.x - jack.animation.speed            
            end

            if jack.animation.frame > jack.animation.max_frames then
                jack.animation.frame = 1
            end
        end
    end
end

function love.draw()
    love.graphics.scale(0.3)

    if jack.animation.direction == "right" then
        love.graphics.draw(jack.sprite, quads[jack.animation.frame], jack.x, jack.y)
    else
        love.graphics.draw(jack.sprite, quads[jack.animation.frame], jack.x, jack.y, 0, -1, 1, QUAD_WIDTH, 0)      -- the last 5 numbers are for the sprint to mirror, what means, the first of the 5 (0) is the radiance (mirror), the second (-1) that will make flip to the other way and mantain the position without going some random location, the quad is to mantain the apperance     
    end

end