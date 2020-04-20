AudioController = Object:extend()

function AudioController:new()
  shootSource = love.audio.newSource("shoot.ogg", "stream")
  enemyDeathSource = love.audio.newSource("hitenemy.ogg", "stream")
  hitPlayerSource = love.audio.newSource("playerhit.ogg", "stream")
  gameoverSource = love.audio.newSource("gameover.ogg", "stream")
  enemyspawnSource = love.audio.newSource("enemyspawn.ogg", "stream")
end

--player shooting sound
function AudioController:PlayShootSound()
  shootSource = love.audio.newSource("shoot.ogg", "stream")
  love.audio.play(shootSource)
end

--enemy hit sound
function AudioController:PlayEnemyDeathSound()
  enemyDeathSource = love.audio.newSource("hitenemy.ogg", "stream")
  love.audio.play(enemyDeathSource)
end

--player hit sound
function AudioController:PlayHitPlayerSound()
  hitPlayerSource = love.audio.newSource("playerhit.ogg", "stream")
  love.audio.play(hitPlayerSource)
end

--enemy spawn sound
function AudioController:PlayEnemySpawnSound()
  enemyspawnSource = love.audio.newSource("enemyspawn.ogg", "stream")
  love.audio.play(enemyspawnSource)
end

--gamover sound
function AudioController:PlayGameOverSound()
  love.audio.stop()
  gameoverSource = love.audio.newSource("gameover.ogg", "stream")
  tableSources = {hitPlayerSource, gameoverSource}
  love.audio.play(tableSources)
end
