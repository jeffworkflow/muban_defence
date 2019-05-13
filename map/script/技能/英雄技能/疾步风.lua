local mt = ac.skill['疾步风']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "增益",
	--耗蓝
	cost = {100,150,300,450,500},
	--冷却时间 45
	cool = 20,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 
	隐形并增加150的移动速度，持续 %stand_time% 秒
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNWindWalkOn.blp]],
	--无敌时间
	stand_time = {3,4,5,6,7},
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
	self.buff = hero:add_buff '隐身' {
		time = self.stand_time,
		-- remove_when_attack = true,
		-- remove_when_spell = true,
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