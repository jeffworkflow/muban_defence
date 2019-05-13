
local mt = ac.skill['光子灵枪']
mt{
	--初始等级
	level = 1,

	max_level = 5,

	--技能类型
	skill_type = "被动 敏捷",
	--技能图标
	art = [[icon\card1_30.blp]],
	--技能说明
	title = '光子灵枪',
	tip = [[
|cff11ccff%skill_type%:|r 攻击时有 %chance% % 几率召 %num% 个 %title%飞向敌人造成伤害
伤害计算：|cffd10c44敏捷 * %agi_mul%|r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r]],
	--概率%
	chance = 15,
    --伤害参数1
	agi_mul = {2.5,3,3.5,4,5},

	shanghai ={2500,25000,250000,625000,1000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('敏捷')*self.agi_mul+self.shanghai
		end	
	end	,
	--是否被动
	passive = true,
	--伤害类型
	damage_type = '物理',
	--范围
	range = 1500,
	--伤害范围
	area = 100,
	--数量
	num = 12,
	cool = 1,
	
	--必填
	is_skill = true,
}
mt.model = [[war3mapImported\[Effect]566.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target

	local speed = 1200
	local function shot2(u,u2)
		if u2 then
			local mvr = ac.mover.target
			{
				target = u2,
				start = hero:get_point(),
				mover = u,
				source = hero,
				skill = skill,
				speed = 0,
				accel = 600,
				max_speed = 2000,
				-- high = u:get_high(),
				target_high = 50,
				size = 0.5,
			}
			function mvr:on_finish()
				u.f2_effect:remove()
				u:kill()
				for _,u in ac.selector()
					: in_range(mvr.mover:get_point(),skill.area/2)
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
		else
			u.f2_effect:remove()
			u:kill()
		end
	end

	local function shot(u)
		local mvr = ac.mover.line
		{
			start = hero:get_point(),
			mover =  u,
			source = hero,
			skill = skill,
			speed = 800,
			accel = -800,
			angle = math.random(0,360),
			distance = 800/2-10,
			min_speed = 10,
			high = 70,
			target_high = math.random(300,500),
			size = 1,
		}
		function mvr:on_finish()
			u:wait(10,function()
				-- print(mvr.mover:get_high())
				-- print(u:get_high())
				if target:is_alive() then
					shot2(u,target)
				else
					shot2(u,ac.get_random_unit(u,hero,skill.range/2))
				end
			end)
		end
	end
	
	local tm = skill.num
	local timer
	timer = ac.loop(0.05*1000,function()
		local u = ac.player[16]:create_dummy('e001', hero:get_point(), 0)
		u:set_high(0)
		u.f2_effect = u:add_effect('origin', skill.model)
		shot(u)
		tm = tm -1
		if tm <= 0 then
			timer:remove()
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
