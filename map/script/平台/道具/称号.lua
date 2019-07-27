--称号
local mt = ac.skill['炉火纯青']
mt{
--等级
level = 0,
--图标
art = [[lhcq.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff青铜1星 

|cffFFE799【称号属性】：|r
|cff00ff00+15  杀怪加全属性|r
|cff00ff00+5%  杀敌数加成|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 15,
['杀敌数加成'] = 5,
need_map_level = 2,
--特效
effect = [[lhcq.mdx]]
}

local mt = ac.skill['势不可挡']
mt{
--等级
level = 0,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 20 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,

['杀怪加攻击'] = 50,
['护甲'] = 500,
['物品获取率'] = 10,
need_map_level = 3,
--特效
effect = [[sbkd.mdx]]
}

local mt = ac.skill['毁天灭地']
mt{
--等级
level = 0,
--图标
art = [[htmd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff黄金5星 

|cffFFE799【称号属性】：|r
|cff00ff00+30    杀怪加全属性|r
|cff00ff00+20%   物理伤害加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 30,
['物理伤害加深'] = 20,
need_map_level = 4,
--特效
effect = [[htmd.mdx]]
}

local mt = ac.skill['风驰电掣']
mt{
--等级
level = 0,
--图标
art = [[dfty.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff砖石10星 

|cffFFE799【称号属性】：|r
|cff00ff00+68   杀怪加全属性|r
|cff00ff00+20   攻击减甲|r
|cff00ff00+15%  物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['攻击减甲'] = 20,
['物品获取率'] = 15,
need_map_level = 6,
--特效
effect = [[fengjiws6 - 副本.mdx]]
}


local mt = ac.skill['君临天下']
mt{
--等级
level = 0,
--图标
art = [[jltx.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  100  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+250  杀怪加攻击|r
|cff00ff00+15%   全伤加深|r
|cff00ff00+25%   分裂伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 250,
['全伤加深'] = 15,
['分裂伤害'] = 25,
need_map_level = 7,

--特效
effect = [[jltx.mdx]]
}

local mt = ac.skill['无双魅影']
mt{
--等级
level = 0,
--图标
art = [[jstz.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff王者15星

|cffFFE799【称号属性】：|r
|cff00ff00+100 杀怪加全属性|r
|cff00ff00+5%  免伤|r
|cff00ff00+15%  全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['免伤'] = 5,
['全伤加深'] = 15,
need_map_level = 8,

--特效
effect = [[myws.mdx]]
}


local mt = ac.skill['神帝']
mt{
--等级
level = 0,
--图标
art = [[shendi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  250  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+500  杀怪加攻击|r
|cff00ff00+800  减少周围护甲|r
|cff00ff00-0.05 攻击间隔|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 500,
['减少周围护甲'] = 800,
['攻击间隔'] = -0.05,
need_map_level = 9,
--特效
effect = [[shendi.mdx]]
}

local mt = ac.skill['傲世天下']
mt{
--等级
level = 0,
--图标
art = [[wzgl.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  500  兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+268  杀怪加全属性|r
|cff00ff00+10%   免伤几率|r
|cff00ff00+10%   对BOSS额外伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['对BOSS额外伤害'] = 10,
['免伤几率'] = 10,
need_map_level = 10,
--特效
effect = [[vip.mdx]]
}


local mt = ac.skill['真龙天子']
mt{
--等级
level = 0,
--图标
art = [[zltz.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff商城购买自动激活

|cffFFE799【称号属性】：|r
|cff00ff00+488   杀怪加全属性|r
|cff00ff00+50%   每秒回血|r
|cff00ff00+200   攻击减甲|r
|cff00ff00+388%  全伤加深|r
|cff00ff00+10%   会心几率|r
|cff00ff00+100%  会心伤害|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 488,
['每秒回血'] = 50,
['攻击减甲'] = 200,
['全伤加深'] = 388,
['会心几率'] = 10,
['会心伤害'] = 100,
--特效
effect = [[zhenlongtianzi.mdx]]
}


for i,name in ipairs({'炉火纯青','势不可挡','毁天灭地','风驰电掣','君临天下','无双魅影','神帝','傲世天下','真龙天子'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_chenghao then 
            hero.effect_chenghao:remove()
        end     
        hero.effect_chenghao = hero:add_effect('overhead',self.effect)
    end    
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    