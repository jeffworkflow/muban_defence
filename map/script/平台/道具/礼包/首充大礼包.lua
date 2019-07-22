local mt = ac.skill['首充大礼包']
mt{
--等久
level = 0,
--图标
art = [[scdlb.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加38全属性，攻击加68全属性，每秒加108全属性 
|cff00ffff杀敌数加成+15% 木头加成+15% 
物品获取率+15% 火灵加成+15% |r
|cffff0000对BOSS额外伤害+5%|r

|cffffff00地图等级>=7，首充大礼包的资源属性效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 38,
['攻击加全属性'] = 68,
['每秒加全属性'] = 108,
['杀敌数加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 15
    if map_level >= 7 then 
        value = 15 * 2
    end    
    return value 
end,
['木头加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 15
    if map_level >= 7 then 
        value = 15 * 2
    end    
    return value 
end,
['物品获取率'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 15
    if map_level >= 7 then 
        value = 15 * 2
    end    
    return value 
end,
['火灵加成'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    local value = 15
    if map_level >= 7 then 
        value = 15 * 2
    end    
    return value 
end,
['对BOSS额外伤害'] = 5,
}
