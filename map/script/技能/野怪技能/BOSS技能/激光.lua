
local mt = ac.skill['激光']
mt{
--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_UNIT,
--施法信息
cast_start_time = 0,
cast_channel_time = 3,
cast_shot_time = 0,
cast_finish_time = 1,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_4.blp]],
--技能说明
title = '激光',
tip = [[
    能够使敌人致盲
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
--数量
num = 10,
--致盲
time = 3,
--冷却
cool = 3
}
mt.model = [[Abilities\Spells\Orc\HealingWave\HealingWaveTarget.mdl]]
function mt:boss_skill_shot()
    local hero = self.owner
    local skill =self
    local target = self.target
    -- local damage_data = skill:damage_data_cal()

    local tm = skill.num + 1
    local unit = hero
    local next = target
    local timer
    local group = {}

    local function shot()
        next:add_effect(skill.ref,skill.model):remove()
        group[next] = true
        next:damage
        {
            source = hero,
            skill = self,
            damage = hero:get('攻击')*10
        }
        next:add_buff '激光-致盲'
        {
            skill = skill,
            source = hero,
            time = skill.time,
        }
        --hero:add_buff '闪电链-特效'
        --{
        --	skill = skill,
        --	unit1 = unit,
        --	unit2 = next,
        --	time = 1,
        --}
        local lt = ac.lightning('FFAA',unit,next,50,50)
		lt:setColor(70,70,100)
        lt.speed = -2
        
        local group = {}
        for _,u in ac.selector()
            : in_range(hero,skill.range/2)
            : is_enemy(hero)
            : is_not(ac.key_unit)
            : ipairs()
        do
            if u ~= next and not group[u] then
                table.insert(group,u)
            end
        end
        if #group > 0 then
            unit = next
            next = group[math.random(1,#group)]
        else
            timer:remove()
        end
        tm = tm - 1

        if tm <= 0 then
            timer:remove()
        end
    end

    timer = ac.loop(0.05*1000,function()
        shot()
    end)
end

function mt:on_cast_start()
    self.eft = ac.warning_lightning
    {
        hero = self.owner,
        target = self.target,
        time = self.cast_channel_time,
    }
    self.buf = self.owner:add_buff '施法距离限制'
    {
    	skill = self,
    	unit = self.target,
    	range = self.range,
    }
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
    if self.buf then
	    self.buf:remove()
    end
end

function mt:on_remove()
end


local mt = ac.buff['激光-致盲']
-- mt.effect_data = {
--     ['head'] = [[Abilities\Spells\NightElf\Barkskin\BarkSkinTarget.mdl]]
-- }

function mt:on_add()
    local target = self.target
    target:add_effect('head',[[Abilities\Spells\NightElf\Barkskin\BarkSkinTarget.mdl]])
    self.trg = target:event '造成伤害开始'(function(_,damage)
        if not damage:is_common_attack() then return end
        return true
    end)
end

function mt:on_remove()
    if self.trg then
        self.trg:remove()
    end
end
