Bullet = Entity:extend()

function Bullet:new(x, y, width, height, xVelo, yVelo)
  self.x = game.player.x - 5
  self.y = game.player.y
  Bullet.super.new(self,self.x,self.y,10,10)
  self:SetSpeed(xVelo, yVelo)
end

function Bullet:update(dt)
  Bullet.super.update(self,dt)
end

function Bullet:draw()
  love.graphics.setColor(1, 1, 1, 1)
  Bullet.super.draw(self)
end

function Bullet:SetSpeed(xVel, yVel)
  self.xSpeed = xVel
  self.ySpeed = yVel
end
