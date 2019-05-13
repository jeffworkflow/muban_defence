local mt = ac.skill['大地震']
mt{--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 3,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[icon\card\2\card2_7.blp]],
--技能说明
title = '大地震',
tip = [[
    持续对%area%范围内的敌人造成伤害与晕眩
]],
--范围
area = 500,
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--持续时间
time = 3,
--减速比例%
spd_div = 50,
--次数
num = 5,
--冷却
cool = 10
}
mt.effect = [[war3mapImported\-!boom10!-.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    
    local function shot()
        ac.effect_ex
        {
            point =  hero:get_point(),
            model = skill.effect,
            size = skill.area/250,
        }:remove()
        for _,u in ac.selector()
            : in_range(hero,skill.area)
            : is_enemy(hero)
            : is_not(ac.key_unit)
            : ipairs()
        do
            u:damage
            {
                source = hero,
                skill = self,
                damage = hero:get('攻击')*1
            }
            u:add_buff '减速'
            {
                skill = skill,
                time = skill.time,
                move_speed_rate = skill.spd_div,
            }
        end
    end
    shot()
    ac.timer(1*1000,skill.num - 1,function()
        shot()
    end)
end

function mt:on_cast_start()
    self.eft = ac.warning_effect_ring
    {
        point = self.owner:get_point(),
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
end