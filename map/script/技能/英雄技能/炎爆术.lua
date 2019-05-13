
local mt = ac.skill['炎爆术']
mt{
	
	--必填
	is_skill = true,
	--技能类型
	skill_type = "被动 力量",
	--初始等级
	level = 1,
	max_level = 5,
	--技能图标
	art = [[icon\card2_13.blp]],
	--技能说明
	title = '炎爆术',
	tip = [[
|cff11ccff%skill_type%:|r 攻击有 %chance% % 的概率对 %area% 范围造成伤害  (%damage%)
伤害计算：|cffd10c44力量 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r
]],
	--范围
	area = 1000,
	--概率%
	chance = 15,
	--cd
	cool = 1,

	int = {5,6,7,8,10},

	shanghai ={5000,50000,500000,125000,2000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('力量')*self.int+self.shanghai
		end
	end	,
	--是否被动
	passive = true,
	--冷却
	cool = 1

}
mt.model = [[war3mapimported\!huobao.mdx]]
mt.model2 = [[Abilities\Weapons\PhoenixMissile\Phoenix_Missile.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	
	local mvr = ac.mover.target
	{
		source = hero,
		target = target,
		skill = skill,
		model = skill.model2,
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
