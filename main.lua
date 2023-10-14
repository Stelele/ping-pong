-- https://github.com/Ulydev/push
local push = require("libraries.push")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

function love.load()
    love.graphics.setDefaultFilter("nearest","nearest")

    math.randomseed(os.time())

    SMALL_FONT = love.graphics.newFont("fonts/RetroGaming.ttf", 16)
    SCORE_FONT = love.graphics.newFont("fonts/RetroGaming.ttf", 32)

    love.graphics.setFont(SMALL_FONT)

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    player1Score = 0
    player2Score = 0

    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    BALL_START_X = VIRTUAL_WIDTH / 2 - 2
    BALL_START_Y = VIRTUAL_HEIGHT / 2 - 2

    ballX = BALL_START_X
    ballY = BALL_START_Y
    ballDx = math.random(2) == 1 and 100 or -100
    ballDy = math.random(-50, 50) * 1.5

    gameState = 'start'
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
            ballX = BALL_START_X
            ballY = BALL_START_Y

            ballDx = math.random(2) == 1 and 100 or -100
            ballDy = math.random(-50, 50) * 1.5

        end
    end
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = math.max(2, player1Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 22, player1Y + PADDLE_SPEED * dt)
    end

    if love.keyboard.isDown('up') then
        player2Y = math.max(2, player2Y - PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 22, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDx * dt
        ballY = ballY + ballDy * dt 
    end
end

function love.draw()
    push:start()
    love.graphics.clear(40/255, 45/255, 52/255, 255)

    love.graphics.setFont(SMALL_FONT)
    love.graphics.printf("Hello Pong!", 0, 20, VIRTUAL_WIDTH, "center")
    
    love.graphics.setFont(SCORE_FONT)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)

    love.graphics.rectangle("fill", 10, player1Y, 5, 20)

    love.graphics.rectangle("fill", VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    love.graphics.rectangle("fill", ballX, ballY, 4, 4)

    push:finish()
end