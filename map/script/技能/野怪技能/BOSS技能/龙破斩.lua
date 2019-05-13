
local mt = ac.skill['龙破斩']
mt{
--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_UNIT,
--施法信息
cast_start_time = 0,
cast_channel_time = 2,
cast_shot_time = 0,
cast_finish_time = 1,
--初始等级
level = 1,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNSearingArrowsOn.blp]],
--技能说明
title = '龙破斩',
tip = [[
    龙破斩
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '光',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 10,		},
},
--范围
range = 1000,
--数量
num = 10,
--致盲
time = 3,
--冷却
cool = 3,
}
function mt:boss_skill_shot()
    local hero = self.owner
    local skill = self
    local target = self.target
    -- local damage_data = skill:damage_data_cal()
    
    local lt = ac.lightning('CLPB',hero,target,50,50)
    lt.speed = -4

    target:damage
    {
        source = hero,
        skill = self,
        damage = self.owner:get('攻击')*10
    }

end

function mt:on_cast_start()
    self.eft = ac.warning_lightning
    {
        hero = self.owner,
        target = self.target,
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
