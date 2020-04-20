function love.load(arg)
  Object = require ("classic")
  require("game")
  require("physicscontroller")
  require("enemycontroller")
  require("bulletcontroller")
  require("uicontroller")
  require("audiocontroller")
  require("timer")
  require("entity")
  require("player")
  require("enemy")
  require("bullet")

  game = Game()
end

function love.update(dt)
  -- body...
  game:update(dt)
end

function love.draw()
  game:draw()
end
