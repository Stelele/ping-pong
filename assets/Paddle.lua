-- https://github.com/jonstoler/class.lua
require '../libraries/class'

Paddle = class()

function Paddle:init(WINDOW_WIDTH, WINDOW_HEIGHT, xPos, yPos, width, height, upKey, downKey)
    self.PADDLE_SPEED = 200
    self.WINDOW_WIDTH = WINDOW_WIDTH
    self.WINDOW_HEIGHT = WINDOW_HEIGHT

    self.x = xPos
    self.y = yPos
    self.width = width
    self.height = height
    self.upControl = upKey
    self.downControl = downKey
end

function Paddle:update(dt)
    if love.keyboard.isDown(self.upControl) then
        self.y = math.max(2, self.y - self.PADDLE_SPEED * dt)
    elseif love.keyboard.isDown(self.downControl) then
        self.y = math.min(self.WINDOW_HEIGHT - self.height - 2, self.y + self.PADDLE_SPEED * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end