
local mt = ac.skill['流血']

mt{
    --等级
    level = 1,
    --最大等级
    max_level = 3,
	tip = [[
		|cff11ccff被动：|r
		攻击有%chance%%使敌人流血，在%time%秒内 每秒受到 %value_base%%（+%value%%/人物等级） 的武器伤害（作为物理伤害）

	]],
	
	-- 几率
	chance = {100,20,30},

	-- power
	value = {30,20,30},
	value_base = {300,20,30},

	--持续时间
	time = {5,10,15},
    --武器伤害
	weapon_damage = 30


}

-- 被动
mt.passive = true


function mt:on_add()
	
	local hero = self.owner
	local skill = self
	local base_attack = hero:get('攻击')
	local criticle_attack = true;

	self.event = hero:event '造成伤害效果' (function(trg, damage)
       
		--普攻触发
		if damage:is_common_attack()   then
            --几率触发
			if math.random(1,100) > self.chance then
				return
			end
			
	 	   damage.target:add_buff('流血')
			{
				source = hero,
				skill = skill,
				time =  skill.time,
				value = self.power,
				damage = (self.value * hero.level + self.value_base)/100 * skill.weapon_damage
			}

		end
		
	end)


	
end

function mt:on_remove()
	self.event:remove();
end

local mt = ac.dot_buff['流血']

mt.debuff = true

function mt:on_add()
	self.eff = self.target:add_effect('chest', [[Abilities\Spells\Other\BreathOfFire\BreathOfFireDamage.mdl]])
end

function mt:on_remove()
	self.eff:remove()
end

function mt:on_pulse(damage)
	self.target:damage
	{
		source = self.source,
		damage = damage * self.pulse,
		skill = self.skill,
	}
end







