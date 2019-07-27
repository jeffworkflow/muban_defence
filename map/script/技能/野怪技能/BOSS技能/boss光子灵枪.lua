local mt = ac.skill['boss光子灵枪']
mt{--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_UNIT,
--施法信息
cast_start_time = 0,
cast_channel_time = 0,
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = 'boss阳光枪',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],

--伤害类型
damage_type = '物理',
damage = function(self)
    return self.owner:get('攻击')*0.2
end, 
--范围
range = 1500,
--伤害范围
area = 100,
--数量
num = 12,

--必填
is_skill = true,
--冷却
cool = 8}
mt.model = [[war3mapImported\[Effect]566.mdl]]
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:boss_skill_shot()
	local hero = self.owner
	local skill =self
	local target = self.target

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
                    : is_not(ac.main_unit)
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
                -- print(target,target:get_point())
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

function mt:on_cast_start()
    -- if self:is_cooling() then 
    --     return 
    -- end    
    self.eft = ac.warning_effect_ring
    {
        point = self.target:get_point(),
        area = self.area,
        time = self.cast_channel_time,
    }
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
    -- self:active_cd()
end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end