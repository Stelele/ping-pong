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

    self.gameBall = Ball(WINDOW_WIDTH, WINDOW_HEIGHT)

    self.gameState = 'start'
end

function GameBoard:keyPressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    if key == 'enter' or key == 'return' then
        if self.gameState == 'start' then
            self.gameState = 'play'
        else
            self.gameState = 'start'
            self.gameBall:reset()
        end
    end
end

function GameBoard:update(dt)
    self.player1:update(dt)
    self.player2:update(dt)

    if self.gameState == 'play' then
        if self.gameBall:collides(self.player1) then
            self.gameBall:invertXDirection(self.player1)
        elseif  self.gameBall:collides(self.player2) then
            self.gameBall:invertXDirection(self.player2)
        end
        self.gameBall:update(dt) 
    end
end

function GameBoard: render()
    love.graphics.clear(40/255, 45/255, 52/255, 1)

    love.graphics.setFont(self.SMALL_FONT)
    love.graphics.printf("Hello Pong!", 0, 20, self.WINDOW_WIDTH, "center")
    
    love.graphics.setFont(self.SCORE_FONT)
    love.graphics.print(tostring(self.player1Score), self.WINDOW_WIDTH / 2 - 50, self.WINDOW_HEIGHT / 3)
    love.graphics.print(tostring(self.player2Score), self.WINDOW_WIDTH / 2 + 30, self.WINDOW_HEIGHT / 3)

    self.player1:render()
    self.player2:render()

    self.gameBall:render()
end