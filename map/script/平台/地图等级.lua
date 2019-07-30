--地图等级
local mt = ac.skill['地图等级1']
mt{
--等级
level = 1,
title = function(self) return '|cffffe799地图等级(会更新) |r|cffff0000 '..self.map_level ..' 级|r' end,
is_order = 1,
--图标
art = [[ditudengji.blp]],
--说明
tip = [[

|cff00ff00等级Lv2 攻击加全属性+20，杀怪加金币+50
（通关青铜翻倍）
等级Lv3 每秒加护甲0.5，每秒加全属性+250
（通关青铜翻倍）
等级Lv4 金币加成+25% ，杀敌数加成+10%
（通关白银翻倍）
|cff00ffff等级Lv5 木头加成+7.5% ，火灵加成+7.5%
（通关白银翻倍）
等级Lv6 减少周围护甲+100（通关黄金翻倍）
|cffdf19d0等级Lv7 首充大礼包的资源属性翻倍
(条件：已购买首充大礼包)
|cffffff00等级Lv8 杀敌加全属性+50（通关黄金翻倍）
等级Lv9 攻击减甲+15（通关铂金翻倍）
等级Lv10 暴击加深+50%（通关铂金翻倍）
|cffdf19d0等级Lv10 永久赞助的资源属性翻倍
(条件：已购买永久赞助)
|cffffff00等级Lv11 技暴加深+50%（通关钻石翻倍）
等级Lv12 全伤加深+5%（通关钻石翻倍）

|cffffe799持续更新中
]],
map_level = function(self)
    local p = self.owner:get_owner()
    local res = p:Map_GetMapLevel()
    return res
end,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--属性加成： 地图等级2
['攻击加全属性'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['青铜'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 2 then 
        value = 20 * dw_star
    end    
    return value 
end,
['杀怪加金币'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['青铜'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 2 then 
        value = 50 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级3
['每秒加护甲'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['青铜'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 3 then 
        value = 0.5 * dw_star
    end    
    return value 
end,
['每秒加全属性'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['青铜'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 3 then 
        value = 250 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级4
--金币加成 + 25，杀敌数加成+10（通关N2效果翻倍）
['金币加成'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['白银'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 4 then 
        value = 25 * dw_star
    end    
    return value 
end,
['杀敌数加成'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['白银'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 4 then 
        value = 10 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级5
--木头加成+10，火灵加成+10（通关N2效果翻倍）
['木头加成'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['白银'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 5 then 
        value = 7.5 * dw_star
    end    
    return value 
end,
['火灵加成'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['白银'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 5 then 
        value = 7.5 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级6
--减少周围护甲+100 （通关N3效果翻倍）
['减少周围护甲'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['黄金'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 6 then 
        value = 100 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级7 限量首充资源加成翻倍
--属性加成： 地图等级8 杀敌加全属性+50（通关N3效果翻倍）
['杀怪加全属性'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['黄金'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 8 then 
        value = 50 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级9 攻击减甲+15（通关N4效果翻倍）
['攻击减甲'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['铂金'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 9 then 
        value = 15 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级10 物爆加深+50（通关N4效果翻倍）
['暴击加深'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['铂金'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 10 then 
        value = 50 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级11 技爆加深+50（通关N4效果翻倍）
['技暴加深'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['钻石'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 11 then 
        value = 50 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级12 全身加深+5（通关N5效果翻倍）
['全伤加深'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['钻石'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 12 then 
        value = 5 * dw_star
    end    
    return value 
end,

}


--商城武器
local mt = ac.skill['地图等级2']
mt{
--等级
level = 1,
title = function(self) return '|cffffe799地图等级(会更新) |r|cffff0000 '..self.map_level ..' 级|r' end,
is_order = 1,
--图标
art = [[ditudengji.blp]],
--说明
tip = [[

|cffff0000等级Lv14 龙腾领域（价值55元）
等级Lv17 飞沙热浪领域（价值75元）
等级Lv22 灵霄烟涛领域（价值98元）

|cffffe799持续更新中
]],
map_level = function(self)
    local p = self.owner:get_owner()
    local res = p:Map_GetMapLevel()
    return res
end,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

}
