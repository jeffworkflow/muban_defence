local cnt_succ_config = { --通关
    {'cnt_qt','青铜'},
    {'cnt_by','白银'},
    {'cnt_hj','黄金'},
    {'cnt_bj','铂金'},
    {'cnt_zs','钻石'},
    {'cnt_xy','星耀'},
    {'cnt_wz','王者'},
    {'cnt_zqwz','最强王者'},
    {'cntrywz','荣耀王者'},
    {'cntdfwz','巅峰王者'},
    {'cntxlms','修罗模式'}, -- 星数
    {'cntdpcq','斗破苍穹'}, -- 星数
    {'cntwszj','无上之境'},
}
local cnt_ljwj_config = { --通关
    {'ljwjxlms','修罗模式无尽累计'},-- 无尽层数累计值
    {'ljwjdpcq','斗破苍穹无尽累计'},-- 无尽层数累计值
    {'ljwjwszj','无上之境无尽累计'},-- 无尽层数累计值
}


local mt = ac.skill['S0赛季']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
通关次数：%cnt_succ%
无尽累计: %cnt_ljwj%

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
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    local cnt = 0
    for i,data in ipairs(cnt_succ_config) do 
        cnt = cnt + (p.cus_server[data[2]] or 0)
    end 
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25)
    return cnt 
end,
--无尽累计 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    local cnt = 0
    for i,data in ipairs(cnt_ljwj_config) do 
        cnt = cnt + (p.cus_server[data[2]] or 0)
    end 
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*100)
    return cnt 
end,
}

local mt = ac.skill['S0赛季奖励A']
mt{
--等级
level = 0, --要动态插入
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
need_map_level = 5,
}


local mt = ac.skill['S0赛季奖励B']
mt{
--等级
level = 0, --要动态插入
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
need_map_level = 5,
}


local mt = ac.skill['S1赛季']
mt{
--等级
level = 1, --要动态插入
max_level = 35,
--图标
art = [[zyj.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过中元节活动获得 |cffff0000重复超度灵魂可升级成就|r |cff00ffff最大等级=35

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
}

local mt = ac.skill['S1赛季奖励A']
mt{
--等级
level = 0, --要动态插入
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

need_map_level = 5,
}

local mt = ac.skill['S1赛季奖励B']
mt{
--等级
level = 0, --要动态插入
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

need_map_level = 5,
}

local mt = ac.skill['赛季奖励']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jchd.blp]],
    title = '赛季奖励',
    tip = [[

查看赛季奖励
    ]],
    
}
mt.skills = {
    'S0赛季','S0赛季奖励A','S0赛季奖励B',nil,
    'S1赛季','S1赛季奖励A','S1赛季奖励B'
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- for index,name in ipairs(self.skill_name) do 
    --     local has_mall = player.mall[name] or (player.cus_server and player.cus_server[name])
    --     if has_mall and has_mall > 0 then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
    --         local skl = hero:find_skill(name,nil,true)
    --         skl:set_level(has_mall)
    --     end
    -- end 
end    
