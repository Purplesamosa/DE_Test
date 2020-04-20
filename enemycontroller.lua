EnemyController = Object:extend()

--initalise default values
function EnemyController:new()
self.enemycount = 0
self.enemies = {}
self.maxenemies = 6
self.originalradius = 50
self.reductionscalar = 1.5
self.enemyspawnframe = 60
self.enemyspawnframeCap = 60
self.shouldspawnenemies = false
end

function EnemyController:update(dt)
  --move all enemies around
  for i,e in ipairs(self.enemies) do
    e:update(dt)
  end
  --increment frame if enemy should spawn
  self.enemyspawnframe = self.enemyspawnframe + 1
  --spawn enemy
  if self.shouldspawnenemies == true and self.enemyspawnframe > self.enemyspawnframeCap then
    self:SpawnEnemies()
  end
end

--draw all enemies
function EnemyController:draw()
  for i,e in ipairs(self.enemies) do
    e:draw()
  end
end

--spawn enemy logic
function EnemyController:SpawnEnemies()
  local xSpawn = love.math.random(0,love.graphics.getWidth())
  local ySpawn = love.math.random(0,gamespaceY - game.player.height*4)
  if TestSpawnLocation(xSpawn, ySpawn, 75) == false and self.enemyspawnframe >= 20 then
    table.insert(self.enemies, Enemy(xSpawn,ySpawn , self.originalradius, love.math.random(-75,75),love.math.random(-75,75)))
    game.audiocontroller.PlayEnemySpawnSound()
    self.enemycount = self.enemycount + 1
    self.enemyspawnframe = 0
    if self.enemycount >= self.maxenemies then
      self.shouldspawnenemies = false
    end
  end
end

--enemy hit logic (enemy removed from table at collision point)
function EnemyController:EnemyDeath(deadenemy)
  game.score = game.score + 250/deadenemy.radius
  if (self.originalradius / self.reductionscalar) / self.reductionscalar < deadenemy.radius then
    local xSpawn = math.min(deadenemy.x + deadenemy.radius/self.reductionscalar,love.graphics.getWidth())
    local ySpawn = math.min(deadenemy.y + deadenemy.radius/self.reductionscalar,gamespaceY)
    table.insert(self.enemies, Enemy(xSpawn, ySpawn , deadenemy.radius/self.reductionscalar, love.math.random(-75,75),love.math.random(-75,75)))
    local xSpawn = math.max(deadenemy.x - deadenemy.radius/self.reductionscalar,0)
    local ySpawn = math.max(deadenemy.y - deadenemy.radius/self.reductionscalar,0)
    table.insert(self.enemies, Enemy(xSpawn, ySpawn , deadenemy.radius/self.reductionscalar, love.math.random(-75,75),love.math.random(-75,75)))
    self.enemycount = self.enemycount + 2
  end
  self.enemycount = self.enemycount - 1
  if self.enemycount <= 4 then
    self.shouldspawnenemies = true
  end
  game.audiocontroller.PlayEnemyDeathSound()
end
