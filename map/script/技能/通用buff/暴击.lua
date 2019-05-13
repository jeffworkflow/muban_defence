local mt = ac.buff['暴击']

mt.control = 2
mt.cover_type = 1
mt.cover_max = 1
mt.effect = nil
mt.ref = 'origin'
mt.model = [[]]

function mt:on_add()
	self.effect = self.target:add_effect(self.ref, self.model)

	self.target:add('物爆几率', self.value)
	self.target:add('法爆几率', self.value)
	self.target:add('会心几率', self.value)
end

function mt:on_remove()
	self.effect:remove()
	self.target:add('物爆几率', - self.value)
	self.target:add('法爆几率', - self.value)
	self.target:add('会心几率', - self.value)
end

function mt:on_cover(new)
	return new.value > self.value
end
