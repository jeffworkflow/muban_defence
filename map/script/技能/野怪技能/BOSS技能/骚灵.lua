
local mt = ac.skill['骚灵']
mt{
--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_UNIT,
--施法信息
cast_start_time = 0,
cast_channel_time = 20,
cast_shot_time = 0,
cast_finish_time = 1,
--初始等级
level = 1,
--技能图标
art = [[ReplaceableTextures\CommandButtons\BTNCripple.blp]],
--技能说明
title = '骚灵',
tip = [[
    骚灵
]],
--消耗
cost_data = {	type = '魔法',	num_type = '三维',	rate = 0.2,},
--伤害
damage_type = '暗',
damage_data = {
	{		base = 0,		attr = '攻击',		rate = 5,		},
},
--技能前摇
warning_time = 2,
--范围
range = 100000,
--晕眩
time = 2,
--冷却
cool = 3}
mt.model = [[Abilities\Spells\Orc\HealingWave\HealingWaveTarget.mdl]]
function mt:boss_skill_shot()
    local hero = self.owner
    local skill =self
    local target = self.target
    -- local damage_data = skill:damage_data_cal()

    local mvr = ac.mover.target
    {
        source = hero,
        target = hero,
        mover = target,
        speed = 0,
        accel = 600,
        max_speed = 1500,
        skill = skill,
    }
    self.mvr = mvr
    local buff = target:add_buff '晕眩'
    {
        skill = skill,
        time = 10
    }

    function mvr:on_finish()
        if buff then
            buff:remove()
        end
        target:add_buff '晕眩'
        {
            skill = skill,
            time = skill.time
        }
        skill:stop()
    end
end


function mt:on_cast_start()
    local skill = self
    self.eft = ac.warning_lightning
    {
        hero = self.owner,
        target = self.target,
        time = self.warning_time,
    }
    self.tm = self.owner:wait(skill.warning_time*1000,function()
        skill:boss_skill_shot()
    end)
    self.buf = self.owner:add_buff '施法距离限制'
    {
    	skill = self,
    	unit = self.target,
    	range = self.range,
    }
end

function mt:on_cast_stop()
    if self.tm then
        self.tm:remove()
    end
    if self.eft then
        self.eft:remove()
    end
    if self.mvr then
        self.mvr:remove()
    end
    if self.buf then
	    self.buf:remove()
    end
end
