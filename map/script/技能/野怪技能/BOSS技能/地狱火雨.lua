
local mt = ac.skill['地狱火雨']
mt{
--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 1.2,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNInfernal.blp]],
--技能说明,
title = '地狱火雨',
tip = [[
    召唤数个地狱火
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
--范围
area = 1500,
--撞击伤害范围
area2 = 250,
--概率
num = 10,
--属性倍率%
atr_rate = 10,
--持续时间
time = 60,
--晕眩时间,
stun = 1,
--冷却
cool = 10,
}
mt.effect = [[Units\Demon\Infernal\InfernalBirth.mdl]]
mt.effect2 = [[Abilities\Spells\Undead\Impale\ImpaleHitTarget.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    
    local function raining(point)

        ac.effect_ex
        {
            model = skill.effect,
            point = point,
            size = 1.5,
            speed = 0.5,
        }:remove()
        ac.warning_effect_ring
        {
            point = point,
            area = skill.area2,
            time = 0.9 * 2,
        }

        hero:wait(0.9 * 2 * 1000,function()
            local summon = hero:create_unit('地狱火',point,math.random(1,360))
            local index = ac.creep['刷怪'].index
            if not index or index == 0 then 
                index = 1
            end	
            if index > 60 then 
                index = 60
            end   
            -- print('技能使用时 当前波数',index)
            local data = ac.table.UnitData['进攻怪-'..index] 
            
            if summon then
                summon:add_buff '召唤物' {
                    time = self.time,
                    attribute = data.attribute,
                    attr_mul = 4,
                    skill = self,
                }
                summon:set_search_range(99999)
            end

            for _,u in ac.selector()
                : in_range(point,skill.area2)
                : is_enemy(hero)
                : is_not(ac.key_unit)
                : ipairs()
            do
                u:damage
                {
                    source = hero,
                    skill = self,
                    damage = hero:get('攻击')*5,
                }
                u:add_buff '晕眩'
                {
                    source = hero,
                    time = skill.stun,
                }
            end
        end)
    end

    for i = 1,skill.num do
        raining(hero:get_point()-{math.random(0,360) , math.random(0,skill.area) })
    end
end

function mt:on_add()
	--[[ local hero = self.owner
	local skill = self
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if ac.attack_skill_rate_cal({hero = hero,skill = skill,damage = damage}) == false then return end
			skill:boss_skill_shot(damage)
	end) ]]
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

function mt:on_remove()
end