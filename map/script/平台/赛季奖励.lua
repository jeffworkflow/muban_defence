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
local cnt_wbjf_config = {
    {'wbjf','挖宝积分'},
}


local mt = ac.skill['S0赛季说明']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[SJ0.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff00X月X日-8月24日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励

|cffcccccc当前赛季 通关次数：%cnt_succ%
|cffcccccc当前赛季 无尽累计波数: %cnt_ljwj%
|cffcccccc当前赛季 挖宝积分: %cnt_wbjf%
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
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100)
    return cnt 
end,
--无尽累计 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    local cnt = 0
    for i,data in ipairs(cnt_wbjf_config) do 
        cnt = cnt + (p.cus_server[data[2]] or 0)
    end 
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500)
    return cnt 
end,
}

local mt = ac.skill['S0赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj01.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加力量】|cff00ffff+1*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加力量】|cff00ffff+1*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加力量】|cff00ffff+1*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}


local mt = ac.skill['S0赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj02.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+36.8   杀怪加全属性|r
|cff00ff00+36.8   攻击减甲|r
|cff00ff00+1%     会心几率|r
|cff00ff00+10%    会心伤害|r
|cff00ff00+16.8%  全伤加深|r
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 5,
}


local mt = ac.skill['S1赛季说明']
mt{
--等级
level = 1, --要动态插入
max_level = 35,
--图标
art = [[sj1.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff008月25日-8月31日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}

local mt = ac.skill['S1赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj11.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加敏捷】|cff00ffff+1*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加敏捷】|cff00ffff+1*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加敏捷】|cff00ffff+1*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S1赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj12.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+36.8   杀怪加全属性|r
|cff00ff00+36.8   攻击减甲|r
|cff00ff00+1%     会心几率|r
|cff00ff00+10%    会心伤害|r
|cff00ff00+16.8%  全伤加深|r
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['赛季奖励']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sjjl.blp]],
    title = '赛季奖励',
    tip = [[

查看赛季奖励
    ]],
    
}
mt.skills = {
    'S0赛季说明','S0赛季奖励','S0赛季王者',nil,
    'S1赛季说明','S1赛季奖励','S1赛季王者'
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
