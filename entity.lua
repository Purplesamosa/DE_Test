--entity baseclass for all moving objects in game
Entity = Object:extend()

function Entity:new(x, y, width, height)
  self.x = x
  self.y = y
  self.width = width
  self.height = height
  self.xSpeed = 0
  self.ySpeed = 0
end

function Entity:update(dt)
  self.x = self.x + (self.xSpeed * dt)
  self.y = self.y + (self.ySpeed * dt)
end

function Entity:draw()
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
