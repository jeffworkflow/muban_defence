local mt = ac.skill['血之祭祀']
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
art = [[icon\card\2\card2_2.blp]],
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
--沉默时间
time = 5,
--冷却
cool = 3}
mt.effect = [[Abilities\Spells\Undead\VampiricAura\VampiricAura.mdl]]
mt.effect2 = [[Objects\Spawnmodels\Critters\Albatross\CritterBloodAlbatross.mdl]]
mt.effect3 = [[war3mapimported\leoricvampiricaura.mdl]]
function mt:on_add()
end

function mt:on_remove()
end

function mt:boss_skill_shot()
    local hero = self.owner
    local target = self.target
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    ac.effect_ex
    {
        point = target,
        model = skill.effect2,
        size = 2.5,
    }:remove()
    for _,u in ac.selector()
        : in_range(target,skill.area)
        : is_enemy(hero)
        : is_not(ac.key_unit)
        : ipairs()
    do
        u:add_buff '沉默'
        {
            skill = skill,
            source = hero,
            time = skill.time,
        }
        u:damage
        {
            source = hero,
            skill = self,
            damage = hero:get('攻击')*3
        }
        u:add_effect('chest',skill.effect2):remove()
    end
end

function mt:on_cast_start()
    self.eft = ac.warning_effect_ring
    {
        point = self.target,
        area = self.area,
        time = self.cast_channel_time,
    }
    self.eft2 = ac.effect_ex
    {
        model = self.effect3,
        point = self.target,
        size = self.area/80,
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
    if self.eft2 then
        self.eft2:remove()
    end
end

function mt:on_remove()
end