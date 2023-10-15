require 'assets.GameBoard'

-- https://github.com/Ulydev/push
local push = require("libraries.push")

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load()
    love.window.setTitle('Classic Pong')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    gameBoard = GameBoard(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end

function love.keypressed(key)
    gameBoard:keyPressed(key)
end

function love.update(dt)
    gameBoard:update(dt)
end

function love.draw()
    push:start()
    gameBoard:render()
    push:finish()
end
