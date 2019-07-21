--商城武器
local mt = ac.skill['地图等级']
mt{
--等级
level = 1,
title = '地图等级(会更新)',
--图标
art = [[wuqi10.blp]],
--说明
tip = [[
等级 Lv 2	攻击加全属性 + 20，杀敌金币+50（通关N1效果翻倍）
等级 Lv 3	每秒加0.5护甲，每秒加全属性 + 250（通关N1效果翻倍）
等级 Lv 4	金币加成 + 25，杀敌数加成+10（通关N2效果翻倍）
等级 Lv 5	木头加成+10，火灵加成+10（通关N2效果翻倍）
等级 Lv 6	减少周围护甲+15 （通关N3效果翻倍）
等级 Lv 7	商城道具:限量首冲(如果已购买，资源属性效果翻倍)
等级 Lv 8	杀敌加全属性+50（通关N3效果翻倍）
等级 Lv 9	攻击减甲+15（通关N4效果翻倍）
等级 Lv 10	物爆加深+50（通关N4效果翻倍）
等级 Lv 11	技爆加深+50（通关N4效果翻倍）
等级 Lv 12	全身加深+5（通关N5效果翻倍）
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
        value = 10 * dw_star
    end    
    return value 
end,
['火灵加成'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['白银'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 5 then 
        value = 10 * dw_star
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
['杀敌加全属性'] =  function(self)
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
['物爆加深'] =  function(self)
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
['技爆加深'] =  function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local dw_star = (p.cus_server and p.cus_server['铂金'] or 0) > 0  and 2 or 1
    local value = 0
    if map_level >= 11 then 
        value = 50 * dw_star
    end    
    return value 
end,
--属性加成： 地图等级12 全身加深+5（通关N5效果翻倍）
['全身加深'] =  function(self)
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
