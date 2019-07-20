
local mt = ac.skill['暴风雪']
mt{
	--必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
	--技能类型
	skill_type = "被动,智力",
	--cd
	cool = 1,
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*15+10000)* self.level
end,
	--属性加成
 ['每秒加智力'] = {50,100,150,200,250},
 ['攻击加智力'] = {50,100,150,200,250},
 ['杀怪加智力'] = {50,100,150,200,250},
	--介绍
	tip = [[
		
|cffffff00【每秒加智力】+50*Lv
【攻击加智力】+50*Lv
【杀怪加智力】+50*Lv|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(智力*15+1w)*Lv|r

]],
	--技能图标
	art = [[icon\card1_32.blp]],
	--范围
	area = 425,
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
