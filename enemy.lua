Enemy = Entity:extend()

--initalisation
function Enemy:new(x, y, radius, xSpd, ySpd)
  self.radius = radius
  Enemy.super.new(self, x, y, self.radius, xSpd, ySpd)
  self:SetSpeed(xSpd, ySpd)
  self.secX = 0
  self.secY = 0
  self.minX = 0
  self.minY = 0
  self.hourX = 0
  self.hourY = 0
end

--set speed of enemy
function Enemy:SetSpeed(xSpd, ySpd)
self.xSpeed = xSpd
self.ySpeed = ySpd
end

function Enemy:update(dt)
  --update location
  self.x = self.x + (self.xSpeed * dt)
  self.y = self.y + (self.ySpeed * dt)

  --bounce on walls
  if self.y <= 0 + self.radius then
    self.y = 0 + self.radius
    self.ySpeed = -self.ySpeed
  elseif self.y >= gamespaceY - self.radius then
    self.y = gamespaceY - self.radius
    self.ySpeed = -self.ySpeed
  end
  if self.x <= 0 + self.radius then
    self.x = 0 + self.radius
    self.xSpeed = -self.xSpeed
  elseif self.x >= love.graphics.getWidth() - self.radius then
    self.x = love.graphics.getWidth() - self.radius
    self.xSpeed = -self.xSpeed
  end

  --calucate the second vertices of each clock hand
  self.secX = self.radius*game.timer.secAngleX
  self.secY = self.radius*game.timer.secAngleY
  self.minX = self.radius*game.timer.minAngleX
  self.minY = self.radius*game.timer.minAngleY
  self.hourX = self.radius*game.timer.hourAngleX
  self.hourY = self.radius*game.timer.hourAngleY

  Enemy.super.update(self,dt)
end

function Enemy:draw()
  --draw base enemy circle
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.circle("line", self.x, self.y, self.radius)

  --draw clock hands
  love.graphics.setColor(0, 0, 1, 1)
  love.graphics.line(self.x ,self.y, self.x + (self.hourX * 0.75) , self.y + (self.hourY * 0.75))
  love.graphics.setColor(0, 1, 0, 1)
  love.graphics.line(self.x ,self.y, self.x + self.minX , self.y + self.minY)
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.line(self.x - self.secX/4 ,self.y - self.secY/4, self.x + self.secX , self.y + self.secY)

end
