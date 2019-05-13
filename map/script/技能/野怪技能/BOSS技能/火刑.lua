
local mt = ac.skill['火刑']
mt{
--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 3,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[icon\card\2\card2_9.blp]],
--技能说明
title = '火刑',
tip = [[
    召唤数个烈焰风暴
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '火',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 3,		},
},
--范围
area = 1000,
--火焰风暴伤害范围
area2 = 400,
--数量
num = 10,
--持续时间
time = 5,
--冷却
cool = 10}
mt.effect = [[Abilities\Spells\Human\FlameStrike\FlameStrike1.mdl]]
mt.effect2 = [[Abilities\Spells\Human\FlameStrike\FlameStrikeTarget.mdl]]
mt.effect3 = [[Abilities\Spells\Human\FlameStrike\FlameStrikeEmbers.mdl]]
function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    -- local damage_data = skill:damage_data_cal()

    local point_list = {}
    local effect_list = {}
    local effect_list2 = {}
    local effect_list3 = {}
    local pulse = 0.2
    
    local function fire()
        local group = {}
        for i = 1,skill.num do
            for _,u in ac.selector()
                : in_range(point_list[i],skill.area2)
                : is_enemy(hero)
                : is_not(ac.key_unit)
                : ipairs()
            do
                if not group[u] then
                    u:damage
                    {
                        source = hero,
                        skill = self,
                        damage = hero:get('攻击')*3
                    }
                    group[u] = true
                    u:add_effect('chest',[[Abilities\Weapons\LordofFlameMissile\LordofFlameMissile.mdl]]):remove()
                end
            end
        end
    end

    local timer = ac.timer(pulse*1000,skill.time/pulse,function()
        fire()
    end)

    hero:wait((skill.time+0.05)*1000,function()
        for i = 1,skill.num do
            effect_list[i]:remove()
            effect_list2[i]:remove()
            effect_list3[i]:remove()
        end
    end)

    for i = 1,skill.num do
        point_list[i] = hero:get_point() - {math.random(0,360),math.random(0,skill.area)}
        effect_list[i] = ac.effect_ex
        {
            point = point_list[i],
            model = skill.effect,
            size = skill.area2/200,
        }
        effect_list2[i] = ac.effect_ex
        {
            point = point_list[i],
            model = skill.effect2,
            size = skill.area2/250,
        }
        effect_list3[i] = ac.effect_ex
        {
            point = point_list[i],
            model = skill.effect3,
            size = skill.area2/200*4,
        }
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
end

function mt:on_remove()
end