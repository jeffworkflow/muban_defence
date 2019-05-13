
local mt = ac.skill['暴风雪']
mt{
	
	--必填
	is_skill = true,
	--技能类型
	skill_type = "被动 智力",
	--初始等级
	level = 1,
	max_level = 5,
	--技能图标
	art = [[icon\card1_32.blp]],
	--技能说明
	title = '暴风雪',
	tip = [[
|cff11ccff%skill_type%:|r 攻击有 %chance% % 的概率对 %area% 范围造成伤害 (%damage%)
伤害计算：|cffd10c44 智力 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12法术伤害|r
]],
	--范围
	area = 425,
	--概率%
	chance = 15,
	--cd
	cool = 1,

	int ={5,6,7,8,10},

	shanghai ={5000,50000,500000,125000,2000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('智力')*self.int+self.shanghai
		end	
	end	,
	--是否被动
	passive = true,
	--伤害类型
	damage_type = '法术',
}
mt.model = [[Abilities\Spells\Human\Blizzard\BlizzardTarget.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local point = target:get_point()
	local num = math.modf(skill.area/2)
	for i = 1 , 20 do
		ac.point_effect(point - {math.random(1,360),math.random(30,num)},{model = skill.model} ):remove()
	end
	hero:wait(0.85*1000,function()
		for _,u in ac.selector()
			: in_range(point,num)
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
			u:add_effect('chest',[[Abilities\Spells\Other\FrostDamage\FrostDamage.mdl]]):remove()
			--skill:damage
			--{
			--	source = hero,
			--	target = u,
			--	damage = damage_data.damage,
			--	damage_type = '魔法',--damage_data.damage_type,
			--}
		end
	end)
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
