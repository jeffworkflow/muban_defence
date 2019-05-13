
local mt = ac.skill['闪电链']
mt{
	--初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "被动 智力",
	--技能图标
	art = [[icon\card1_2.blp]],
	--技能说明
	title = '闪电链',
	tip = [[
		|cff11ccff%skill_type%:|r 攻击有 %chance% % 的概率对 %area% 范围造成伤害(%damage%)
伤害计算：|cffd10c44智力 * %int%|r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12法术伤害|r
	]],
	--弹射范围(直径)
	area = 1000,
	--概率%
	chance = 15,
	int= {5,6,7,8,10},
	shanghai ={5000,50000,500000,125000,2000000},
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('智力')*self.int+self.shanghai
		end
	end	,
	--是否被动
	passive = true,
	--弹射次数
	time = 15,
	--冷却
	cool = 1,
	--是否技能
	is_skill = true,

	--伤害类型
	damage_type = '法术',
}
mt.ref = 'origin'
mt.model = [[Abilities\Weapons\Bolt\BoltImpact.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target

	local tm = skill.time+1
	local unit = hero
	local next = target
	local timer

	local function shot()
		next:add_effect(skill.ref,skill.model):remove()
		next:damage
		{
			source = hero,
			skill = skill,
			target = next,
			damage = skill.damage,
			damage_type = skill.damage_type,
		}
		--hero:add_buff '闪电链-特效'
		--{
		--	skill = skill,
		--	unit1 = unit,
		--	unit2 = next,
		--	time = 1,
		--}
		local lt = ac.lightning('LN06',unit,next,50,50)
		--local lt = ac.lightning('FFAC',unit,next,50,50)
		lt.speed = -3
		
		local group = {}
		for _,u in ac.selector()
			: in_range(hero,skill.area/2)
			: is_enemy(hero)
			: ipairs()
		do
			if u ~= next then
				table.insert(group,u)
			end
		end
		if #group > 0 then
			unit = next
			next = group[math.random(1,#group)]
		else
			timer:remove()
		end
		tm = tm - 1

		if tm <= 0 then
			timer:remove()
		end
	end
	
	timer = ac.loop(0.3*1000,function()
		shot()
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

--local mt = ac.buff['闪电链-特效']
--mt.cover_type = 1
--
--function mt:on_add()
--	--CLPB
--	--CLSB
--end
--function mt:on_remove()
--	--self.lt:remove()
--end