Player = Entity:extend()

--player initalise
function Player:new(x, y, width, height)
  self.firecd = 20
  self.fireyoncd = 0
  self.firexoncd = 0
  self.xOffset = 25
  self.yOffset = 50
  self.alive = false
  self.x = love.graphics.getWidth()/2 -self.xOffset
  self.y = gamespaceY-self.yOffset
  self.vertices = {self.x,self.y,self.x - self.xOffset, self.y +   self.yOffset, self.x + self.xOffset, self.y +  self.yOffset}
  self.lives = 0
  self.invincibility = 0
  self.colortoggle = false
  self.iframetoggle = 0
  self.iframetoggleframe = 5
  self.iframes = 60
  Player.super.new(self,self.x,self.y,50,50)
end

function Player:update(dt)
  if self.alive == true then
    -- player movement Offset used to calculate edge vertices of triangle
    if love.keyboard.isDown("right") and self.x + self.xOffset <= love.graphics.getWidth() or love.keyboard.isDown("d") and self.x + self.xOffset <= love.graphics.getWidth() then
        self.xSpeed = 250
    elseif love.keyboard.isDown("left") and self.x >= 0 + self.xOffset or love.keyboard.isDown("a") and self.x >= 0 + self.xOffset then
        self.xSpeed = -250
    else
      self.xSpeed = 0
    end

    -- player verticle fire
    if (love.keyboard.isDown("space") or love.mouse.isDown(1)) and self.fireyoncd >= self.firecd then
      game.bulletcontroller:SpawnBullet(0,-500)
      game.audiocontroller.PlayShootSound()
      self.fireyoncd = 0
    end

    --player horiztonal fire
    if (love.keyboard.isDown("lctrl") or love.mouse.isDown(2)) and self.firexoncd >= self.firecd then
      game.bulletcontroller:SpawnBullet(500,0)
      game.bulletcontroller:SpawnBullet(-500,0)
      game.audiocontroller.PlayShootSound()
      self.firexoncd = 0
    end

    -- increment firecool downs to allow player to fire again
    self.fireyoncd = self.fireyoncd + 1
    self.firexoncd = self.firexoncd + 1

    -- increment invincbility frames to know when to remove from player
    self.invincibility = self.invincibility + 1
    self.iframetoggle = self.iframetoggle + 1

    --update player locations
    Player.super.update(self,dt)
    self.vertices = {self.x,self.y,self.x - self.xOffset, self.y + self.yOffset, self.x + self.xOffset, self.y +self.yOffset}



  end
end

function Player:draw()
  if self.alive == true then
    --toggle invincibility frames color change
    if self.invincibility < self.iframes then
      if self.colortoggle == true then
        love.graphics.setColor(0.2, 0.2, 0.2, 0.8)
        if self.iframetoggle >= self.iframetoggleframe then
          self.colortoggle = false
          self.iframetoggle = 0
        end
      else
        love.graphics.setColor(0.9, 0.9, 0.9, 0.8)
        if self.iframetoggle >= self.iframetoggleframe then
          self.colortoggle = true
          self.iframetoggle = 0
        end
      end
      --end of invincibility code
    else
      love.graphics.setColor(1, 1, 1, 1) -- normal color white.
    end
    love.graphics.polygon("fill",self.vertices) -- draw player triangle
  end
end

--see if the player can be hurt and if he should be killed
function Player:AttemptKill()
  if self.invincibility >= self.iframes then
    game.audiocontroller.PlayHitPlayerSound()
    self.lives = self.lives - 1
    self.invincibility = 0
    if self.lives <= 0 then
      game:EndGame()
    end
  end
end

--reset player default values to reset game
function Player:Reset()
  self.alive = true
  self.firecd = 20
  self.fireyoncd = 0
  self.firexoncd = 0
  self.xOffset = 25
  self.yOffset = 50
  self.x = love.graphics.getWidth()/2 -self.xOffset
  self.y = gamespaceY-self.yOffset
  self.vertices = {self.x,self.y,self.x - self.xOffset, self.y +   self.yOffset, self.x + self.xOffset, self.y +  self.yOffset}
  self.lives = 3
  self.invincibility = 0
  self.iframetoggle = 0
  self.colortoggle = false
end
