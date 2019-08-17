
local mt = ac.buff['生命恢复效果']

mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.effect = nil
mt.ref = 'overhead'
mt.model = [[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]]

function mt:on_add()
	-- self.eff = self.target:add_effect(self.ref, self.model)

	self.target:add('生命恢复效果', self.value)
end

function mt:on_remove()
	-- self.eff:remove()
	self.target:add('生命恢复效果', -self.value)
end

function mt:on_cover(new)
	return new.value > self.value
end
