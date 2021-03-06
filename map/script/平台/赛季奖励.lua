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
    {'cntmjld','梦境乱斗'},
    {'cntpkms','武林大会'},
}
local cnt_ljwj_config = { --通关
    {'ljwjxlms','修罗模式无尽累计'},-- 无尽层数累计值
    {'ljwjdpcq','斗破苍穹无尽累计'},-- 无尽层数累计值
    {'ljwjwszj','无上之境无尽累计'},-- 无尽层数累计值
    {'ljwjwxld','无限乱斗无尽累计'},-- 无尽层数累计值
    {'ljwjsyld','深渊乱斗无尽累计'},-- 无尽层数累计值
    {'ljwjmjld','梦境乱斗无尽累计'},-- 无尽层数累计值
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
    local p = hero.owner 
    local cnt = p.cus_server['S0通关次数'] 
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    return cnt
end,
--无尽累计 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = p.cus_server['S0无尽累计'] 
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100)--1500,100
    return cnt
end,
--挖宝积分 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    -- print(self,self.owner,self.name)
    local hero = self.owner
    local p = hero.owner 
    local cnt = p.cus_server['S0通关次数'] 
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    return cnt
end,
--无尽累计 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = p.cus_server['S0无尽累计'] 
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100)--1500,100
    return cnt
end,
--挖宝积分 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S1通关次数'] or 0) - (p.cus_server['S0通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S1无尽累计'] or 0)- (p.cus_server['S0无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S1挖宝积分'] or 0)- (p.cus_server['S0挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S1通关次数'] or 0) - (p.cus_server['S0通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S1无尽累计'] or 0)- (p.cus_server['S0无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    -- print(p.cus_server['S1挖宝积分'],p.cus_server['S0挖宝积分'])
    local cnt = (p.cus_server['S1挖宝积分'] or 0)- (p.cus_server['S0挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S2通关次数'] or 0) - (p.cus_server['S1通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S2无尽累计'] or 0)- (p.cus_server['S1无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S2挖宝积分'] or 0)- (p.cus_server['S1挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S2通关次数'] or 0) - (p.cus_server['S1通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S2无尽累计'] or 0)- (p.cus_server['S1无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S2挖宝积分'] or 0)- (p.cus_server['S1挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S3通关次数'] or 0) - (p.cus_server['S2通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S3无尽累计'] or 0)- (p.cus_server['S2无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S3挖宝积分'] or 0)- (p.cus_server['S2挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S3通关次数'] or 0) - (p.cus_server['S2通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S3无尽累计'] or 0)- (p.cus_server['S2无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S3挖宝积分'] or 0)- (p.cus_server['S2挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S4通关次数'] or 0) - (p.cus_server['S3通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S4无尽累计'] or 0)- (p.cus_server['S3无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S4挖宝积分'] or 0)- (p.cus_server['S3挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt =(p.cus_server['S4通关次数'] or 0) - (p.cus_server['S3通关次数'] or 0)
    cnt = math.min(cnt,250,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S4无尽累计'] or 0)- (p.cus_server['S3无尽累计'] or 0)
    cnt = math.min(cnt,750,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S4挖宝积分'] or 0)- (p.cus_server['S3挖宝积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
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
    local p = hero.owner
    local cnt = (p.cus_server['S5通关次数'] or 0) - (p.cus_server['S4通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S5无尽累计'] or 0) - (p.cus_server['S4无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S5挖宝积分'] or 0)- (p.cus_server['S4挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S5比武积分'] or 0) - (p.cus_server['S4比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
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
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S5通关次数'] or 0) - (p.cus_server['S4通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S5无尽累计'] or 0) - (p.cus_server['S4无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S5挖宝积分'] or 0)- (p.cus_server['S4挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S5比武积分'] or 0) - (p.cus_server['S4比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加敏捷'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加敏捷'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加敏捷'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
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

local mt = ac.skill['S6赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ6.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff0010月18日-10月28日
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
    local p = hero.owner
    local cnt = (p.cus_server['S6通关次数'] or 0) - (p.cus_server['S5通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S6无尽累计'] or 0) - (p.cus_server['S5无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S6挖宝积分'] or 0)- (p.cus_server['S5挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S6比武积分'] or 0) - (p.cus_server['S5比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S6赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj6.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加智力】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加智力】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加智力】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S6通关次数'] or 0) - (p.cus_server['S5通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S6无尽累计'] or 0) - (p.cus_server['S5无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S6挖宝积分'] or 0)- (p.cus_server['S5挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S6比武积分'] or 0) - (p.cus_server['S5比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加智力'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加智力'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加智力'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,

}

local mt = ac.skill['S6赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj6.blp]],
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

local mt = ac.skill['S7赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ7.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff0010月28日-11月18日
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
    local p = hero.owner
    local cnt = (p.cus_server['S7通关次数'] or 0) - (p.cus_server['S6通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S7无尽累计'] or 0) - (p.cus_server['S6无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S7挖宝积分'] or 0)- (p.cus_server['S6挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S7比武积分'] or 0) - (p.cus_server['S6比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S7赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj7.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S7通关次数'] or 0) - (p.cus_server['S6通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S7无尽累计'] or 0) - (p.cus_server['S6无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S7挖宝积分'] or 0)- (p.cus_server['S6挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S7比武积分'] or 0) - (p.cus_server['S6比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,

}

local mt = ac.skill['S7赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj7.blp]],
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

local mt = ac.skill['S8赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ8.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff0011月19日-12月19日
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
    local p = hero.owner
    local cnt = (p.cus_server['S8通关次数'] or 0) - (p.cus_server['S7通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S8无尽累计'] or 0) - (p.cus_server['S7无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S8挖宝积分'] or 0)- (p.cus_server['S7挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S8比武积分'] or 0) - (p.cus_server['S7比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S8赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj8.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S8通关次数'] or 0) - (p.cus_server['S7通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S8无尽累计'] or 0) - (p.cus_server['S7无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S8挖宝积分'] or 0)- (p.cus_server['S7挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S8比武积分'] or 0) - (p.cus_server['S7比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,


}

local mt = ac.skill['S8赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj8.blp]],
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

local mt = ac.skill['S9赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ9.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff0012月20日-1月20日
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
    local p = hero.owner
    local cnt = (p.cus_server['S9通关次数'] or 0) - (p.cus_server['S8通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S9无尽累计'] or 0) - (p.cus_server['S8无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S9挖宝积分'] or 0)- (p.cus_server['S8挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S9比武积分'] or 0) - (p.cus_server['S8比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S9赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj9.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S9通关次数'] or 0) - (p.cus_server['S8通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S9无尽累计'] or 0) - (p.cus_server['S8无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S9挖宝积分'] or 0)- (p.cus_server['S8挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S9比武积分'] or 0) - (p.cus_server['S8比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,

}

local mt = ac.skill['S9赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj9.blp]],
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

local mt = ac.skill['S10赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ10.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff001月21日-2月21日
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
    local p = hero.owner
    local cnt = (p.cus_server['S10通关次数'] or 0) - (p.cus_server['S9通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S10无尽累计'] or 0) - (p.cus_server['S9无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S10挖宝积分'] or 0)- (p.cus_server['S9挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S10比武积分'] or 0) - (p.cus_server['S9比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S10赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj10.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S10通关次数'] or 0) - (p.cus_server['S9通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S10无尽累计'] or 0) - (p.cus_server['S9无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S10挖宝积分'] or 0)- (p.cus_server['S9挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S10比武积分'] or 0) - (p.cus_server['S9比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,

}

local mt = ac.skill['S10赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj10.blp]],
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

local mt = ac.skill['S11赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ111.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff002月22日-3月22日
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
    local p = hero.owner
    local cnt = (p.cus_server['S11通关次数'] or 0) - (p.cus_server['S10通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S11无尽累计'] or 0) - (p.cus_server['S10无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S11挖宝积分'] or 0)- (p.cus_server['S10挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S11比武积分'] or 0) - (p.cus_server['S10比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S11赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj111.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S11通关次数'] or 0) - (p.cus_server['S10通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S11无尽累计'] or 0) - (p.cus_server['S10无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S11挖宝积分'] or 0)- (p.cus_server['S10挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S11比武积分'] or 0) - (p.cus_server['S10比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,

}

local mt = ac.skill['S11赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj111.blp]],
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

local mt = ac.skill['S12赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ112.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff003月24日-4月24日
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
    local p = hero.owner
    local cnt = (p.cus_server['S12通关次数'] or 0) - (p.cus_server['S11通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S12无尽累计'] or 0) - (p.cus_server['S11无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S12挖宝积分'] or 0)- (p.cus_server['S11挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S12比武积分'] or 0) - (p.cus_server['S11比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S12赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj112.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S12通关次数'] or 0) - (p.cus_server['S11通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S12无尽累计'] or 0) - (p.cus_server['S11无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S12挖宝积分'] or 0)- (p.cus_server['S11挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S12比武积分'] or 0) - (p.cus_server['S11比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
}

local mt = ac.skill['S12赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj112.blp]],
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

local mt = ac.skill['S13赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ113.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff004月25日-5月25日
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
    local p = hero.owner
    local cnt = (p.cus_server['S13通关次数'] or 0) - (p.cus_server['S12通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S13无尽累计'] or 0) - (p.cus_server['S12无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S13挖宝积分'] or 0)- (p.cus_server['S12挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S13比武积分'] or 0) - (p.cus_server['S12比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S13赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj113.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S13通关次数'] or 0) - (p.cus_server['S12通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S13无尽累计'] or 0) - (p.cus_server['S12无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S13挖宝积分'] or 0)- (p.cus_server['S12挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S13比武积分'] or 0) - (p.cus_server['S12比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
}

local mt = ac.skill['S13赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj113.blp]],
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


local mt = ac.skill['S14赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ114.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff005月26日-7月26日
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
    local p = hero.owner
    local cnt = get_season(p,'S14通关次数') - (p.cus_server['S13通关次数'] or 0)
    cnt = math.min(cnt,1000,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = get_season(p,'S14无尽累计') - (p.cus_server['S13无尽累计'] or 0)
    cnt = math.min(cnt,3000,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = get_season(p,'S14挖宝积分') - (p.cus_server['S13挖宝积分'] or 0)
    cnt = math.min(cnt,10000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = get_season(p,'S14比武积分') - (p.cus_server['S13比武积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
}

local mt = ac.skill['S14赛季奖励']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj114.blp]],
--说明
tip = [[

|cffFFE799【赛季奖励】：|r
|cffff0000【杀怪加全属性】|cff00ffff+2*当前赛季的通关次数|cffffff00（最大通关次数受限于地图等级）
|cffff0000【攻击加全属性】|cff00ffff+2*当前赛季的无尽累计波数|cffffff00（最大累计波数受限于地图等级）
|cffff0000【每秒加全属性】|cff00ffff+2*当前赛季的挖宝积分|cffffff00（最大挖宝积分受限于地图等级）
|cffff0000【每秒加攻击】|cff00ffff+8*当前赛季的比武积分|cffffff00（最大比武积分受限于地图等级）

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--通关次数 总计
cnt_succ = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S14通关次数'] or 0) - (p.cus_server['S13通关次数'] or 0)
    cnt = math.min(cnt,500,p:Map_GetMapLevel()*25) --500，25
    cnt = cnt > 0 and cnt or 0
    return cnt
end,

--通关次数 总计
cnt_ljwj = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S14无尽累计'] or 0) - (p.cus_server['S13无尽累计'] or 0)
    cnt = math.min(cnt,1500,p:Map_GetMapLevel()*100) --1500,100
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wbjf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt = (p.cus_server['S14挖宝积分'] or 0)- (p.cus_server['S13挖宝积分'] or 0)
    cnt = math.min(cnt,5000,p:Map_GetMapLevel()*500) --5000,500
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
--通关次数 总计
cnt_wljf = function(self)
    local hero = self.owner
    local p = hero.owner
    local cnt =  (p.cus_server['S14比武积分'] or 0) - (p.cus_server['S13比武积分'] or 0)
    cnt = math.min(cnt,2500,p:Map_GetMapLevel()*50) 
    cnt = cnt > 0 and cnt or 0
    return cnt
end,
['杀怪加全属性'] =function(self)
    return self.cnt_succ * 2
 end,
 ['攻击加全属性'] =function(self)
    return self.cnt_ljwj * 2
 end,
 ['每秒加全属性'] =function(self)
    return self.cnt_wbjf * 2
 end,
 ['每秒加攻击'] =function(self)
    return self.cnt_wljf * 8
 end,
}

local mt = ac.skill['S14赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj114.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+2%   会心几率|r
|cff00ff00+20%  会心伤害|r
|cff00ff00+30%  全伤加深|r
|cffff0000局内地图等级+2

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['会心几率'] = 2,
['会心伤害'] = 20,
['全伤加深'] = 30,
['局内地图等级'] = 2
}

local mt = ac.skill['S14赛季补偿']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[sj114.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00S14赛季时间出错，所有玩家均可获得补偿

|cffFFE799【成就属性】：|r
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
}

local mt = ac.skill['S15赛季说明']
mt{
--等级
level = 0, --要动态插入
max_level = 35,
--图标
art = [[SJ114.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff008月28日-10月31日
|cffffe799【赛季说明】|r|cff00ff00赛季结束时，将清空排行榜，并发放奖励|cffffff00 S15赛季王者

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}

local mt = ac.skill['S15赛季王者']
mt{
--等级
level = 0, --要动态插入
--图标
art = [[sj114.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-比武总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+66   杀怪加全属性|r
|cff00ff00+66   攻击减甲|r
|cff00ff00+2%   会心几率|r
|cff00ff00+20%  会心伤害|r
|cff00ff00+30%  全伤加深|r
|cffff0000局内地图等级+2

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

need_map_level = 5,
['杀怪加全属性'] = 66,
['攻击减甲'] = 66,
['会心几率'] = 2,
['会心伤害'] = 20,
['全伤加深'] = 30,
['局内地图等级'] = 2
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

local mt = ac.skill['S5赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ5.blp]],
    title = 'S5赛季',
    tip = [[

查看S5赛季
    ]],
    
}
mt.skills = {
    'S5赛季说明','S5赛季奖励','S5赛季王者',nil,
}

local mt = ac.skill['S6赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ6.blp]],
    title = 'S6赛季',
    tip = [[

查看S6赛季
    ]],
    
}
mt.skills = {
    'S6赛季说明','S6赛季奖励','S6赛季王者',nil,
}

local mt = ac.skill['S7赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ7.blp]],
    title = 'S7赛季',
    tip = [[

查看S7赛季
    ]],
    
}
mt.skills = {
    'S7赛季说明','S7赛季奖励','S7赛季王者',nil,
}

local mt = ac.skill['S8赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ8.blp]],
    title = 'S8赛季',
    tip = [[

查看S8赛季
    ]],
    
}
mt.skills = {
    'S8赛季说明','S8赛季奖励','S8赛季王者',nil,
}

local mt = ac.skill['S9赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ9.blp]],
    title = 'S9赛季',
    tip = [[

查看S9赛季
    ]],
    
}
mt.skills = {
    'S9赛季说明','S9赛季奖励','S9赛季王者',nil,
}

local mt = ac.skill['S10赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ10.blp]],
    title = 'S10赛季',
    tip = [[

查看S10赛季
    ]],
    
}
mt.skills = {
    'S10赛季说明','S10赛季奖励','S10赛季王者',nil,
}

local mt = ac.skill['S11赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ111.blp]],
    title = 'S11赛季',
    tip = [[

查看S11赛季
    ]],
    
}
mt.skills = {
    'S11赛季说明','S11赛季奖励','S11赛季王者',nil,
}

local mt = ac.skill['S12赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ112.blp]],
    title = 'S12赛季',
    tip = [[

查看S12赛季
    ]],
    
}
mt.skills = {
    'S12赛季说明','S12赛季奖励','S12赛季王者',nil,
}

local mt = ac.skill['S13赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ113.blp]],
    title = 'S13赛季',
    tip = [[

查看S13赛季
    ]],
    
}
mt.skills = {
    'S13赛季说明','S13赛季奖励','S13赛季王者',nil,
}

local mt = ac.skill['S14赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[SJ114.blp]],
    title = 'S14赛季',
    tip = [[

查看S14赛季
    ]],
    
}
mt.skills = {
    'S14赛季说明','S14赛季奖励','S14赛季王者',nil,
}




for i,name in ipairs({'S0赛季','S1赛季','S2赛季','S3赛季','S4赛季','S5赛季','S6赛季','S7赛季','S8赛季','S9赛季','S10赛季','S11赛季','S12赛季','S13赛季','S14赛季','S0-S10赛季','S0-S10赛季下一页','赛季-下一页'}) do 
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner 
        local player = hero.owner

        for index,skill in ipairs(self.skill_book) do 
            if finds(skill.name,'S0赛季王者','S1赛季王者','S2赛季王者','S3赛季王者','S4赛季王者','S5赛季王者','S6赛季王者','S7赛季王者','S8赛季王者','S9赛季王者','S10赛季王者','S11赛季王者','S12赛季王者','S13赛季王者','S14赛季王者')then 
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
    -----------S5赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S5通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S5通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S5无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S5无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S5挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S5挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S5比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S5比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    -----------S6赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S6通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S6通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S6无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S6无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S6挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S6挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S6比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S6比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    -----------S7赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S7通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S7通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S7无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S7无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S7挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S7挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S7比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S7比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    -----------S8赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S8通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S8通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S8无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S8无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S8挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S8挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S8比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S8比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end   
-----------S9赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S9通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S9通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S9无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S9无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S9挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S9挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S9比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S9比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
-----------S10赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S10通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S10通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S10无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S10无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S10挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S10挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S10比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S10比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end     
-----------S11赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S11通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S11通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S11无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S11无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S11挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S11挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S11比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S11比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end     
-----------S12赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S12通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S12通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S12无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S12无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S12挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S12挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S12比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S12比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end         

-----------S13赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S13通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S13通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S13无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S13无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S13挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S13挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S13比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S13比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end       
    -----------S14赛季相关-----------------
    --通关次数处理
    local cnt_succ = p.cus_server['S14通关次数'] or 0
    if cnt_succ <=0 then 
        local cnt = get_season(p,'总通关次数')
        local key = ac.server.name2key('S14通关次数')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end    

    --无尽累计波数 处理
    local cnt_ljwj = p.cus_server['S14无尽累计'] or 0
    if cnt_ljwj <=0 then 
        local cnt = get_season(p,'总无尽累计')
        local key = ac.server.name2key('S14无尽累计')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 

    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S14挖宝积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总挖宝积分')
        local key = ac.server.name2key('S14挖宝积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end 
    
    --挖宝积分处理
    local cnt_wbjf = p.cus_server['S14比武积分'] or 0
    if cnt_wbjf <=0 then 
        local cnt = get_season(p,'总比武积分')
        local key = ac.server.name2key('S14比武积分')
        p:Map_SaveServerValue(key,cnt) --网易服务器
    end      

    
end    
--归纳s0到s10赛季数据
local function get(player)
    local tab = {}
    local hero = player.hero 
    for i=0,10 do 
        local name = 'S'..i..'赛季奖励'
        local mt = ac.skill[name]
        mt.owner = hero
        for attr in pairs(ac.unit.attribute) do 
            if mt[attr] then 
                tab[attr] = (tab[attr] or 0) + mt:get_key(attr)
                -- print(name,attr,mt:get_key(attr))
            end
        end
    end
    --从每个赛季读数据总计 并存储起来
    for name,val in pairs(tab) do 
        if val > 0 then 
            local key = ac.server.name2key('赛季'..name)
            player:Map_SaveServerValue(key,val)
        end
    end
    --加属性
    -- for name in pairs(tab) do 
    --     local val = player.cus_server['赛季'..name]
    --     if val >0 then 
    --         print('加了属性',name,val)
    --         hero:add(name,val)
    --     end
    -- end
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
    'S15赛季说明','S15赛季王者','S14赛季补偿',nil,
    'S14赛季','S13赛季','S12赛季','S11赛季',
    'S0-S10赛季',
}


function mt:on_add()
    local hero = self.owner 
    local player = hero.owner
    --保存 网易服务器 赛季数据
    -- save_season(player)
    get(player)
    for index,skill in ipairs(self.skill_book) do 
        -- if finds(skill.name,'S0赛季王者','S1赛季王者','S2赛季王者')then 
        --     local has_mall = (player.cus_server2 and player.cus_server2[skill.name])
        --     if has_mall and has_mall > 0 then 
        --         skill:set_level(1)
        --     end
        -- end    
        if finds(skill.name,'S15赛季说明')then 
            skill:set_level(1)
        end   
    end 
end    

local mt = ac.skill['S0-S10赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sj12.blp]],
    title = 'S0-S10赛季',
    tip = [[

查看S0-S10赛季
    ]],
    
}
mt.skills = {
    'S0-S10赛季奖励',
    'S0赛季王者','S1赛季王者','S2赛季王者','S3赛季王者',
    'S4赛季王者','S5赛季王者','S6赛季王者','S7赛季王者',
    'S8赛季王者','S0-S10赛季下一页'
}
local mt = ac.skill['S0-S10赛季下一页']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

查看下一页
    ]],
    
}
mt.skills = {
    'S9赛季王者','S10赛季王者'
}

local mt = ac.skill['赛季-下一页']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[ReplaceableTextures\CommandButtons\BTNReplay-Play.blp]],
    title = '下一页',
    tip = [[

查看下一页
    ]],
    
}
mt.skills = {
    'S6赛季','S7赛季','S8赛季','S9赛季','S10赛季',nil,
}

local mt = ac.skill['S0-S10赛季奖励']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[sj12.blp]],
--说明
tip = [[

|cffffe799【赛季时间】|r|cff00ff002019年7月19日-2020年2月21日

|cffFFE799【已获属性】：|r
+%杀怪加全属性% 杀怪加全属性
+%杀怪加力量% 杀怪加力量
+%杀怪加敏捷% 杀怪加敏捷
+%杀怪加智力% 杀怪加智力
+%攻击加全属性% 攻击加全属性
+%攻击加力量% 攻击加力量
+%攻击加敏捷% 攻击加敏捷
+%攻击加智力% 攻击加智力
+%每秒加全属性% 每秒加全属性
+%每秒加力量% 每秒加力量
+%每秒加敏捷% 每秒加敏捷
+%每秒加智力% 每秒加智力
+%每秒加攻击% 每秒加攻击
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['每秒加敏捷'] = function(self)
    return self.owner.owner.cus_server['赛季每秒加敏捷'] or 0
end,
['攻击加全属性'] = function(self)
    return self.owner.owner.cus_server['赛季攻击加全属性'] or 0
end,
['每秒加力量'] = function(self)
    return self.owner.owner.cus_server['赛季每秒加力量'] or 0
end,
['每秒加攻击'] = function(self)
    return self.owner.owner.cus_server['赛季每秒加攻击'] or 0
end,
['杀怪加力量'] = function(self)
    return self.owner.owner.cus_server['赛季杀怪加力量'] or 0
end,
['杀怪加全属性'] = function(self)
    return self.owner.owner.cus_server['赛季杀怪加全属性'] or 0
end,
['杀怪加敏捷'] = function(self)
    return self.owner.owner.cus_server['赛季杀怪加敏捷'] or 0
end,
['攻击加敏捷'] = function(self)
    return self.owner.owner.cus_server['赛季攻击加敏捷'] or 0
end,
['每秒加全属性'] = function(self)
    return self.owner.owner.cus_server['赛季每秒加全属性'] or 0
end,
['杀怪加智力'] = function(self)
    return self.owner.owner.cus_server['赛季杀怪加智力'] or 0
end,
['每秒加智力'] = function(self)
    return self.owner.owner.cus_server['赛季每秒加智力'] or 0
end,
['攻击加力量'] = function(self)
    return self.owner.owner.cus_server['赛季攻击加力量'] or 0
end,
['攻击加智力'] = function(self)
    return self.owner.owner.cus_server['赛季攻击加智力'] or 0
end,
}
