local mt = ac.skill['洪流']
mt{
--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_POINT,
--施法信息
cast_start_time = 0,
cast_channel_time = 1,
cast_shot_time = 0,
cast_finish_time = 1,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_5.blp]],
--技能说明
title = '洪流',
tip = [[
    洪流
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '水',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 4,		},
},
--范围
range = 1000,
area = 500,
--致盲
stun = 2,
--冷却
cool = 3,
}
mt.effect = [[war3mapImported\t_shuibao.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    local target = self.target
    -- local damage_data = skill:damage_data_cal()

    ac.effect_ex
    {
        point = target,
        model =  skill.effect,
        time = 1,
        size = skill.area/256,
    }:remove()

    for _,u in ac.selector()
        : in_range(target,skill.area)
        : is_enemy(hero)
        : is_not(ac.key_unit)
        : ipairs()
    do
        u:damage
        {
            source = hero,
            skill = self,
            damage = hero:get('攻击')*10
        }
        u:add_buff '击退'
        {
            source = hero,
            high = 600,
            distance = 100,
            time = 2,
            angle = target:get_point() / u:get_point(),
        }
    end

end

function mt:on_cast_start()
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
end

function mt:on_remove()
end