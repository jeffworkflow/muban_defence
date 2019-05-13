local mt = ac.buff['无敌']

mt.cover_type = 1
mt.model =[[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]]
mt.ref = 'origin'
mt.eff = nil
mt.debuff = true
mt.control = 5

function mt:on_add()
	self.target:add_restriction '无敌'
	if self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
end

function mt:on_remove()
	if self.eff then
		self.eff:remove()
	end
	self.target:remove_restriction '无敌'
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
