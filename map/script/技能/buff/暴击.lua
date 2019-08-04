local mt = ac.buff['暴击']

mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.effect = nil
mt.ref = 'overhead'
mt.model = [[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]]
mt.mul = 1

function mt:on_add()
	self.effect = self.target:add_effect(self.ref, self.model)

	self.target:add('暴击几率%', self.mul*100)
	self.target:add('技暴几率%', self.mul*100)
end

function mt:on_remove()
	self.effect:remove()
	self.target:add('暴击几率%', -self.mul*100)
	self.target:add('技暴几率%', -self.mul*100)
end

function mt:on_cover(new)
	return new.mul > self.mul
end
