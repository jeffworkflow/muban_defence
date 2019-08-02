local mt = ac.skill['伤害守卫']
mt{--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_POINT,
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
title = '伤害守卫',
tip = [[
    伤害守卫 每秒流失10%*游戏难度的血量，持续5秒
]],
--范围
range = 1000,
area = 500,
time = 5,
pulse_time = 0.1,
value  = 10,
--冷却
cool = 8}
mt.effect = [[AZ_LCDark_D_Flag.mdx]]
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:boss_skill_shot()
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local target = self.target

	self.eff = ac.effect(target:get_point(),skill.effect,270,1.5,'origin')
	-- self.eff2 = ac.effect(target:get_point(),skill.effect1,270,0.8,'origin') 
	--计时器
	self.trg = hero:timer(self.pulse_time * 1000,math.floor(self.time/self.pulse_time),function()
		for i, u in ac.selector()
        : in_range(target,skill.area)
        : is_enemy(hero)
        : is_not(ac.main_unit)
        : ipairs()
		do 
            u:damage
            {
                source = hero,
                skill = self,
                damage = u:get('生命上限') * self.value * self.pulse_time*(ac.g_game_degree_attr or 1) /100,
                real_damage = true

            }
		end	

	end)
	function self.trg:on_timeout()
		if skill.eff then
			skill.eff:remove()
			skill.eff = nil
		end
		if skill.eff2 then
			skill.eff2:remove()
			skill.eff2 = nil
		end
	end
end

function mt:on_cast_start()
    -- if self:is_cooling() then 
    --     return 
    -- end    
    self.eft = ac.warning_effect_ring
    {
        point = self.target,
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