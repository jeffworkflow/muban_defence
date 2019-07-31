
local mt = ac.skill['火焰雨']
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
	skill_type = "被动,智力",
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*15+10000)* self.level
end,
	--属性加成
 ['每秒加智力'] = {500,1000,1500,2000,2500},
	--介绍
	tip = [[
		
|cffffff00【每秒加智力】+500*Lv

|cff00bdec【被动效果】攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(智力*15+1w)*Lv

]],

	--技能图标
	art = [[icon\card1_9.blp]],
	--范围
	area = 1500,
	--cd
	cool = 1,
	--伤害类型
	damage_type = '法术',
	--波次
	tm = 1
}
mt.model = [[Abilities\Spells\Demon\RainOfFire\RainOfFireTarget.mdl]]
mt.effect = [[Abilities\Weapons\FireBallMissile\FireBallMissile.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local point = target:get_point()
	
	local tm = 0
	local timer

	local function raining()
		for i = 1 , 10 do
			ac.effect_ex
			{
				point = point - {math.random(1,360),math.random(30,skill.area/2)},
				model = skill.model,
				size = 0.7
			}:remove()
		end
		hero:wait(0.85*1000,function()
			for _,u in ac.selector()
				: in_range(point,skill.area/2)
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
				u:add_effect('chest',skill.effect):remove()
			end
		end)
	end

	raining()
	timer = ac.loop(1*1000,function()
		tm = tm + 1
		if tm == skill.tm then
			timer:remove()
		end
		raining()
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
