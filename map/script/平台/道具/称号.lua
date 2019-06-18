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
|cff00ff00+5%  吸血|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 15,
['吸血'] = 5,
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
|cff00ffff挖宝积分超过 2.5W 自动获得，已拥有积分：|r%skin_cnt% 或者
|cff00ffff消耗勇士徽章  20  兑换获得，已拥有徽章：|r%skin_cnt%

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+250  护甲|r
|cff00ff00+2500 伤害减少|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 50,
['护甲'] = 250,
['伤害减少'] = 2500,
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
|cff00ff00+2.5%  暴击几率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 30,
['暴击几率'] = 2.5,
need_map_level = 4,
--特效
effect = [[htmd.mdx]]
}

local mt = ac.skill['巅峰天域']
mt{
--等级
level = 0,
--图标
art = [[dfty.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff砖石15星 

|cffFFE799【称号属性】：|r
|cff00ff00+68    杀怪加全属性|r
|cff00ff00+2.5%  技暴几率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['技暴几率'] = 2.5,
need_map_level = 6,
--特效
effect = [[dfty.mdx]]
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
|cff00ffff消耗勇士徽章  200  兑换获得，已拥有徽章：|r%skin_cnt%

|cffFFE799【称号属性】：|r
|cff00ff00+250  杀怪加攻击|r
|cff00ff00+5%   全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 250,
['全伤加深'] = 5,
need_map_level = 7,

--特效
effect = [[jltx.mdx]]
}

local mt = ac.skill['九世天尊']
mt{
--等级
level = 0,
--图标
art = [[jstz.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff王者30星 

|cffFFE799【称号属性】：|r
|cff00ff00+100 杀怪加全属性|r
|cff00ff00+5%  免伤|r
|cff00ff00+5%  全伤加深|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 100,
['免伤'] = 5,
['全伤加深'] = 5,
need_map_level = 8,

--特效
effect = [[jstz.mdx]]
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
|cff00ffff消耗勇士徽章  500  兑换获得，已拥有徽章：|r%skin_cnt%

|cffFFE799【称号属性】：|r
|cff00ff00+500  杀怪加攻击|r
|cff00ff00+5%   暴击几率|r
|cff00ff00-0.05 攻击间隔|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 500,
['暴击几率'] = 5,
['攻击间隔'] = -0.05,
need_map_level = 9,
--特效
effect = [[shendi.mdx]]
}

local mt = ac.skill['王者归来']
mt{
--等级
level = 0,
--图标
art = [[wzgl.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗勇士徽章  1000  兑换获得，已拥有徽章：|r%skin_cnt%

|cffFFE799【称号属性】：|r
|cff00ff00+268  杀怪加全属性|r
|cff00ff00+5%   免伤几率|r
|cff00ff00+5%   技暴几率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加攻击'] = 750,
['技暴几率'] = 5,
['免伤几率'] = 5,
need_map_level = 10,
--特效
effect = [[wzgl.mdx]]
}


for i,name in ipairs({'炉火纯青','势不可挡','毁天灭地','巅峰天域','君临天下','九世天尊','神帝','王者归来'}) do
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
    mt.on_add = mt.on_cast_start
end    