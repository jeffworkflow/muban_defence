

for key in pairs(ac.unit.attribute) do 
	local mt = ac.buff[key]
	mt.control = 2
	mt.cover_type = 1
	mt.cover_max = 1
	mt.ref = 'origin'
	mt.model = [[]]
	mt.value = 0

	function mt:on_add()
		self.effect = self.target:add_effect(self.ref, self.model)
		self.target:add(key,self.value)
	end

	function mt:on_remove()
		self.effect:remove()
		self.target:add(key,-self.value)
	end

	function mt:on_cover(new)
		return new.value > self.value
	end
end