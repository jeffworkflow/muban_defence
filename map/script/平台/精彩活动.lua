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
level = 1, --要动态插入
--图标
art = [[jdzw.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff抓青蛙活动获得

|cffFFE799【成就属性】：|r
|cff00ff00+16.8   杀怪加全属性|r
|cff00ff00+16.8   攻击减甲|r
|cff00ff00+16.8%  杀敌数加成|r
|cff00ff00+16.8%  物理伤害加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 16.8,
['木头加成'] = 16.8,
['攻击减甲'] = 16.8,
['会心伤害'] = 16.8,
need_map_level = 5,
}


local mt = ac.skill['食物链顶端的人']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[swldd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff抓青蛙活动获得

|cffFFE799【成就属性】：|r
|cff00ff00+18.8   杀怪加全属性|r
|cff00ff00+18.8   攻击减甲|r
|cff00ff00+18.8%  物品获取率|r
|cff00ff00+18.8%  暴击加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 18.8,
['物品获取率'] = 18.8,
['攻击减甲'] = 18.8,
['暴击加深'] = 18.8,
need_map_level = 5,
}


local mt = ac.skill['有趣的灵魂']
mt{
--等级
level = 1, --要动态插入
max_level = 25,
--图标
art = [[swldd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff抓青蛙活动获得

|cffFFE799【成就属性】：|r
|cff00ff00+%暴击伤害%   |cff00ff00暴击伤害
+%技暴伤害%   |cff00ff00技暴伤害
+%会心伤害%   |cff00ff00会心伤害
+%物理伤害加深%   |cff00ff00物理伤害加深
+%技能伤害加深%   |cff00ff00技能伤害加深
+%全伤加深%   |cff00ff00全伤加深
+%对BOSS额外伤害%   |cff00ff00对BOSS额外伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['暴击伤害'] = {1,25},
['技暴伤害'] = {1,25},
['会心伤害'] = {1,25},
['物理伤害加深'] = {1,25},
['技能伤害加深'] = {1,25},
['全伤加深'] = {1,25},
['对BOSS额外伤害'] = {1,25},
need_map_level = 5,
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
    '缘定三生','井底之蛙','食物链顶端的人','有趣的灵魂'
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
end    
