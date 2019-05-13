local mt = ac.skill['雷击']
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
art = [[icon\card\2\card2_1.blp]],
--技能说明
title = '雷击',
tip = [[
    雷击
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '光',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 5,		},
},
--范围
range = 1000,
area = 500,
--致盲,,
stun = 2,
--冷却
cool = 3,
}
mt.effect = [[Abilities\Spells\Other\Monsoon\MonsoonBoltTarget.mdl]]
mt.effect2 = [[Abilities\Spells\Human\Thunderclap\ThunderClapCaster.mdl]]
mt.effect3 = [[Abilities\Weapons\ChimaeraLightningMissile\ChimaeraLightningMissile.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    local target = self.target
    -- local damage_data = skill:damage_data_cal()

    ac.effect_ex
    {
        point = target,
        model =  skill.effect,
        size = 2,
    }:remove()
    ac.effect_ex
    {
        point = target,
        model =  skill.effect2,
        size = skill.area/200,
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
        u:add_effect('chest',skill.effect3):remove()
        --[[ u:add_buff '击退'
        {
            source = hero,
            high = 600,
            distance = 100,
            time = 2,
            angle = target:get_point() / u:get_point(),
        } ]]
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
end--[[  ]]