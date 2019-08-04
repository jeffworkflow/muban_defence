
--------个人评论次数和奖励---------------------
local mt = ac.skill['难度礼包']
mt{
--等级
level = 1,
--图标
art = [[pllb.blp]],
--说明
tip = [[ 
|cffffE799【难度礼包】|r 奖励 
|cffff0000【每秒加护甲】|cff00ffff+0.1*地图等级*游戏难度
 ]],
['每秒加护甲'] = function(self)
    local p = self.owner:get_owner()
    local value = 0.1
    local map_level = p:Map_GetMapLevel()
    return value * map_level* (ac.g_game_degree_attr or 1)
end,
}

ac.game:event '玩家-注册英雄后' (function(_, _, hero)
    hero:add_skill('难度礼包','隐藏')
end)

