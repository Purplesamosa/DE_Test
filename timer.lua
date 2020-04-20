Timer = Object:extend()

function Timer:new()
  self:SetTime()
end

--update the current time
function Timer:update(dt)
  self:SetTime()
end

--timer used to calculate angle for enemies
function Timer:SetTime()
  self.timetable = os.date("*t")
  self.hour = self.timetable.hour
  self.min = self.timetable.min
  self.sec = self.timetable.sec
  --can be improved by adding seconds to minutes, and minutes and seconds to hours
  self.secAngleX = math.cos(math.rad(((self.sec-15)*6)))
  self.secAngleY = math.sin(math.rad(((self.sec-15)*6)))
  self.minAngleX = math.cos(math.rad(((self.min-15)*6)))
  self.minAngleY = math.sin(math.rad(((self.min-15)*6)))
  self.hourAngleX = math.cos(math.rad(((self.hour-15)*30)))
  self.hourAngleY = math.sin(math.rad(((self.hour-15)*30)))
end
