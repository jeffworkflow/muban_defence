local mt = ac.skill['疾步风']
mt{
     --必填
	 is_skill = true,
	 --初始等级
	 level = 1,
	 --最大等级
	max_level = 5,
	 --触发几率
	chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
	 --伤害范围
	damage_area = 500,
	 --技能类型
	 skill_type = "主动,隐身",
	 --耗蓝
	 cost = 100,
	 --冷却时间
	 cool = 20,
	 --介绍
	 tip = [[
		 
|cff00bdec【主动施放】让自己隐身，并提高150移动速度
【持续时间】（1+1*Lv）秒|r
 
]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNWindWalkOn.blp]],
	--隐身时间
	stand_time = {2,3,4,5,6},
	--移动速度
	move_speed = 150
}
	
function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local player = hero:get_owner()
	self.buff = hero:add_buff '疾步风' {
		time = self.stand_time,
		move_speed = self.move_speed
	}


end

function mt:on_remove()

    local hero = self.owner 
	--移除
    if self.buff then
        self.buff:remove()
        self.buff = nil
	end  
	
end

local mt = ac.buff['疾步风']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
	local hero = self.target
	--变透明
	self.target:setAlpha(30)
	--变无敌
	self.target:add_restriction '无敌'
	--加移动速度
	self.target:add('移动速度',self.move_speed)
end

function mt:on_remove()
    local target = self.target 
	--变透明
	self.target:setAlpha(100) 
	self.target:remove_restriction '无敌'
	self.target:add('移动速度',-self.move_speed)
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
