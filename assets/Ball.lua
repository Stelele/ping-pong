-- https://github.com/jonstoler/class.lua
require '../libraries/class'

Ball = class()

function Ball:init(windowWidth, windowHeight)
    self.BALL_START_X = windowWidth / 2 - 2
    self.BALL_START_Y = windowHeight / 2 - 2

    self.ballX = self.BALL_START_X
    self.ballY = self.BALL_START_Y

    self.ballDx = math.random(2) == 1 and 100 or -100
    self.ballDy = math.random(-50, 50) * 1.5
end

function Ball:reset()
    self.ballX = self.BALL_START_X
    self.ballY = self.BALL_START_Y

    self.ballDx = math.random(2) == 1 and 100 or -100
    self.ballDy = math.random(-50, 50) * 1.5
end

function Ball:update(dt)
    self.ballX = self.ballX + self.ballDx * dt
    self.ballY = self.ballY + self.ballDy * dt
end

function Ball:render()
    love.graphics.rectangle("fill", self.ballX, self.ballY, 4, 4)
end