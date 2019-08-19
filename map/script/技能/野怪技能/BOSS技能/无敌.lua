local mt = ac.skill['无敌']
mt{--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_NONE,
--施法信息
cast_start_time = 0,
cast_channel_time = 0,
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '无敌',
tip = [[
    无敌
]],
force_cast=1,
--冷却
cool = 10
}

function mt:on_cast_start()
    -- if self:is_cooling() then 
    --     return 
    -- end    

end

function mt:on_cast_shot()
    local hero = self.owner
    hero:add_buff '无敌' {
        time = 3
    }
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
    -- self:active_cd()
end

function mt:on_remove()
end