
local mt = ac.buff['施法距离限制']
mt.pulse = 0.1
mt.range = 0

function mt:on_pulse()
	local hero = self.target
	local target = self.unit
	local range = self.range

	if hero:get_point() * target:get_point() > self.range + 300 then
		self.skill:stop()
	end
end
