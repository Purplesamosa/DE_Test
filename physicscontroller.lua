PhysicsController = Object:extend()

function PhysicsController:new()

end

function PhysicsController:update(dt)

--enemy collide with enemy
if(game.enemycontroller.enemycount > 1) then
  CheckEnemyVsEnemyCollisions()
end

--enemy collide with bullet
  CheckEnemyVsBulletCollision()

  if TestEnemyVsPlayerCollision() then
    game.player:AttemptKill()
  end
end

--test to see if spawn location is safe
function TestSpawnLocation(xSpawn, ySpawn, rSpawn)
  b = false
  if game ~= nil then
    for i=1, #game.enemycontroller.enemies - 1 do
      local enemyA = game.enemycontroller.enemies[i]
      b = distBasedCollision(enemyA.x, enemyA.y, xSpawn, ySpawn, enemyA.radius, rSpawn)
    end
  end
  return b
end

--distance check between circles
function distBasedCollision(ax, ay, bx, by, ar, br)
  return (bx - ax)^2 + (by - ay)^2 < (ar + br)^2
end

-- check if enemy collided with enemy and change velocity accordingly
function CheckEnemyVsEnemyCollisions()
  for i=1, #game.enemycontroller.enemies - 1 do
    local enemyA = game.enemycontroller.enemies[i]
    for j=i+1, #game.enemycontroller.enemies do
      local enemyB = game.enemycontroller.enemies[j]
      if distBasedCollision(enemyA.x, enemyA.y, enemyB.x, enemyB.y, enemyA.radius, enemyB.radius) then

--displacement
          dist = math.sqrt((enemyB.x - enemyA.x)^2 + (enemyB.y - enemyA.y)^2)
          overlap = 0.5 * (dist - enemyA.radius - enemyB.radius)
          enemyA.x = enemyA.x - overlap * (enemyA.x - enemyB.x) / dist
          enemyA.y = enemyA.y - overlap * (enemyA.y - enemyB.y) / dist

          enemyB.x = enemyB.x + overlap * (enemyA.x - enemyB.x) / dist
          enemyB.y = enemyB.y + overlap * (enemyA.x - enemyB.x) / dist

          dx = enemyA.x - enemyB.x
          dy = enemyA.y - enemyB.y
          dangle = math.atan2(dy, dx)
          sind = math.sin(dangle)
          cosd = math.cos(dangle)

          vx1 = (cosd * enemyA.xSpeed) + (sind * enemyA.ySpeed)
          vy1 = (cosd * enemyA.ySpeed) + (-sind * enemyA.xSpeed)
          vx2 = (cosd * enemyB.xSpeed) + (sind * enemyB.ySpeed)
          vy2 = (cosd * enemyB.ySpeed) + (-sind * enemyB.xSpeed)

          v1f = ((enemyA.radius - enemyB.radius)*vx1 + (2*enemyB.radius*vx2)) / (enemyA.radius + enemyB.radius)
          v2f = ((enemyB.radius - enemyA.radius)*vx2 + (2*enemyA.radius*vx1)) / (enemyA.radius + enemyB.radius)

          enemyA.xSpeed = (cosd *v1f) + (-sind * vy1)
          enemyA.ySpeed = (cosd *vy1) + (sind * v1f)
          enemyB.xSpeed = (cosd *v2f) + (-sind * vy2)
          enemyB.ySpeed = (cosd *vy2) + (sind * v2f)

      end
    end
  end
end

--check if enemy hit by bullet and remove both objects if so.
function CheckEnemyVsBulletCollision()
  for i,e in ipairs(game.enemycontroller.enemies) do
    local enemyA = game.enemycontroller.enemies[i]
    for j,b in ipairs(game.bulletcontroller.bullets) do
      local bulletB = game.bulletcontroller.bullets[j]
      if TestEnemyVsBulletCollision(enemyA.x, enemyA.y, enemyA.radius, bulletB.x, bulletB.y, bulletB.width, 0) then
        table.remove(game.bulletcontroller.bullets,j)
        game.enemycontroller:EnemyDeath(enemyA)
        table.remove(game.enemycontroller.enemies,i)
      end
    end
  end
end

-- circle and rectangle collision for enemy and bullets
function TestEnemyVsBulletCollision( cx,  cy,  cr,  rx,  ry,  rw,  rh)
  -- temporary variables to set edges for testing
  testX = cx
  testY = cy

  -- which edge is closest?
  if cx < rx then
    testX = rx      -- test left edge
  elseif (cx > rx+rw) then
  testX = rx+rw   -- right edge
  end
  if cy < ry then
    testY = ry       -- top edge
  elseif cy > ry+rh then
    testY = ry+rh   -- bottom edge
  end

  -- get distance from closest edges
  distX = cx-testX
  distY = cy-testY
  distance = math.sqrt((distX*distX) + (distY*distY))

  -- if the distance is less than the radius, collision!
  if distance <= cr then
    return true
  end
  return false
end

---------------------
-- test player triangle vs enemy circle collision
function TestEnemyVsPlayerCollision()
  v1x = game.player.vertices[1]
  v1y = game.player.vertices[2]
  v2x = game.player.vertices[3]
  v2y = game.player.vertices[4]
  v3x = game.player.vertices[5]
  v3y = game.player.vertices[6]

  for i,e in ipairs(game.enemycontroller.enemies) do
    c1x = e.x - v1x
    c1y = e.y - v1y

    radiusSqr = e.radius*e.radius
    c1sqr = c1x*c1x + c1y*c1y - radiusSqr

    if c1sqr <= 0 then
      return true
    end

    c2x = e.x - v2x
    c2y = e.y - v2y
    c2sqr = c2x*c2x + c2y*c2y - radiusSqr

    if c2sqr <= 0 then
      return true
    end

    c3x = e.x - v3x
    c3y = e.y - v3y

    c3sqr = c3x*c3x + c3y*c3y - radiusSqr

    if c3sqr <= 0 then
      return true
    end

    -- TEST 2: Circle centre within triangle

    -- Calculate edges

    e1x = v2x - v1x
    e1y = v2y - v1y

    e2x = v3x - v2x
    e2y = v3y - v2y

    e3x = v1x - v3x
    e3y = v1y - v3y

  --  if signum(e1y*c1x - e1x*c1y) >= 0 or signum(e2y*c2x - e2x*c2y) >= 0 or signum(e3y*c3x - e3x*c3y) >= 0 then
      --   return true
  --  end

    k = c1x*e1x + c1y*e1y

    if k > 0 then
      len = e1x*e1x + e1y*e1y     -- squared len
      if k < len then
        if c1sqr * len <= k*k then
          return true
        end
      end
    end

    -- Second edge
    k = c2x*e2x + c2y*e2y

    if k > 0 then
      len = e2x*e2x + e2y*e2y
      if k < len then
        if c2sqr * len <= k*k then
          return true
        end
      end
    end

    -- Third edge
    k = c3x*e3x + c3y*e3y

    if k > 0 then
      len = e3x*e3x + e3y*e3y
      if k < len then
        if c3sqr * len <= k*k then
          return true
        end
      end
    end
  end
    -- We're done, no intersection
  return false
end
