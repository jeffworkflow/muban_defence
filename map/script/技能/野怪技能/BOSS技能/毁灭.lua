local mt = ac.skill['毁灭']
mt{
--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 1.5,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[ReplaceableTextures\PassiveButtons\PASBTNDevotion.blp]],
--技能说明
title = '毁灭',
tip = [[
    对'area'范围内的敌人造成伤害与晕眩
]],
--范围
area = 1000,
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '土',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 5,		},
},
--冷却
cool = 10}
mt.model = [[Abilities\Spells\Undead\Impale\ImpaleMissTarget.mdl]]
mt.model2 = [[Abilities\Spells\Undead\Impale\ImpaleHitTarget.mdl]]
mt.hit_effect = [[Abilities\Spells\Undead\OrbOfDeath\OrbOfDeathMissile.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    -- local damage_data = skill:damage_data_cal()
    
    --for i2 = 1,6 do
    --    for i = 1,5+i2 do
    --        ac.effect_ex
    --        {
    --            point =  hero:get_point() - {360/(5+i2)*i,skill.area/6*i2-50},
    --            model = skill.model,
    --            size = 2,
    --        }
    --    end
    --end
    local point = hero:get_point()
    local loc

	for i = 1 , 6 do
		for i2 = 1 , 6 do
			loc = point - {i*60, i2 * 240 }
            ac.effect_ex
            {
                point =  loc,
                model = skill.model,
                size = 2,
            }:remove()
		    for _,u in ac.selector()
		        : in_range(loc,120)
		        : is_enemy(hero)
                : is_not(ac.key_unit)
		        : ipairs()
		    do
		        u:damage
                {
                    source = hero,
                    skill = self,
                    damage = hero:get('攻击')*5
                }
		        ac.effect_ex
		        {
		            point =  u:get_point(),
		            model = skill.model2,
		            size = 1.5,
		        }:remove()
		        u:add_buff '击退'
		        {
		            skill = skill,
		            source = hero,
		            angle = hero:get_point()/u:get_point(),
		            high = 500,
		            time = 1,
		            distance = 1,
		        }
		        u:add_effect('origin',skill.hit_effect):remove()
		    end
	    end
    end
	loc = point
    ac.effect_ex
    {
        point =  loc,
        model = skill.model,
        size = 2,
    }:remove()
    for _,u in ac.selector()
        : in_range(loc,120)
        : is_enemy(hero)
        : is_not(ac.key_unit)
        : ipairs()
    do
        u:damage
        {
            source = hero,
            skill = self,
            damage = hero:get('攻击')*5
        }
        ac.effect_ex
        {
            point =  u:get_point(),
            model = skill.model2,
            size = 1.5,
        }:remove()
        u:add_buff '击退'
        {
            skill = skill,
            source = hero,
            angle = hero:get_point()/u:get_point(),
            high = 500,
            time = 1,
            distance = 1,
        }
        u:add_effect('origin',skill.hit_effect):remove()
    end
end

function mt:on_cast_start()
	local point = self.owner:get_point()
    self.eft = ac.warning_effect_ring
    {
        point = point,
        area = 120,
        time = self.cast_channel_time,
    }
	for i = 1 , 6 do

		--ac.warning_effect_rect
		--{
		--	point = point - {60*i,30},
		--	time = self.cast_channel_time,
		--	wid = 120,
		--	len = 1440,
		--	angle = 60*i,
		--}
		for i2 = 1 , 6 do
		    self.eft = ac.warning_effect_ring
		    {
		        point = point - {i*60, i2 * 240 },
		        area = 120,
		        time = self.cast_channel_time,
		    }
	    end
    end
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
end