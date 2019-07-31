
local mt = ac.skill['炎爆术']
mt{ 
	--必填
	is_skill = true,
	--初始等级
	level = 1,
	--最大等级
	max_level = 5,
	--触发几率
	chance = function(self) return (self.level+5)*(1+self.owner:get('触发概率加成')/100) end,
	--伤害范围
	damage_area = 500,
	--技能类型
	skill_type = "被动,力量",
	--被动
	passive = true,
	--cd
	cool = 1,
	--伤害
	damage = function(self)
	return (self.owner:get('力量')*15+10000)* self.level
	end,
	--属性加成
	['杀怪加力量'] = {75,150,225,300,375},
	--介绍
	tip = [[
		
|cffffff00【杀怪加力量】+75*Lv|r

|cff00bdec【被动效果】攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(力量*15+1w)*Lv|r
	
]],
	--技能图标
	art = [[ybs.blp]],
	--范围
	area = 1000,
	--是否被动
	passive = true,
	damage_type = '法术'

}
mt.model = [[war3mapimported\!huobao.mdx]]
mt.effect = [[Abilities\Weapons\PhoenixMissile\Phoenix_Missile.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	
	local mvr = ac.mover.target
	{
		source = hero,
		target = target,
		skill = skill,
		model = skill.effect,
		speed = 900,
		high = 120,
		size = 1,
	}
	if mvr then
		function mvr:on_finish()
			-- ac.effect_area(30,mvr.mover:get_point(),skill.area, 2, skill.model)
			ac.effect_ex
			{
				point = mvr.mover:get_point(),
				model = skill.model,
				size = skill.area/512,
				speed = 2,
			}:remove()
			for _,u in ac.selector()
				: in_range(mvr.mover:get_point(),skill.area)
				: is_enemy(hero)
				: ipairs()
			do
				u:damage
				{
					source = hero,
					skill = skill,
					target = u,
					damage = skill.damage,
					damage_type = skill.damage_type,
				}
			end
		end
	end
end
	
function mt:on_add()
	local hero = self.owner
	local skill = self
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
	
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
		local rand = math.random(1,100)
		if rand <= self.chance then 
			skill:atk_pas_shot(damage)
            --激活cd
            skill:active_cd()
		end
	end)
end

function mt:on_remove()
	if self.trg then
		self.trg:remove()
	end
end
