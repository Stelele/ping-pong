-- https://github.com/jonstoler/class.lua
require '../libraries/class'

Ball = class()

function Ball:init(windowWidth, windowHeight, startDirection)
    self.WINDOW_WIDTH = windowWidth
    self.WINDOW_HEIGHT = windowHeight

    self.START_X = windowWidth / 2 - 2
    self.START_Y = windowHeight / 2 - 2

    self.WIDTH = 4
    self.HEIGHT = 4

    self.x = self.START_X
    self.y = self.START_Y

    self.Dx = startDirection == 1 and 100 or -100
    self.Dy = math.random(-50, 50) * 1.5

    self.sounds = {
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }
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
        self.sounds['wall_hit']:play()
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

    if self.Dx > 0 then
        self.x = paddle.x - self.WIDTH
    else
        self.x = paddle.x + paddle.width
    end

    return true
end

function Ball:invertDirection()
    self.Dx = self.Dx * -1.10
    self.Dy = self.Dy < 0 and -math.random(10, 150) or math.random(10, 150)
end

function Ball:setDirection(direction)
    if direction == 1 then
        self.Dx = self.Dx > 0 and self.Dx or -self.Dx
    elseif direction == 2 then
        self.Dx = self.Dx > 0 and -self.Dx or self.Dx
    end
end