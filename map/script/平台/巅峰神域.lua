local jass = require 'jass.common'
local mt = ac.skill['巅峰神域']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[dfsy.blp]],
    title = '巅峰神域',
    tip = [[

点击查看 |cff00ffff巅峰神域|r
    ]],
    
}
mt.skills = {
    '游戏说明','礼包','称号','武器','翅膀','神圣领域','英雄','全服奖励'
} 
-- function mt:on_add()
--     local hero = self.owner 
--     local player = hero:get_owner()
--     -- print('打开魔法书')
--     for index,skill in ipairs(self.skill_book) do 
--         local has_mall = player.mall[skill.name] or (player.cus_server and player.cus_server[skill.name])
--         -- print(skill.name,'所需地图等级',ac.server.need_map_level[skill.name]) and player:Map_GetMapLevel() >= (ac.server.need_map_level[skill.name]  or 0) 
--         if has_mall and has_mall > 0 then 
--             skill:set_level(1)
--         end
--     end 
-- end  

local mt = ac.skill['游戏说明']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yxsm.blp]],
    title = '游戏说明',
    tip = [[

查看游戏说明
    ]],
}
mt.skills = {
    '游戏难度说明','地图等级说明','地图等级','挖宝积分说明','勇士徽章说明','神龙碎片说明','宠物天赋说明'
}

local mt = ac.skill['礼包']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sffl.blp]],
    title = '礼包',
    tip = [[

查看礼包
    ]],
    
}
mt.skills = {
    '群号礼包','五星好评礼包','金币礼包','木材礼包','首充','寻宝小飞侠','神仙水','永久赞助','永久超级赞助','神装大礼包','神技大礼包'
}

local mt = ac.skill['首充']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sffl.blp]],
    title = '首充',
    tip = [[

查看首充
    ]],
    
}
mt.skills = {
    '限量首充','首充大礼包'
}

local mt = ac.skill['武器']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[wuqi11.blp]],
    title = '武器',
    tip = [[

查看武器
    ]],
    
}
mt.skills = {
    '霸王莲龙锤','惊虹奔雷剑','幻海雪饮剑','紫色哀伤','霜之哀伤','皇帝剑','皇帝刀'
}

local mt = ac.skill['翅膀']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[chibang8.blp]],
    title = '翅膀',
    tip = [[

查看翅膀
    ]],
    
}
mt.skills = {
    '梦蝶仙翼','玄羽绣云翼','天罡苍羽翼','白龙凝酥翼','天使之光','绝世阳炎翼','轮迴幻魔翼'
}

local mt = ac.skill['称号']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[wzgl1.blp]],
    title = '称号',
    tip = [[

查看称号
    ]],
    
}
mt.skills = {
    '炉火纯青','势不可挡','毁天灭地','风驰电掣','君临天下','无双魅影','神帝','傲世天下','真龙天子'
}

local mt = ac.skill['英雄']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yxpf.blp]],
    title = '英雄皮肤',
    tip = [[

查看英雄皮肤
    ]],
}
mt.skills = {
    '赵子龙','Pa','虞姬','手无寸铁的小龙女','太极熊猫','关羽','狄仁杰','伊利丹','至尊宝','鬼厉','剑仙'
}

local mt = ac.skill['神圣领域']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ssly.blp]],
    title = '神圣领域',
    tip = [[

查看神圣领域
    ]],
    
}
mt.skills = {
    '血雾领域','龙腾领域','飞沙热浪领域','灵霄烟涛领域','孤风青龙领域','远影苍龙领域'
}



for i,name in ipairs({'礼包','武器','翅膀','称号','神圣领域','英雄','首充','游戏说明'}) do
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner 
        local player = hero:get_owner()
        -- print('打开魔法书')
        for index,skill in ipairs(self.skill_book) do 
            local has_mall = player.mall[skill.name] or (player.cus_server and player.cus_server[skill.name])
            -- print(skill.name,'所需地图等级',ac.server.need_map_level[skill.name]) and player:Map_GetMapLevel() >= (ac.server.need_map_level[skill.name]  or 0) 
            if has_mall and has_mall > 0 then 
                skill:set_level(1)
            end
        end 
    end  
end    


--注册添加给英雄
ac.game:event '玩家-注册英雄' (function(_, player, hero)
    hero:add_skill('巅峰神域','英雄',12)
end)    