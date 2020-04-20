BulletController = Object:extend()

function BulletController:new()
self.bullets = {}
end

function BulletController:update(dt)
  for i,b in ipairs(self.bullets) do
    b:update(dt)
    if(b.y < -10) then
      table.remove(self.bullets,i)
    end
  end
end

function BulletController:draw()
  for i,b in ipairs(self.bullets) do
    b:draw()
  end
end

function BulletController:SpawnBullet(xSpd, ySpd)
    table.insert(self.bullets, Bullet(0, 0, 0, 0, xSpd, ySpd))
end
