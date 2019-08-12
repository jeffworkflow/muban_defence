local mt = ac.skill['剑刃风暴']

mt{
	--必填
	is_skill = true,
	--初始等级
	level = 1,
	max_level = 5,
	damage = function(self)
		return (self.owner:get('力量')*5+10000)* self.level*5
	  end,
	  ['每秒加力量'] = {50,100,150,200,250},
	  ['攻击加力量'] = {50,100,150,200,250},
	  ['杀怪加力量'] = {50,100,150,200,250},
	tip = [[

|cffffff00【每秒加力量】+50*Lv
【攻击加力量】+50*Lv
【杀怪加力量】+50*Lv|r

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(力量*15+1w)*Lv*5|r

	]],
	--技能图标 3（40°扇形分三条，角度20%）+3+3+1+1，一共5波，
    art = [[ReplaceableTextures\CommandButtons\BTNWhirlwind.blp]],
	--技能类型
	skill_type = "主动,力量",
	--冷却时间
    cool = 15,
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 500,
	area2 = 1000,
	--持续时间
	time = 3,
	--每几秒
	pulse = 0.3,
	--特效模型
	effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],
	--冲击波
	effect1 = [[Abilities\Spells\Orc\Shockwave\ShockwaveMissile.mdl]],
	--冲击波移动距离
	distance = 500,
	--冲击波速度
	speed = 1600,
	--冲击波碰撞范围
	hit_area = 200,

	--伤害类型
	damage_type = '法术',

    -- 跟随物模型
    follow_model = [[Hero_Juggernaut_N4S_F_Source.mdx]],
    folow_model_size = 0.8,
	follow_move_skip = 10,
}

function mt:on_upgrade()
	local hero = self.owner
end

function mt:on_add()
    local skill = self
	local hero = self.owner 
	--创建一个透明的剑刃风暴 跟随英雄
	self.mvr = hero:follow{
		source = hero,
		model = self.follow_model,
		distance = 0,
		skill = self,
		on_move_skip = self.follow_move_skip,
		size = self.folow_model_size,
	}
	self.mvr.mover:setAlpha(0)
	
end	
function mt:on_cast_shot()
	local hero = self.owner
	-- hero:add_effect('origin',self.effect)
	local area = self.area
	
	if self.is_stronged then 
		area = self.area2
	end	
	self.trg = hero:add_buff '剑刃风暴' 
	{
		source = hero,
		skill = self,
		area = area,
		damage = self.damage,
		effect = self.effect,
		pulse = 0.02, --剑刃风暴 立即受伤害
		real_pulse = self.pulse,  --实际每秒受伤害
		time = self.time,
		is_stronged = self.is_stronged,   --强化标识
		effect1 = self.effect1,
		speed = self.speed,
		damage_type = self.damage_type
	}

end

function mt:on_remove()

    local hero = self.owner 
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end  
	if self.mvr then 
		self.mvr:remove()
		self.mvr = nil
	end	  

end

local mt = ac.buff['剑刃风暴']
mt.cover_type = 1
mt.cover_max = 1

function mt:on_add()
    self.eff = self.target:add_effect('origin',self.effect)
end

function mt:on_remove()
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end    
    
end

function mt:on_pulse()
	-- print('腐烂每秒伤害：',damage*self.pulse)
	self.pulse = self.real_pulse
	local skill = self.skill
	local hero = self.target
	for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:damage
		{
			source = self.source,
			damage = self.damage,
			skill = self.skill,
			damage_type = self.damage_type
		}
	end	

	--强化冲击波
	if not self.is_stronged then 
		return 
	end	

	for i = 1,3 do 
		local mvr = ac.mover.line
		{
			source = hero,
			skill = skill,
			model = skill.effect1,
			speed = skill.speed,
			angle = math.random(360),
			hit_area = skill.hit_area,
			distance = skill.distance,
			high = 50,
			size = 1,
		}
		if mvr then
			function mvr:on_hit(u)
				u:damage
				{
					source = hero,
					skill = skill,
					damage = skill.damage,
					damage_type = skill.damage_type,
				}
			end
		end
	end	
end

