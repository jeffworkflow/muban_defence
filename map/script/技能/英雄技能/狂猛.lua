local mt = ac.skill['狂猛']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = {15,115,215,315,500},
	--冷却时间
	cool = 10,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 战斗的怒意暂时提升自身的攻击速度（%attack_speed% %）和 移动速度（ %move_speed% % ）
	]],
	--技能图标
	art = [[jineng\jineng029.blp]],
	--特效
	effect = [[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]],
	--攻击速度
	attack_speed = {100,125,150,175,200},
	--移动速度
	move_speed = 25,
	--持续时间
	time = 15,
}
function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	self.trg = hero:add_buff '狂猛'
	{
		source = hero,
		skill = self,
		time = self.time,
		model = self.effect,
		attack_speed = self.attack_speed,
		move_speed = self.move_speed,
		value = self.attack_speed --覆盖时，优先级的判断key
	}

end

function mt:on_remove()
    local hero = self.owner 
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end  
end
local mt = ac.buff['狂猛']

mt.cover_type = 1
mt.cover_max = 1

mt.ref = 'overhead'
mt.control = 5

function mt:on_add()
	if self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
	self.target:add('攻击速度',self.attack_speed)
	self.target:add('移动速度%',self.move_speed)
end

function mt:on_remove()

	self.target:add('攻击速度',-self.attack_speed)
	self.target:add('移动速度%',-self.move_speed)

	if self.eff then
		self.eff:remove()
	end
end

function mt:on_cover(new)
	return new.value > self.value
end
