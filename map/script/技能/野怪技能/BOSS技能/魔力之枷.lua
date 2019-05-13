local mt = ac.skill['魔力之枷']
mt{
--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_POINT,
--施法信息
cast_start_time = 0,
cast_channel_time = 3,
cast_shot_time = 0,
cast_finish_time = 1,
--初始等级
level = 1,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNBrilliance.blp]],
--技能说明
title = '魔力之枷',
tip = [[
    魔力之枷
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '光',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 3,		},
},
--范围
range = 1000,
area = 500,
--晕眩时间
stun = 2,
stun2 = 5,
--持续时间
time = 10,
--冷却
cool = 3}
mt.model = [[Abilities\Spells\Human\MassTeleport\MassTeleportTo.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    local target = self.target
    -- local damage_data = skill:damage_data_cal()

    local dummy = ac.player[16]:create_dummy('e001', target , 0)
    --dummy:set_high(0)
    dummy.f2_effect = dummy:add_effect('origin', skill.model)

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
            damage = self.owner:get('攻击')*3
        }
        if u:is_alive() then
            local lt = ac.lightning('DRAM',dummy,u,150,80)
            u:add_buff '魔力之枷-束缚'
            {
                source = hero,
                skill = skill,
                source = source,
                time = skill.time,
                dummy = dummy,
                lt = lt,
                dis = skill.area+100,
                damage_data = damage_data,
            }
            u:add_buff '晕眩'
            {
                source = hero,
                time = skill.stun,
            }
        end
    end
    
    dummy:wait(skill.time * 1000,function()
        dummy.f2_effect:remove()
        dummy:remove()
    end)

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
end--[[  ]]

local mt = ac.buff['魔力之枷-束缚']
mt.pulse = 0.1

function mt:lt_break()
    self.target:damage
    {
        source = self.skill.owner,
        skill = self.skill,
        damage = self.skill.owner:get('攻击')*3
    }
    self.target:add_buff '晕眩'
    {
        source = self.source,
        skill = self.skill,
        time = self.skill.stun2,
    }
    self:remove()
end

function mt:on_pulse()
    if self.target:get_point() * self.dummy:get_point() > self.dis then
        self:lt_break()
    end
end

function mt:on_remove()
    if self.lt then
        self.lt:remove()
    end
end