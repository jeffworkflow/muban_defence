local mt = ac.skill['酒桶']
mt{--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_NONE,
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
title = '酒桶',
tip = [[
    酒桶
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--范围
area = 1000, 
value  = 40,
per_value = 4, --每层+10
--持续时间
time = 5,
speed = 800,
--冷却
cool = 2}
mt.effect = [[Hero_Tusk_N2S_W_Walk.mdx]]

function mt:boss_skill_shot()
    local hero = self.owner
    local target = self.target
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    for _,u in ac.selector()
        : in_range(hero,skill.area)
        : is_enemy(hero)
        : is_not(ac.main_unit)
        : is_type('英雄')
        : random_int(1)
    do
        -- 运动
        local mvr = ac.mover.target
        {
            source = hero,
            target = u,
            model = skill.effect,
            speed = skill.speed,
            height = 110,
            skill = skill,
        }
        if not mvr then
            return
        end
        function mvr:on_finish()
            -- local value = u:find_buff('酒桶') and skill.per_value or skill.value
            -- print(skill:get_stack())
            u:add_buff '酒桶'
            {
                skill = skill,
                source = hero,
                move_speed_rate = skill:get_stack() * skill.per_value + skill.value,
                time = skill.time,
            }
        end   
    end 
end

function mt:on_cast_start()
    -- if self:is_cooling() then 
    --     return 
    -- end    
    -- self.eft = ac.warning_effect_ring
    -- {
    --     point = self.target,
    --     area = self.area,
    --     time = self.cast_channel_time,
    -- }
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
end


local mt = ac.buff['酒桶']
mt.cover_type = 0 --独占型
mt.ref = 'origin'
mt.model = [[Abilities\Spells\Human\slow\slowtarget.mdl]]

function mt:on_add()
	self.skill:add_stack(1)
	self.effect = self.target:add_effect(self.ref, self.model)
	self.target:add('移动速度%', - self.move_speed_rate)
end

function mt:on_remove()
	self.skill:set_stack(0)
	self.effect:remove()
	self.target:add('移动速度%', self.move_speed_rate)
end

--
function mt:on_cover(new)
    if new.move_speed_rate > self.move_speed_rate then 
        self.skill:add_stack(1)
        self.target:add('移动速度%', - (new.move_speed_rate - self.move_speed_rate))

        self.move_speed_rate = new.move_speed_rate
        self:set_remaining(new.time)
    end    
	return false
end