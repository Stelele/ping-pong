require '../libraries/class'
require '../assets/Ball'
require '../assets/Paddle'

GameBoard = class()

function GameBoard:init(WINDOW_WIDTH, WINDOW_HEIGHT)
    love.graphics.setDefaultFilter("nearest","nearest")
    math.randomseed(os.time())

    self.SMALL_FONT = love.graphics.newFont(8, "mono")
    self.SCORE_FONT = love.graphics.newFont(32, "mono")

    love.graphics.setFont(self.SMALL_FONT)
    
    self.WINDOW_WIDTH = WINDOW_WIDTH
    self.WINDOW_HEIGHT = WINDOW_HEIGHT

    self.player1Score = 0
    self.player2Score = 0

    self.player1 = Paddle(WINDOW_WIDTH, WINDOW_HEIGHT, 10, 30, 5, 20, 'w', 's')
    self.player2 = Paddle(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH - 10, WINDOW_HEIGHT - 50, 5, 20, 'up', 'down')

    self.servingPlayer = math.random(2)
    self.gameBall = Ball(WINDOW_WIDTH, WINDOW_HEIGHT, self.servingPlayer)

    self.gameState = 'start'
end

function GameBoard:keyPressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if self.gameState == 'start' then
            self.gameState = 'serve'
        elseif self.gameState == 'serve' then
            self.gameBall:setDirection(self.servingPlayer)
            self.gameState = 'play'
        else
            self.gameState = 'serve'
            self.gameBall:reset()
        end
    end
end

function GameBoard:update(dt)
    self.player1:update(dt)
    self.player2:update(dt)

    if self.gameState == 'play' then
        if self.gameBall:collides(self.player1) or self.gameBall:collides(self.player2)  then
            self.gameBall:invertDirection()
        end
        self.gameBall:update(dt) 
    end

    self.updateScore(self)
end

function GameBoard: render()
    love.graphics.clear(40/255, 45/255, 52/255, 1)

    love.graphics.setFont(self.SMALL_FONT)

    if self.gameState == 'start' then
        love.graphics.printf("Hello Pong!", 0, 20, self.WINDOW_WIDTH, "center")
    else
        love.graphics.printf("Player " .. tostring(self.servingPlayer) .. " to serve", 0, 20, self.WINDOW_WIDTH, "center")
    end

    if self.gameState == 'start' then
        love.graphics.printf("Press enter to start serve", 0, 30, self.WINDOW_WIDTH, "center")    
    end

    if self.gameState == 'serve' then
        love.graphics.printf("Press enter to start playing", 0, 30, self.WINDOW_WIDTH, "center")
    end

    love.graphics.setFont(self.SCORE_FONT)
    love.graphics.print(tostring(self.player1Score), self.WINDOW_WIDTH / 2 - 50, self.WINDOW_HEIGHT / 3)
    love.graphics.print(tostring(self.player2Score), self.WINDOW_WIDTH / 2 + 30, self.WINDOW_HEIGHT / 3)

    self.player1:render()
    self.player2:render()

    self.gameBall:render()
end

function GameBoard:updateScore()
    if self.gameBall.x < 0 then
        self.servingPlayer = 1
        self.player2Score = self.player2Score + 1
        self.gameBall:reset()
        self.gameState = 'serve'
    end

    if self.gameBall.x > self.WINDOW_WIDTH then
        self.servingPlayer = 2
        self.player1Score = self.player1Score + 1
        self.gameBall:reset()
        self.gameState = 'serve'
    end
end