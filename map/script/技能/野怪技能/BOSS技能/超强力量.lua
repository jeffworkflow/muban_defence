
local mt = ac.skill['超强力量']
mt{
--初始等级
level = 1,
--施法信息
cast_start_time = 0,
cast_channel_time = 3,
cast_shot_time = 0,
cast_finish_time = 1,
--技能图标
art = [[icon\card\2\card2_8.blp]],
--技能说明
title = '超强力量',
tip = [[
    我就是这么屌
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--次数
num = 10,
--持续时间
time = 10,
--冷却
cool = 10,
}
mt.model = [[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]]

function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self

    hero:add_buff '超强力量-BUFF'
    {
        skill = skill,
        time = skill.time,
        num = skill.num, 
    }
end

function mt:on_add()
end

function mt:on_remove()
end

function mt:on_cast_shot()
    self:boss_skill_shot()
    
end


local  mt = ac.buff['超强力量-BUFF']
mt.effect_data = {
    ['head'] = [[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]],
    ['hand,right'] = [[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]],
    ['hand,left'] = [[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]],

}
mt.spd = 400

function mt:on_add()
    local hero = self.target
    local skill = self.skill
    local tm = self.num
    self.eff1 = hero:add_effect('head',[[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]])
    self.eff2 = hero:add_effect('hand,right',[[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]])
    self.eff3 = hero:add_effect('hand,left',[[Abilities\Spells\Orc\TrollBerserk\HeadhunterWEAPONSLeft.mdl]])

    local buff = self
    hero:add('攻击速度',buff.spd)
    self.trg = hero:event '单位-攻击开始' (function()
        tm = tm - 1
        if tm <= 0 then
            buff:remove()
        end
    end)
end

function mt:on_remove()
    if self.trg then
        self.trg:remove()
    end
    if self.eff1 then  self.eff1:remove() self.eff1 = nil end 
    if self.eff2 then  self.eff2:remove() self.eff2 = nil end 
    if self.eff3 then  self.eff3:remove() self.eff3 = nil end 
    self.target:add('攻击速度', -self.spd)
end
