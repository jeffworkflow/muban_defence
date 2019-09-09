local mt = ac.skill['缘定三生']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗 |cffff0000三十根喜鹊翎毛|r |cff00ffff兑换获得

|cffFFE799【成就属性】：|r
|cff00ff00+13.8   杀怪加全属性|r
|cff00ff00+13.8   攻击减甲|r
|cff00ff00+13.8%  木头加成|r
|cff00ff00+13.8%  会心伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 13.8,
['木头加成'] = 13.8,
['攻击减甲'] = 13.8,
['会心伤害'] = 13.8,
need_map_level = 5,
}

local mt = ac.skill['井底之蛙']
mt{
--等级
level = 1, 
max_level = 2, 
--图标
art = [[jdzw.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff抓青蛙活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=2

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   杀怪加全属性|r
|cff00ff00+%攻击减甲%   攻击减甲|r
|cff00ff00+%杀敌数加成% %  杀敌数加成|r
|cff00ff00+%物理伤害加深% %  物理伤害加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {16.8,33.6},
['杀敌数加成'] = {16.8,33.6},
['攻击减甲'] = {16.8,33.6},
['物理伤害加深'] = {16.8,33.6},
need_map_level = 5,
}


local mt = ac.skill['食物链顶端的人']
mt{
--等级
level = 1, 
max_level = 2, 
--图标
art = [[swldd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff抓青蛙活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=2

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   杀怪加全属性|r
|cff00ff00+%攻击减甲%   攻击减甲|r
|cff00ff00+%物品获取率% %  物品获取率|r
|cff00ff00+%暴击加深% %  暴击加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {18.8,37.6},
['物品获取率'] = {18.8,37.6},
['攻击减甲'] = {18.8,37.6},
['暴击加深'] = {18.8,37.6},
need_map_level = 5,
}


local mt = ac.skill['有趣的灵魂']
mt{
--等级
level = 1, --要动态插入
max_level = 55,
--图标
art = [[zyj.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 有趣的灵魂 活动获得 |cffff0000重复超度灵魂可升级成就|r |cff00ffff最大等级=55

|cffFFE799【成就属性】：|r
|cff00ff00+%暴击加深% |cff00ff00% |cff00ff00暴击加深
+%技暴加深% |cff00ff00% |cff00ff00技暴加深
+%会心伤害% |cff00ff00% |cff00ff00会心伤害
+%物理伤害加深% |cff00ff00% |cff00ff00物理伤害加深
+%技能伤害加深% |cff00ff00% |cff00ff00技能伤害加深
+%全伤加深% |cff00ff00% |cff00ff00全伤加深
+%对BOSS额外伤害% |cff00ff00% |cff00ff00对BOSS额外伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['暴击加深'] = {1,55},
['技暴加深'] = {1,55},
['会心伤害'] = {1,55},
['物理伤害加深'] = {1,55},
['技能伤害加深'] = {1,55},
['全伤加深'] = {1,55},
['对BOSS额外伤害'] = {1,55},
need_map_level = 5,
}

local mt = ac.skill['蒙娜丽莎的微笑']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[sldzx.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 活动-失落的真相 获得

|cffFFE799【成就属性】：|r
|cff00ff00+23.8   杀怪加全属性|r
|cff00ff00+23.8   攻击减甲|r
|cff00ff00+23.8%  火灵加成|r
|cff00ff00+23.8%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 23.8,
['火灵加成'] = 23.8,
['攻击减甲'] = 23.8,
['全伤加深'] = 23.8,

need_map_level = 5,
}

local mt = ac.skill['四海共团圆']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[shgty.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+26.8   杀怪加全属性|r
|cff00ff00+26.8   攻击减甲|r
|cff00ff00+26.8%  杀敌数加成|r
|cff00ff00+26.8%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 26.8,
['杀敌数加成'] = 26.8,
['攻击减甲'] = 236.8,
['全伤加深'] = 26.8,

need_map_level = 5,
}

local mt = ac.skill['第一个吃螃蟹的人']
mt{
--等级
level = 1, 
max_level = 10,
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}
--=======================中秋活动=====================
local mt = ac.skill['秀才']
mt{
--等级
level = 1, 
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}
local mt = ac.skill['举人']
mt{
--等级
level = 1, 
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}
local mt = ac.skill['进士']
mt{
--等级
level = 1, 
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}

local mt = ac.skill['探花']
mt{
--等级
level = 1, 
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}
local mt = ac.skill['榜眼']
mt{
--等级
level = 1, 
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}


local mt = ac.skill['状元']
mt{
--等级
level = 1, 
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,20},
['攻击减甲'] = {2,20},
['物品获取率'] = {2,20},
['全伤加深'] = {2,20},

need_map_level = 5,
}
local bobing_str = {
    '秀才','举人','进士','探花','榜眼','状元'
}

local mt = ac.skill['精彩活动']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jchd.blp]],
    title = '精彩活动',
    tip = [[

查看精彩活动
    ]],
    
}
mt.skill_name ={
    '缘定三生','井底之蛙','食物链顶端的人','有趣的灵魂',
    '蒙娜丽莎的微笑','四海共团圆','第一个吃螃蟹的人',
}

mt.skills = {
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    for index,name in ipairs(self.skill_name) do 
        local has_mall = player.mall[name] or (player.cus_server and player.cus_server[name])
        if has_mall and has_mall > 0 then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
            local skl = hero:find_skill(name,nil,true)
            skl:set_level(has_mall)
        end
    end 
    --特殊处理 博饼活动
    local key = 'bobing'
    local server_value = player.cus_server and player.cus_server[ac.server.key2name(key)] or 0
    if server_value > 0 then 
        local name = bobing_str[server_value]
        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
    end
end    
