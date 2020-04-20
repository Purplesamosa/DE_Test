Game = Object:extend()

--gamespace to help with UI space
gamespaceY = love.graphics.getHeight() - 100

--initalise
function Game:new()
  self.firstTime = true
  self.score = 0
  self.gameoverframes = 0
  self.gameoverframecap = 120
  self.timer = Timer()
  self.physicscontroller = PhysicsController()
  self.player = Player()
  self.enemycontroller = EnemyController()
  self.bulletcontroller = BulletController()
  self.uicontroller = UIController()
  self.audiocontroller = AudioController()
end

--update all references
function Game:update(dt)
  self.timer:update(dt)
  self.player:update(dt)
  self.enemycontroller:update(dt)
  self.bulletcontroller:update(dt)
  self.physicscontroller:update(dt)
  self.uicontroller:update(dt)

  self.gameoverframes = self.gameoverframes + 1

  if (self.player.alive == false and love.keyboard.isDown("space")) or (self.player.alive == false and love.mouse.isDown(1)) then
    if(self.gameoverframes >= self.gameoverframecap or self.firstTime) then
      self:StartGame()
    end
  end
end

--draw all references
function Game:draw()
  self.player:draw()
  self.enemycontroller:draw()
  self.bulletcontroller:draw()
  self.uicontroller:draw()
end

--set values to start game
function Game:StartGame()
  self.player:Reset()
  self.enemycontroller.shouldspawnenemies = true
  self.firstTime = false
  self.score = 0
end

--set values to end game
function Game:EndGame()
  while #self.enemycontroller.enemies ~= 0 do
    rawset(self.enemycontroller.enemies, #self.enemycontroller.enemies, nil)
  end
  self.enemycontroller.enemycount = 0
  while #self.bulletcontroller.bullets ~= 0 do
    rawset(self.bulletcontroller.bullets, #self.bulletcontroller.bullets, nil)
  end
  self.player.alive = false
  self.gameoverframes = 0
  self.audiocontroller.PlayGameOverSound()
end
