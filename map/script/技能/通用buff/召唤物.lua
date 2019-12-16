local jass = require 'jass.common'
local mt = ac.buff['召唤物']

mt.cover_type = 1
mt.cover_max = 1
mt.remove_target = false
mt.dead_event = false
mt.search_area = 600
mt.ref = 'origin'

function mt:on_add()
	local player = self.target:get_owner()
	self.old_model = self.target:get_slk 'file'
	self.old_size = self.target:get_size()
	--单位类型
	self.old_unit_type = self.target.unit_type

	self.target.unit_type = '召唤物'
	if not getextension(self.old_model) then 
		self.old_model = self.old_model..'.mdl'
	end	
	--改变模型
	if self.model then
		japi.SetUnitModel(self.target.handle,self.model)
	end
	--设置模型大小
	if self.size then
		self.target:set_size(self.size)
    end
    --设置属性
	if self.attribute then
		for k, v in sortpairs(self.attribute) do
			local val = v
			if type(v) == 'function' then 
				val = v()
			end	
			self.target:set(k, val)
		end
	end
	--调整属性加成
	if self.attribute then 
		local hero = player.hero
		local attr_mul = self.attr_mul or 0
		if not hero then 
			self.attr_mul = attr_mul 
		else
			self.attr_mul =  hero:get('召唤物属性') + attr_mul
		end	

		if self.attr_mul then 
			for k, v in sortpairs(self.attribute) do
				if not finds(k,'移动速度','攻击间隔') then
					self.target:add(k..'%', self.attr_mul)
				end	
			end
		end	
	end	


	if self.follow == true then
		self.target:add_buff '召唤物跟随'
		{
			hero = player.hero,
			skill = self.skill,
			search_area = self.search_area
		}
	end

	self.target:add_buff '镜像特效'
	{
		skill = self.skill,
	}
	-- print('添加水元素',self.time)
	--设置水元素类型的生命周期
	-- @目标handle，水元素类型，持续时间
	jass.UnitApplyTimedLife(self.target.handle,base.string2id('BHwe'),self.time+0.1)

end
function mt:on_remove()
    if self.effect then 
        self.effect:remove()
	end   
	-- print('buff移除')
	--还原单位类型
	self.target.unit_type = self.old_unit_type
	--暂停生命周期
	jass.UnitPauseTimedLife(self.target.handle,true)  
	jass.UnitApplyTimedLife(self.target.handle,base.string2id('BHwe'),0)
	--移除水元素技能
	-- self.target:remove_ability 'BHwe'
	-- 召唤物 buff 移除时 ，移除召唤物 ， 不受单位死亡事件
	if self.remove_target then 
		if self.dead_event then 
			self.target:kill()
		else	
			self.target:remove()
		end	
	else
		--还回模型
		if self.model then
			japi.SetUnitModel(self.target.handle,self.old_model)
		end	
		self.target:set_size(self.old_size)
		--还原属性
		if self.attr_mul then 
			for k, v in sortpairs(self.attribute) do
				if not finds(k,'移动速度','攻击间隔') then
					self.target:add(k..'%', -self.attr_mul)
				end	
			end
		end	
	end		
end
function mt:on_pulse()
    --设置属性
	if self.attribute then
		for k, v in sortpairs(self.attribute) do
			local val = v
			if type(v) == 'function' then 
				val = v()
				self.target:set(k, val)
			end	
		end
	end
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
		--设置水元素类型的生命周期
		-- @目标handle，水元素类型，持续时间
		--暂停再设置
		jass.UnitPauseTimedLife(self.target.handle,true)  
		jass.UnitApplyTimedLife(self.target.handle,base.string2id('BHwe'),new.time+0.1)
	end
	return false
end


local mt = ac.buff['召唤物跟随']
mt.pulse = 2
function mt:on_add()
end	
function mt:on_pulse()
	local target = self.target
	local hero = self.hero
	local point = hero:get_point() - {math.random(0,360),math.random(100,300)}
	if target:get_point() * hero:get_point() >1500 then 
		
		target:add_buff '淡化*改'
		{
			source_alpha = 0,
			target_alpha = 100,
			time = 0.5,
			remove_when_hit = false,
			
		}
		target:blink(hero:get_point())
	end 	
	target:issue_order('attack',point)
	
end