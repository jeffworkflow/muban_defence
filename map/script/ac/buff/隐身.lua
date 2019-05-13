local mt = ac.buff['隐身']

mt.cover_type = 1
mt.cover_max = 1

mt.buff = true
mt.remove_when_attack = false
mt.remove_when_spell = false
mt.trg_attack = nil
mt.trg_spell = nil

function mt:on_add()
	self.target:add_restriction '隐身'
	--变透明
	self.target:setAlpha(30)
	if self.remove_when_attack then
		self.trg_attack = self.target:event '单位-攻击出手' (function()
			self:remove()
		end)
	end
	if self.remove_when_spell then
		self.trg_spell = self.target:event '技能-施法开始' (function()
			self:remove()
		end)
	end
	--增加移动速度
	if self.move_speed then 
		self.target:add('移动速度',self.move_speed)
	end	
end

function mt:on_remove()
	self.target:remove_restriction '隐身'
	if self.trg_attack then
		self.trg_attack:remove()
	end
	if self.trg_spell then
		self.trg_spell:remove()
	end
	--增加移动速度
	if self.move_speed then 
		self.target:add('移动速度',-self.move_speed)
	end	
	--变透明
	self.target:setAlpha(100)
end

function mt:on_cover(dest)
	--更改原来buff的持续时间
	if dest.time > self:get_remaining() then
		self:set_remaining(dest.time)
	end
	return false
end
