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
    '礼包','武器','翅膀','称号','英雄'
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
    '首发福利','永久赞助','永久超级赞助','群号礼包','五星好评礼包','金币礼包','木材礼包'
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
    '霸王莲龙锤','惊虹奔雷剑','幻海雪饮剑','皇帝剑','皇帝刀'
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
    '梦蝶仙翼','玄羽绣云翼','天罡苍羽翼','绝世阳炎翼','轮迴幻魔翼'
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
    '炉火纯青','势不可挡','毁天灭地','巅峰天域','君临天下','九世天尊','神帝','王者归来'
}

local mt = ac.skill['英雄']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cwpf.blp]],
    title = '查看英雄',
    tip = [[

查看英雄
    ]],
}
mt.skills = {
    'Pa','手无寸铁的小龙女','关羽'
}

for i,name in ipairs({'礼包','武器','翅膀','称号','英雄'}) do
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner 
        local player = hero:get_owner()
        -- print('打开魔法书')
        for index,skill in ipairs(self.skill_book) do 
            local has_mall = player.mall[skill.name] or (player.cus_server and player.cus_server[skill.name])
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