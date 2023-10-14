-- https://github.com/jonstoler/class.lua
require '../libraries/class'

Paddle = class()

function Paddle:init(windowWidth, windowHeight, xPos, yPos, width, height, upKey, downKey)
    self.PADDLE_SPEED = 200
    self.WINDOW_WIDTH = windowWidth
    self.WINDOW_HEIGHT = windowHeight

    self.x = xPos
    self.y = yPos
    self.width = width
    self.height = height
    self.upControlKey = upKey
    self.downControlKey = downKey
end

function Paddle:update(dt)
    if love.keyboard.isDown(self.upControlKey) then
        self.y = math.max(2, self.y - self.PADDLE_SPEED * dt)
    elseif love.keyboard.isDown(self.downControlKey) then
        self.y = math.min(self.WINDOW_HEIGHT - self.height - 2, self.y + self.PADDLE_SPEED * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end