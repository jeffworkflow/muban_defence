local mt = ac.skill['撕裂大地']
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
title = '撕裂大地',
tip = [[
    撕裂大地
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--范围
range = 1000,
area = 750,
damage = function(self)
    return self.owner:get('攻击')
end,  
-- self.owner:get('暴击加深')* 
--晕眩
stun = 1,
damage_type = '物理',
--冷却
cool = 7}
mt.effect = [[Abilities\Spells\Other\Volcano\VolcanoDeath.mdl]]
mt.effect2 = [[Abilities\Spells\Orc\EarthQuake\EarthQuakeTarget.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local target = self.target
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    ac.effect_ex
    {
        point = target,
        model = skill.effect,
        size = 2.5,
    }:remove()
    ac.effect_ex
    {
        point = target,
        model = skill.effect2,
        size = 2,
        time = 1,
    }:remove()   
    for _,u in ac.selector()
        : in_range(target,skill.area)
        : is_enemy(hero)
        : is_not(ac.main_unit)
        : ipairs()
    do
        u:add_buff '晕眩'
        {
            skill = skill,
            source = hero,
            time = skill.stun,
        }
        u:damage
        {
            source = hero,
            skill = self,
            damage = self.damage
        }
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
end