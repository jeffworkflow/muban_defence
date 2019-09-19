
--------个人评论次数和奖励---------------------
local mt = ac.skill['评论礼包']
mt{
--等级
level = 1,
--图标
art = [[pllb.blp]],
--说明
tip = [[ 
|cff00ff00平台进行评论即可获得，评论礼包属性可存档|r 

|cffffe799【礼包属性】
|cffff0000【减少周围护甲】|cff00ffff+1.5*地图等级*评论次数
|cffff0000【攻击加全属性】|cff00ffff+1*地图等级*评论次数
 ]],
['减少周围护甲'] = function(self)
    local p = self.owner:get_owner()
    local value = p:Map_CommentCount()
    local map_level = p:Map_GetMapLevel()
    return value*map_level*1.5
end,
['攻击加全属性'] = function(self)
    local p = self.owner:get_owner()
    local value = p:Map_CommentCount()
    local map_level = p:Map_GetMapLevel()
    return value*map_level*1
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
|cff00ffff在平台上，本地图的全部评论数超过 |cffff00005.5W |cff00ffff自动激活

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
|cff00ffff在平台上，本地图的全部评论数超过 |cffff00007.5W |cff00ffff自动激活

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
need_map_level = 7,

}


local mt = ac.skill['扶摇直上']
mt{
--等级
level = 0,
--图标
art = [[dspls.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 |cffff000010W |cff00ffff自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+30% 物品获取率
+45 攻击减甲
+50 移动速度
+50 攻击距离
+25% 暴击加深
+25% 技暴加深

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['物品获取率'] = 30,
['攻击减甲'] = 45,
['移动速度'] = 50,
['攻击距离'] = 50,
['暴击加深'] = 25,
['技暴加深'] = 25,
need_map_level = 10,

}

local mt = ac.skill['平步青云']
mt{
--等级
level = 0,
--图标
art = [[pbqy.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 |cffff000013W |cff00ffff自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+60 攻击减甲
+50% 暴击加深
+25% 技暴加深
+50% 物理伤害加深
+25% 技能伤害加深

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击减甲'] = 60,
['暴击加深'] = 50,
['技暴加深'] = 25,
['物理伤害加深'] = 50,
['技能伤害加深'] = 25,
need_map_level = 10,

}

local mt = ac.skill['破碎虚空']
mt{
--等级
level = 0,
--图标
art = [[psxk.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 |cffff000016.5W |cff00ffff自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+75 攻击减甲
+60% 暴击加深
+35% 技暴加深
+20% 会心伤害
+60% 物理伤害加深
+35% 技能伤害加深

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击减甲'] = 75,
['暴击加深'] = 60,
['技暴加深'] = 35,
['会心伤害'] = 20,
['物理伤害加深'] = 60,
['技能伤害加深'] = 35,
need_map_level = 10,

}

local mt = ac.skill['洞天真相']
mt{
--等级
level = 0,
--图标
art = [[dtzx.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff在平台上，本地图的全部评论数超过 |cffff000020.5W |cff00ffff自动激活

|cffFFE799【奖励属性】：|r
|cff00ff00+90 攻击减甲
+70% 暴击加深
+45% 技暴加深
+30% 会心伤害
+70% 物理伤害加深
+45% 技能伤害加深

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击减甲'] = 90,
['暴击加深'] = 70,
['技暴加深'] = 45,
['会心伤害'] = 30,
['物理伤害加深'] = 70,
['技能伤害加深'] = 45,
need_map_level = 12,

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
    '评论礼包',nil,nil,nil,'日益精进','勇攀新高','扶摇直上','平步青云','破碎虚空','洞天真相'
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
    ['勇攀新高'] = {75000,7},
    ['扶摇直上'] = {100000,10},
    ['平步青云'] = {130000,10},
    ['破碎虚空'] = {165000,10},
    ['洞天真相'] = {205000,12},
}

for name,data in pairs(condition) do 
    local mt = ac.skill[name]
    mt.need_common = data[1]
    mt.need_map_level = data[2]
end





