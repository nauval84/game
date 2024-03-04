function love.load()
    camera = require 'libraries/camera'
    cam = camera()

    anim8 = require 'libraries/anim8'
    love.graphics.setDefaultFilter("nearest", "nearest")

    sti = require'libraries/sti'
    gameMap = sti('map/testMap.lua')

    player = {}
    player.x = 400
    player.y = 200
    player.speed = 3
    player.sprites = love.graphics.newImage('sprites/parrot.png')
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png') 
    player.grid = anim8.newGrid( 12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())
    
    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1),0.2)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 2),0.2)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 3),0.2)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 4),0.2)

    player.anim = player.animations.left

    background = love.graphics.newImage('sprites/background.png')

end

function love.update(dt)
    local isMoving = false


    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.anim = player.animations.right
        isMoving = true
    end
    
    if love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.anim = player.animations.left
        isMoving = true
    end

    if love.keyboard.isDown("up") then 
        player.y = player.y - player.speed
        player.anim = player.animations.up
        isMoving = true
    end

    if love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.anim = player.animations.down
        isMoving = true
    end

    if isMoving == false then
        player.anim:gotoFrame(2)
    end

    player.anim:update(dt)

    cam: lookAt(player.x, player.y)

end

function love.draw()
    cam:attach()
        gameMap:drawLayer(gameMap.layers["Ground"])
        gameMap:drawLayer(gameMap.layers["Trees"])
        player.anim:draw(player.spriteSheet, player.x, player.y, nil, 10)
    cam:detach()
end



