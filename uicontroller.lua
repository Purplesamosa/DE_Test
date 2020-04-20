UIController = Object:extend()

function UIController:new()
  self.triangle = {50, gamespaceY + 75, 75, gamespaceY + 25, 100, gamespaceY + 75}
end

function UIController:update(dt)

end

function UIController:draw()
  --set base green color
  love.graphics.setColor(0, 1, 0, 1)
  if game.player.alive == false and game.firstTime then -- if game first loaded up
    love.graphics.print("Press \"fire\" to start game ! ", 150, gamespaceY/2, 0, 3, 3)
  elseif game.player.alive == false then -- if player reached gameover screen
    love.graphics.print("Game Over ! ", 150, gamespaceY/2 - 150, 0, 3, 3)
    love.graphics.print("Final Score : " .. game.score*100, 150, gamespaceY/2 -50 , 0, 3, 3)
    love.graphics.print("Press \"fire\" to retry ! ", 150, gamespaceY/2 + 100, 0, 3, 3)
  end
  -- draw a UI line to seperate UI and Gamespace
  love.graphics.line(0, gamespaceY, love.graphics.getWidth(), gamespaceY)
  love.graphics.print("Lives :", 5, gamespaceY + 35, 0 , 2.5, 2.5)
  love.graphics.setColor(1, 1, 1, 1)
  --draw player lives
  for i=1, game.player.lives do
    love.graphics.polygon("fill", {110 + (75 * (i-1)), gamespaceY + 75, 135 + (75 * (i-1)), gamespaceY + 25, 160 + (75 * (i-1)), gamespaceY + 75})
  end
  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.print("Score : " .. game.score*100,love.graphics.getWidth() - 350 , gamespaceY + 35, 0 , 2.5, 2.5)
end
