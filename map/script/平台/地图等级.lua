--地图等级
local mt = ac.skill['地图等级1']
mt{
--等级
level = 1,
title = function(self) return '地图等级说明2' end,
is_order = 1,
--图标
art = [[xsgl.blp]],
--说明
tip = [[ 
|cff00ff00地图等级直接奖励额外属性|r

|cffffE7992级|r 奖励 |cff00ff00攻击加全属性+20，杀怪加金币+50
（通关青铜翻倍）
|cffffE7993级|r 奖励 |cff00ff00每秒加护甲0.5，每秒加全属性+250
（通关青铜翻倍）
|cffffE7994级|r 奖励 |cff00ff00金币加成+25% ，杀敌数加成+10%
（通关白银翻倍）
|cffffE7995级|r 奖励 |cff00ffff木头加成+7.5% ，火灵加成+7.5%
（通关白银翻倍）
|cffffE7996级|r 奖励 |cff00ffff减少周围护甲+100（通关黄金翻倍）
|cffffE7997级|r 奖励 |cff00ffff首充大礼包的资源属性翻倍
(条件：已购买首充大礼包)    
|cffffE7998级|r 奖励 |cffffff00杀敌加全属性+50（通关黄金翻倍）
|cffffE7999级|r 奖励 |cffffff00攻击减甲+15（通关铂金翻倍）
|cffffE79910级|r 奖励 |cffffff00暴击加深+50%（通关铂金翻倍）
|cffffE79910级|r 奖励 |cffff0000永久赞助的资源属性翻倍
(条件：已购买永久赞助)
|cffffE79911级|r 奖励 |cffff0000技暴加深+50%（通关钻石翻倍）
|cffffE79912级|r 奖励 |cffff0000全伤加深+5%（通关钻石翻倍）
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
title = function(self) return '地图等级说明3' end,
is_order = 1,
--图标
art = [[xsgl.blp]],
--说明
tip = [[

|cff00ff00更多地图等级奖励，请在基地右边的|cffffff00【游戏说明】|cff00ff00查看|r
 ]],
map_level = function(self)
    local p = self.owner:get_owner()
    local res = p:Map_GetMapLevel()
    return res
end,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}
function mt:on_add()
    local hero =self.owner
    if self.map_level >=16 then 
        local skl = hero:add_skill('神仙水','隐藏')
        skl:set_level(1)
    end    
    if self.map_level >=40 then 
        local skl = hero:add_skill('永久超级赞助','隐藏')
        skl:set_level(1)
    end  
    if self.map_level >=38 then   
        local skl = hero:add_skill('孤风青龙领域2','隐藏')
        skl:set_level(1)
    end  
    if self.map_level >=45 then   
        local skl = hero:add_skill('远影苍龙领域2','隐藏')
        skl:set_level(1)
    end 
    if self.map_level >=50 then   
        local skl = hero:add_skill('真龙天子2','隐藏')
        skl:set_level(1)
    end 
    if self.map_level >=55 then   
        local skl = hero:add_skill('齐天大圣B2','隐藏')
        skl:set_level(1)
    end 
    
end    

local mt = ac.skill['孤风青龙领域2']
mt{
--等级
level = 0,
--图标
art = [[qinglong.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【领域属性】：|r
|cff00ff00+228   杀怪加全属性|r
|cff00ff00+2280  减少周围护甲|r
|cff00ff00+100%  木头加成|r
|cff00ff00+100%  火灵加成|r
|cff00ffff+228%  全伤加深|r
|cff00ffff+5%    会心几率|r
|cff00ffff+50%   会心伤害|r
|cffffff00孤风青龙领域+远影苍龙领域激活：练功房怪物数量+5！

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 228,
['减少周围护甲'] = 2280,
['全伤加深'] = 228,
['会心几率'] = 5,
['会心伤害'] = 50,
['木头加成'] = 100,
['火灵加成'] = 100,

need_map_level = 2,
--特效
effect = [[lingyu5.mdx]]
}

local mt = ac.skill['远影苍龙领域2']
mt{
--等级
level = 0,
--图标
art = [[canglong.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【领域属性】：|r
|cff00ff00+388  杀怪加全属性|r
|cff00ff00+3880  减少周围护甲|r
|cff00ff00+100%  木头加成|r
|cff00ff00+100%  火灵加成|r
|cff00ffff+388%  全伤加深|r
|cff00ffff+5%  会心几率|r
|cff00ffff+50%  会心伤害|r
|cff00ffff+35%  对BOSS额外伤害|r
|cffffff00孤风青龙领域+远影苍龙领域激活：练功房怪物数量+5！

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 388,
['减少周围护甲'] = 3880,
['全伤加深'] = 388,
['会心几率'] = 5,
['会心伤害'] = 50,
['对BOSS额外伤害'] = 35,
['木头加成'] = 100,
['火灵加成'] = 100,

need_map_level = 2,
--特效
effect = [[lingyu8.mdx]]
}

local mt = ac.skill['真龙天子2']
mt{
--等级
level = 0,
--图标
art = [[canglong.blp]],
--说明
tip = [[
|cffFFE799【称号属性】：|r
|cff00ff00+488   杀怪加全属性|r
|cff00ff00+488   攻击减甲|r
|cff00ff00+488%  全伤加深|r
|cff00ffff+50%   每秒回血|r
|cff00ffff+10%  闪避|r
|cffff0000+15%   会心几率|r
|cffff0000+150%  会心伤害|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 488,
['攻击减甲'] = 488,
['全伤加深'] = 488,
['会心几率'] = 15,
['会心伤害'] = 150,
['闪避'] = 10,
['每秒回血'] = 50,

need_map_level = 2,
--特效
effect = [[lingyu8.mdx]]
}

local mt = ac.skill['齐天大圣B2']
mt{
is_skill = 1,
--等级
level = 0,
strong_hero = 1, --作用在人身上
title ='齐天大圣B（新版）',
--图标
art = [[cwqtds.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买后自动激活

|cffFFE799【宠物属性】：|r
|cff00ff00+488  杀怪加全属性|r
|cff00ff00+488  攻击减甲|r
|cff00ff00+488%  全伤加深|r
|cff00ffff+5%   会心几率|r
|cff00ffff+50%  会心伤害|r
|cffff0000+40 每秒加护甲|r
|cffff0000杀敌数额外+1|r
|cffff0000练功房怪物数量+3|r

|cffdf19d0【唯一被动】每秒减少宠物周围敌人血量的5%（对BOSS无效）

|cffffff00齐天大圣+真龙天子激活：攻击减甲+288，全伤加深+288%

|cffff0000【点击可更换宠物外观，所有宠物属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 488,
['攻击减甲'] = 488,
['全伤加深'] = 488,
['会心几率'] = 5,
['会心伤害'] = 150,
['每秒加护甲'] = 40,
['额外杀敌数'] = 1,  
--特效
effect = [[qtds.mdx]],
}