
--------个人评论次数和奖励---------------------
local mt = ac.skill['评论礼包']
mt{
--等级
level = 1,
--图标
art = [[rlsh.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 5.5W 自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+20%  杀敌数加成|r
|cff00ff00+10   攻击减甲|r
|cff00ff00+2%   对BOSS额外伤害|r
|cff00ff00+1%   会心几率|r
|cff00ff00+10%  会心伤害|r

]],
['减少周围护甲'] = function(self)
    local p = self.owner:get_owner()
    local value = p:Map_CommentCount()
    local map_level = p:Map_GetMapLevel()
    return value*map_level*1.5
end,
}

--------总评论次数和奖励---------------------
local mt = ac.skill['日益精进']
mt{
--等级
level = 0,
--图标
art = [[rlsh.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 5.5W 自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+20%  杀敌数加成|r
|cff00ff00+10   攻击减甲|r
|cff00ff00+2%   对BOSS额外伤害|r
|cff00ff00+1%   会心几率|r
|cff00ff00+10%  会心伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
['杀敌数加成'] = 20,
['攻击减甲'] = 10,
['对BOSS额外伤害'] = 2,
['会心几率'] = 1,
['会心伤害'] = 10,

}

local mt = ac.skill['勇攀新高']
mt{
--等级
level = 0,
--图标
art = [[ypxg.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 7.5W 自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+30   攻击减甲|r
|cff00ff00+20%  物理伤害加深|r
|cff00ff00+10%  技能伤害加深|r
|cff00ff00+10%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击减甲'] = 30,
['物理伤害加深'] = 20,
['技能伤害加深'] = 10,
['全伤加深'] = 10,
need_map_level = 8,

}



local mt = ac.skill['全服奖励']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[qfjl.blp]],
    title = '全服奖励',
    tip = [[

查看全服奖励
    ]],
    
}
mt.skills = {
    '评论礼包',nil,nil,nil,'日益精进','勇攀新高'
}

function mt:on_add()
    local hero = self.owner 
    local p = hero:get_owner()
    -- print('打开魔法书')
    for index,skill in ipairs(self.skill_book) do 
        if skill and skill.name ~= '评论礼包' then 
            local total_common = p:Map_CommentTotalCount()
            local map_level = p:Map_GetMapLevel()
            -- print('地图总评论数',total_common)
            if total_common >= skill.need_common  and map_level >= skill.need_map_level then 
                skill:set_level(1)
            end
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





