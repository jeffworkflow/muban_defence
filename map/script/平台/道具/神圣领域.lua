--称号
local mt = ac.skill['血雾领域']
mt{
--等级
level = 0,
--图标
art = [[xwly.blp]],
--说明
tip = [[

|cffffff00【要求地图等级>=%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝积分超过 5K 自动获得，已拥有积分：|r%wabao_cnt%

|cffFFE799【领域属性】：|r
|cff00ff00+25  杀怪加全属性|r
|cff00ff00+150  减少周围护甲|r
|cff00ff00+20%  物理伤害加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
wabao_cnt = function(self)
    local p = ac.player.self
    return p.cus_server['挖宝积分'] or 0
end,
['杀怪加全属性'] = 25,
['减少周围护甲'] = 150,
['物理伤害加深'] = 20,
need_map_level = 4,
--特效
effect = [[lingyu1.mdx]]
}

local mt = ac.skill['龙腾领域']
mt{
--等级
level = 0,
--图标
art = [[ltly.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff地图等级=%need_map_level%

|cffFFE799【领域属性】：|r
|cff00ff00+55  杀怪加全属性|r
|cff00ff00+300  减少周围护甲|r
|cff00ff00+40%  物理伤害加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

['杀怪加全属性'] = 55,
['减少周围护甲'] = 300,
['物理伤害加深'] = 40,
need_map_level = 13,
--特效
effect = [[lingyu13.mdx]]
}

local mt = ac.skill['飞沙热浪领域']
mt{
--等级
level = 0,
--图标
art = [[ftrl.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff地图等级=%need_map_level%

|cffFFE799【领域属性】：|r
|cff00ff00+75  杀怪加全属性|r
|cff00ff00+450  减少周围护甲|r
|cff00ff00+60%  物理伤害加深|r
|cff00ff00+5%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 75,
['减少周围护甲'] = 450,
['物理伤害加深'] = 60,
['全伤加深'] = 5,
need_map_level = 17,
--特效
effect = [[lingyu11.mdx]]
}


local mt = ac.skill['灵霄烟涛领域']
mt{
--等级
level = 0,
--图标
art = [[lxyt.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff地图等级=%need_map_level%

|cffFFE799【领域属性】：|r
|cff00ff00+98  杀怪加全属性|r
|cff00ff00+600  减少周围护甲|r
|cff00ff00+100%  物理伤害加深|r
|cff00ff00+10%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 98,
['减少周围护甲'] = 600,
['物理伤害加深'] = 100,
['全伤加深'] = 10,
need_map_level = 22,
--特效
effect = [[lingyu10.mdx]]
}


local mt = ac.skill['孤风青龙领域']
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
function mt:on_add()
    local p = self.owner:get_owner()
    if (p.mall and p.mall['远影苍龙领域'] or 0) >=1 then 
        p.more_unit = (p.more_unit or 0) + 5
    end    
end    

local mt = ac.skill['远影苍龙领域']
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

local mt = ac.skill['白云四海领域']
mt{
--等级
level = 0,
--图标
art = [[bysh.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff修罗模式|cffff0000累计|cff00ffff无尽波数=500波

|cffFFE799【领域属性】：|r
|cff00ff00+155  杀怪加全属性|r
|cff00ff00+25%  会心伤害|r
|cff00ff00+25%  技能伤害加深|r
|cff00ff00+25%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 155,
['会心伤害'] = 25,
['技能伤害加深'] = 25,
['全伤加深'] = 25,
need_map_level = 22,
--特效
effect = [[Rune Blue Aura.mdx]]
}

local mt = ac.skill['烈火金焰领域']
mt{
--等级
level = 0,
--图标
art = [[lhjyly.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff斗破苍穹 25星

|cffFFE799【领域属性】：|r
|cff00ff00+185  杀怪加全属性|r
|cff00ff00+750  减少周围护甲|r
|cff00ff00+15%  技能伤害加深|r
|cff00ff00+15%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 185,
['减少周围护甲'] = 750,
['技能伤害加深'] = 15,
['全伤加深'] = 15,
need_map_level = 25,
--特效
effect = [[az_kaer_t2_1.mdx]]
}

local mt = ac.skill['烈火天翔领域']
mt{
--等级
level = 0,
--图标
art = [[hlfsly.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff斗破苍穹|cffff0000累计|cff00ffff无尽波数=150波

|cffFFE799【领域属性】：|r
|cff00ff00+215  杀怪加全属性|r
|cff00ff00+900  减少周围护甲|r
|cff00ff00+20%  技能伤害加深|r
|cff00ff00+20%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 215,
['减少周围护甲'] = 900,
['技能伤害加深'] = 20,
['全伤加深'] = 20,
need_map_level = 24,
--特效
effect = [[TX_hjl.mdx]]
}

local mt = ac.skill['赤霞万象领域']
mt{
--等级
level = 0,
--图标
art = [[hsly.blp]],
--说明
tip = [[

|cffffe799【获得方式】：|r
|cff00ffff地图等级=%need_map_level%

|cffFFE799【领域属性】：|r
|cff00ff00+245  杀怪加全属性|r
|cff00ff00+1000  减少周围护甲|r
|cff00ff00+25%  暴击加深|r
|cff00ff00+25%  技暴加深|r
|cff00ff00+25%  会心伤害|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 245,
['减少周围护甲'] = 1000,
['暴击加深'] = 25,
['技暴加深'] = 25,
['会心伤害'] = 25,
need_map_level = 37,
--特效
effect = [[Rune Red.mdx]]
}

local mt = ac.skill['真武青焰领域']
mt{
--等级
level = 0,
--图标
art = [[zwqyly.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff无限乱斗|cffff0000累计|cff00ffff无尽波数=800波

|cffFFE799【领域属性】：|r
|cff00ff00+275  杀怪加全属性|r
|cff00ff00+1000  减少周围护甲|r
|cff00ff00+38%  物理伤害加深|r
|cff00ff00+38%  技能伤害加深|r
|cff00ff00+38%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 275,
['减少周围护甲'] = 1000,
['物理伤害加深'] = 38,
['技能伤害加深'] = 38,
['全伤加深'] = 38,
need_map_level = 39,
--特效
effect = [[AZ_LFGH01_ICE2.mdx]]
}

local mt = ac.skill['罗刹夜舞领域']
mt{
--等级
level = 0,
--图标
art = [[lcywly.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff深渊乱斗|cffff0000累计|cff00ffff无尽波数=800波

|cffFFE799【领域属性】：|r
|cff00ff00+300  杀怪加全属性|r
|cff00ff00+1000  减少周围护甲|r
|cff00ff00+38%  暴击加深|r
|cff00ff00+38%  技暴加深|r
|cff00ff00+38%  全伤加深|r

|cffff0000【点击可更换领域外观，所有领域属性可叠加】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 300,
['减少周围护甲'] = 1000,
['暴击加深'] = 38,
['技暴加深'] = 38,
['全伤加深'] = 38,
need_map_level = 42,
--特效
effect = [[2tx_91.mdx]]
}

for i,name in ipairs({'血雾领域','龙腾领域','飞沙热浪领域','灵霄烟涛领域','白云四海领域','烈火金焰领域','烈火天翔领域','赤霞万象领域','真武青焰领域','罗刹夜舞领域','孤风青龙领域','远影苍龙领域'}) do
    local mt = ac.skill[name]
    function mt:on_cast_start()
        local hero = self.owner
        local player = self.owner:get_owner()
        hero = player.hero 
        --改变外观，添加武器
        if hero.effect_lingyu then 
            hero.effect_lingyu:remove()
        end     
        hero.effect_lingyu = hero:add_effect('origin',self.effect)
    end    
    -- mt.on_add = mt.on_cast_start --自动显示特效
end    