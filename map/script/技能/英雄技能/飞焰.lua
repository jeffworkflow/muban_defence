
local mt = ac.skill['飞焰']
mt{
	
	--初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "被动 智力",
	--技能图标
	art = [[icon\card2_61.blp]],
	--技能说明
	title = '|cff00bdec飞焰|r',
	tip = [[
|cff11ccff%skill_type%:|r 攻击有%chance% % 的概率召 %num% 个 %title% 对敌人造成伤害(%damage%)
伤害计算：|cffd10c44智力 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12法术伤害|r
	]],
	--概率%
	chance = 15,
	int = {5,6,7,8,10},
	shanghai ={5000,50000,500000,125000,2000000},
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('智力')*self.int+self.shanghai
		end
	end	,
	--是否被动
	passive = true,
	--范围
	range = 1500,
	--伤害范围
	area = 75,
	--数量
	num = 20,
	--冷却
	cool = 1,
	
	--伤害类型
	damage_type = '法术',

	--必填
	is_skill = true,
}
mt.model = [[Abilities\Weapons\PhoenixMissile\Phoenix_Missile_mini.mdl]]

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local ang = hero:get_point()/target:get_point()

	local speed = 1200
	
	local function shot(u)
		local mover = u
		local mvr = ac.mover.line
		{
			start = hero:get_point(),
			mover =  u,
			source = hero,
			skill = skill,
			speed = 500,
			accel = -500,
			angle = math.random(0,360),
			distance = math.random(100,200),
			min_speed = 10,
			high = 70,
			size = 1,
		}
		function mvr:on_finish()
			local mvr2 = ac.mover.line
			{
				start = u:get_point(),
				mover =  u,
				source = hero,
				skill = skill,
				speed = 500,
				accel = 500,
				angle = ang+math.random(-30,30),
				distance = skill.range,
				hit_area = 70,
				high = 70,
				size = 1,
			}

			function mvr2:on_hit(hit)
				for _,u in ac.selector()
					: in_range(hit:get_point(),skill.area/2)
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
				mvr2:remove()
			end

			local function destroy()
				u.f2_effect:remove()
				u:kill()
			end
			
			function mvr2:on_remove()
				destroy()
			end

			function mvr2:on_finish()
				destroy()
			end
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
