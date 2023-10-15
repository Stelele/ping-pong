-- https://github.com/jonstoler/class.lua
require '../libraries/class'

Ball = class()

function Ball:init(windowWidth, windowHeight)
    self.WINDOW_WIDTH = windowWidth
    self.WINDOW_HEIGHT = windowHeight

    self.START_X = windowWidth / 2 - 2
    self.START_Y = windowHeight / 2 - 2

    self.WIDTH = 4
    self.HEIGHT = 4

    self.x = self.START_X
    self.y = self.START_Y

    self.Dx = math.random(2) == 1 and 100 or -100
    self.Dy = math.random(-50, 50) * 1.5
end

function Ball:reset()
    self.x = self.START_X
    self.y = self.START_Y

    self.Dx = math.random(2) == 1 and 100 or -100
    self.Dy = math.random(-50, 50) * 1.5
end

function Ball:update(dt)
    self.x = self.x + self.Dx * dt

    if self.y <= 2 or self.y >= self.WINDOW_HEIGHT - self.HEIGHT - 2 then
        self.Dy = -self.Dy
    end
    self.y = self.y + self.Dy * dt 

end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y,self.WIDTH , self.HEIGHT)
end

function Ball:collides(paddle)
    if self.x > paddle.x + paddle.width or paddle.x > self.x + self.WIDTH  then
        return false
    end

    if self.y > paddle.y + paddle.height or paddle.y > self.y + self.HEIGHT then
        return false
    end

    return true
end

function Ball:invertXDirection(paddle)
    self.Dx = self.Dx * -1.10
end