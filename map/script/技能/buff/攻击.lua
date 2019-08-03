local mt = ac.buff['攻击']

mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.effect = nil
mt.ref = 'overhead'
mt.model = [[Abilities\Spells\NightElf\BattleRoar\RoarCaster.mdl]]

function mt:on_add()
	self.effect = self.target:add_effect(self.ref, self.model)
	self.target:add('攻击', self.value)
end

function mt:on_remove()
	self.effect:remove()
	self.target:add('攻击', - self.value)
end

function mt:on_cover(new)
	return new.value > self.value
end
