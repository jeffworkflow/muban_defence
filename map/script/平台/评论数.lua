
--------个人评论次数和奖励---------------------

ac.wait(13,function()
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then
            p:event '玩家-注册英雄后' (function(_, _, hero)
                local value = p:Map_CommentCount()
                local map_level = p:Map_GetMapLevel()
                print('玩家评论数',value)
                hero:add('减少周围护甲',value*map_level*1.5)
            end)
        end
    end
end);

--------总评论次数和奖励---------------------
local mt = ac.skill['日益精进']
mt{
--等级
level = 0,
--图标
art = [[chibang7.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【翅膀属性】：|r
|cff00ff00+250    杀怪加全属性|r
|cff00ff00+488    攻击加全属性|r
|cff00ff00+788    每秒加全属性|r
|cff00ff00+10    每秒加护甲|r
|cff00ff00+10%   免伤|r
|cff00ff00+10%   免伤几率|r

|cffffff00轮迴幻魔翼+绝世阳炎翼可激活属性：全伤加深+100%

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加护甲'] = 1000,
--特效
effect = [[chibang7.mdx]]
}

local mt = ac.skill['勇攀新高']
mt{
--等级
level = 0,
--图标
art = [[chibang7.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【翅膀属性】：|r
|cff00ff00+250    杀怪加全属性|r
|cff00ff00+488    攻击加全属性|r
|cff00ff00+788    每秒加全属性|r
|cff00ff00+10    每秒加护甲|r
|cff00ff00+10%   免伤|r
|cff00ff00+10%   免伤几率|r

|cffffff00轮迴幻魔翼+绝世阳炎翼可激活属性：全伤加深+100%

|cffff0000【点击可更换翅膀外观，所有翅膀属性可叠加】|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加木头'] = 1000,
--特效
effect = [[chibang7.mdx]]
}



local mt = ac.skill['全服奖励']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ssly.blp]],
    title = '全服奖励',
    tip = [[

查看全服奖励
    ]],
    
}
mt.skills = {
    '日益精进','勇攀新高'
}

function mt:on_add()
    local hero = self.owner 
    local p = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 
        local total_common = p:Map_CommentTotalCount()
        local map_level = p:Map_GetMapLevel()
        -- print('地图总评论数',total_common)
        if total_common >= skill.need_common  and map_level >= skill.need_map_level then 
            skill:set_level(1)
        end
    end 
end  


-----------------------配置要求-----------------------------------
local condition = {
    --福利 = 评论数，激活所需地图等级
    ['日益精进'] = {55000,5},
    ['勇攀新高'] = {75000,8},
}

for name,data in pairs(condition) do 
    local mt = ac.skill[name]
    mt.need_common = data[1]
    mt.need_map_level = data[2]
end





