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
    {'cntwxld','无限乱斗'},
    {'cntsyld','深渊乱斗'},
    {'cntpkms','武林大会'},
}
local cnt_ljwj_config = { --通关
    {'ljwjxlms','修罗模式无尽累计'},-- 无尽层数累计值
    {'ljwjdpcq','斗破苍穹无尽累计'},-- 无尽层数累计值
    {'ljwjwszj','无上之境无尽累计'},-- 无尽层数累计值
    {'ljwjwxld','无限乱斗无尽累计'},-- 无尽层数累计值
    {'ljwjsyld','深渊乱斗无尽累计'},-- 无尽层数累计值
}
local cnt_wbjf_config = {
    {'wbjf','挖宝积分'},
}
local cnt_wljf_config = {
    {'wljf','比武积分'},
}

local get_season 
local save_season 

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
    local cnt = p.cus_server['S0通关次数'] 
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    return cnt
end,
--无尽累计 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = p.cus_server['S0无尽累计'] 
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100)--1500,100
    return cnt
end,
--挖宝积分 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = p.cus_server['S0挖宝积分'] 
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500)--5000,500
    return cnt
end,
}

local mt = ac.skill['S0赛季奖励']
mt{
--等级
level = 1, --要动态插入
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
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner() 
    local cnt = p.cus_server['S0通关次数'] 
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    return cnt
end,
--无尽累计 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = p.cus_server['S0无尽累计'] 
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100)--1500,100
    return cnt
end,
--挖宝积分 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = p.cus_server['S0挖宝积分'] 
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500)--5000,500
    return cnt
end,

['杀怪加力量'] =function(self)
   return self.cnt_succ
end,
['攻击加力量'] =function(self)
   return self.cnt_ljwj
end,
['每秒加力量'] =function(self)
   return self.cnt_wbjf
end,
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
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}
function mt:on_add()
end    


local mt = ac.skill['S1赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[sj1.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff008月25日-9月1日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励


|cffcccccc当前赛季 通关次数：%cnt_succ%
|cffcccccc当前赛季 无尽累计波数: %cnt_ljwj%
|cffcccccc当前赛季 挖宝积分: %cnt_wbjf%
|cffcccccc当前赛季 比武积分: %cnt_wljf%
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S1通关次数'] or 0) - (p.cus_server['S0通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S1无尽累计'] or 0)- (p.cus_server['S0无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S1挖宝积分'] or 0)- (p.cus_server['S0挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S1比武积分'] or 0)
    cnt = math.min(cnt,1000,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
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
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S1通关次数'] or 0) - (p.cus_server['S0通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S1无尽累计'] or 0)- (p.cus_server['S0无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    -- print(p.cus_server['S1挖宝积分'],p.cus_server['S0挖宝积分'])
    local cnt = (p.cus_server['S1挖宝积分'] or 0)- (p.cus_server['S0挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S1比武积分'] or 0)
    cnt = math.min(cnt,1000,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

['杀怪加敏捷'] =function(self)
    return self.cnt_succ
 end,
 ['攻击加敏捷'] =function(self)
    return self.cnt_ljwj
 end,
 ['每秒加敏捷'] =function(self)
    return self.cnt_wbjf
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
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
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

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
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}


local mt = ac.skill['S2赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[S2sjsm.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff009月2日-9月10日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励

|cffcccccc当前赛季 通关次数：%cnt_succ%
|cffcccccc当前赛季 无尽累计波数: %cnt_ljwj%
|cffcccccc当前赛季 挖宝积分: %cnt_wbjf%
|cffcccccc当前赛季 比武积分: %cnt_wljf%
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S2通关次数'] or 0) - (p.cus_server['S1通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S2无尽累计'] or 0)- (p.cus_server['S1无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S2挖宝积分'] or 0)- (p.cus_server['S1挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S2比武积分'] or 0)- (p.cus_server['S1比武积分'] or 0)
    cnt = math.min(cnt,1000,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S2赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s2sjjl.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加智力】|cff00ffff+1*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加智力】|cff00ffff+1*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加智力】|cff00ffff+1*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S2通关次数'] or 0) - (p.cus_server['S1通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S2无尽累计'] or 0)- (p.cus_server['S1无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S2挖宝积分'] or 0)- (p.cus_server['S1挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S2比武积分'] or 0)- (p.cus_server['S1比武积分'] or 0)
    cnt = math.min(cnt,1000,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加智力'] =function(self)
    return self.cnt_succ
 end,
 ['攻击加智力'] =function(self)
    return self.cnt_ljwj
 end,
 ['每秒加智力'] =function(self)
    return self.cnt_wbjf
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
}

local mt = ac.skill['S2赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s2sjwz.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

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
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}


local mt = ac.skill['S3赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ3.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff009月12日-9月22日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励

|cffcccccc当前赛季 通关次数：%cnt_succ%
|cffcccccc当前赛季 无尽累计波数: %cnt_ljwj%
|cffcccccc当前赛季 挖宝积分: %cnt_wbjf%
|cffcccccc当前赛季 比武积分: %cnt_wljf%
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S3通关次数'] or 0) - (p.cus_server['S2通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S3无尽累计'] or 0)- (p.cus_server['S2无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S3挖宝积分'] or 0)- (p.cus_server['S2挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S3比武积分'] or 0)- (p.cus_server['S2比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S3赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s3sjjl.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+1*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+1*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+1*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S3通关次数'] or 0) - (p.cus_server['S2通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S3无尽累计'] or 0)- (p.cus_server['S2无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S3挖宝积分'] or 0)- (p.cus_server['S2挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S3比武积分'] or 0)- (p.cus_server['S2比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
}

local mt = ac.skill['S3赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s3sjwz.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

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
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}

local mt = ac.skill['S4赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ4.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff009月23日-10月6日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励

|cffcccccc当前赛季 通关次数：%cnt_succ%
|cffcccccc当前赛季 无尽累计波数: %cnt_ljwj%
|cffcccccc当前赛季 挖宝积分: %cnt_wbjf%
|cffcccccc当前赛季 比武积分: %cnt_wljf%
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S4通关次数'] or 0) - (p.cus_server['S3通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S4无尽累计'] or 0)- (p.cus_server['S3无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S4挖宝积分'] or 0)- (p.cus_server['S3挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S4比武积分'] or 0)- (p.cus_server['S3比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S4赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s4sjjl.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加力量】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加力量】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加力量】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt =(p.cus_server['S4通关次数'] or 0) - (p.cus_server['S3通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S4无尽累计'] or 0)- (p.cus_server['S3无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S4挖宝积分'] or 0)- (p.cus_server['S3挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = (p.cus_server['S4比武积分'] or 0)- (p.cus_server['S3比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加力量'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加力量'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加力量'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
}

local mt = ac.skill['S4赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s4sjwz.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

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
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}


local mt = ac.skill['S5赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ5.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff0010月7日-10月17日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将发放丰厚的赛季奖励

|cffcccccc当前赛季 通关次数：%cnt_succ%
|cffcccccc当前赛季 无尽累计波数: %cnt_ljwj%
|cffcccccc当前赛季 挖宝积分: %cnt_wbjf%
|cffcccccc当前赛季 比武积分: %cnt_wljf%
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = get_season(p,'总通关次数') - (p.cus_server['S4通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = get_season(p,'总无尽累计') - (p.cus_server['S4无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = get_season(p,'总挖宝积分') - (p.cus_server['S4挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero:get_owner()
    local cnt = get_season(p,'总比武积分') - (p.cus_server['S4比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    return cnt
end,
}

local mt = ac.skill['S5赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s5sjjl.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加敏捷】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加敏捷】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加敏捷】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}

local mt = ac.skill['S5赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[s5sjwz.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

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
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}

local mt = ac.skill['S0赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sj0.blp]],
    title = 'S0赛季',
    tip = [[

查看S0赛季
    ]],
    
}
mt.skills = {
    'S0赛季说明','S0赛季奖励','S0赛季王者',nil,
}
local mt = ac.skill['S1赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sj1.blp]],
    title = 'S1赛季',
    tip = [[

查看S1赛季
    ]],
    
}
mt.skills = {
    'S1赛季说明','S1赛季奖励','S1赛季王者',nil,
}
local mt = ac.skill['S2赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[S2sjsm.blp]],
    title = 'S2赛季',
    tip = [[

查看S2赛季
    ]],
    
}
mt.skills = {
    'S2赛季说明','S2赛季奖励','S2赛季王者',nil,
}
local mt = ac.skill['S3赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[Sj3.blp]],
    title = 'S3赛季',
    tip = [[

查看S3赛季
    ]],
    
}
mt.skills = {
    'S3赛季说明','S3赛季奖励','S3赛季王者',nil,
}
local mt = ac.skill['S4赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ4.blp]],
    title = 'S4赛季',
    tip = [[

查看S4赛季
    ]],
    
}
mt.skills = {
    'S4赛季说明','S4赛季奖励','S4赛季王者',nil,
}

for i,name in ipairs({'S0赛季','S1赛季','S2赛季','S3赛季','S4赛季'}) do 
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner 
        local player = hero:get_owner()

        for index,skill in ipairs(self.skill_book) do 
            if finds(skill.name,'S0赛季王者','S1赛季王者','S2赛季王者','S3赛季王者','S4赛季王者')then 
                local has_mall = (player.cus_server2 and player.cus_server2[skill.name])
                if has_mall and has_mall > 0 then 
                    skill:set_level(1)
                end
            end    
            if finds(skill.name,'说明','奖励')then 
                skill:set_level(1)
            end   
        end 
    end    
end






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
    'S5赛季说明','S5赛季奖励','S5赛季王者',nil,
    nil,nil,'S0赛季','S1赛季',
    'S2赛季','S3赛季','S4赛季',
}
get_season = function(p,key,flag_reduce)
    local cnt = 0
    if key == '总通关次数' then 
        for i,data in ipairs(cnt_succ_config) do 
            cnt = cnt + (p.cus_server[data[2]] or 0)
        end 
    elseif  key == '总无尽累计' then   
        for i,data in ipairs(cnt_ljwj_config) do 
            cnt = cnt + (p.cus_server[data[2]] or 0)
        end 
    elseif  key == '总挖宝积分' then   
        for i,data in ipairs(cnt_wbjf_config) do 
            cnt = cnt + (p.cus_server[data[2]] or 0)
        end 
    elseif  key == '总比武积分' then   
        for i,data in ipairs(cnt_wljf_config) do 
            cnt = cnt + (p.cus_server[data[2]] or 0)
        end 
    end    
    return cnt
end

save_season= function(p)
    if not p.cus_server then 
        p.cus_server = {} 
    end    
    --通关次数处理
    local cnt_succ = p.cus_server['S0通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S0通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S0无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S0无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S0挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S0挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    -----------S1赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S1通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S1通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S1无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S1无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S1挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S1挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S1比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S1比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    -----------S2赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S2通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S2通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S2无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S2无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S2挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S2挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S2比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S2比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    -----------S3赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S3通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S3通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S3无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S3无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S3挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S3挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S3比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S3比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    -----------S4赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S4通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S4通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S4无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S4无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S4挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S4挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S4比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S4比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
end    


function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    --保存 网易服务器 赛季数据
    save_season(player)
    
    for index,skill in ipairs(self.skill_book) do 
        -- if finds(skill.name,'S0赛季王者','S1赛季王者','S2赛季王者')then 
        --     local has_mall = (player.cus_server2 and player.cus_server2[skill.name])
        --     if has_mall and has_mall > 0 then 
        --         skill:set_level(1)
        --     end
        -- end    
        if finds(skill.name,'S5赛季说明')then 
            skill:set_level(1)
        end   
    end 
end    
