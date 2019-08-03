local mt = ac.buff['减甲神符']

mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.effect = nil
mt.ref = 'origin'
mt.model = [[Abilities\Spells\Undead\UnholyAura\UnholyAura.mdl]]

function mt:on_add()
	self.effect = self.target:add_effect(self.ref, self.model)
	self.target:add('减少周围护甲', self.value)
end

function mt:on_remove()
	self.effect:remove()
	self.target:add('减少周围护甲', - self.value)
end

function mt:on_cover(new)
	return new.value > self.value
end
