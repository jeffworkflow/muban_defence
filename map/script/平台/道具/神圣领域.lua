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
need_map_level = 14,
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
|cff00ff00+150%  木头加成|r
|cff00ff00+150%  火灵加成|r
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
['木头加成'] = 150,
['火灵加成'] = 150,

need_map_level = 2,
--特效
effect = [[lingyu5.mdx]]
}
function mt:on_add()
    local p = self.owner:get_owner()
    if (p.mall and p.mall['远影苍龙领域'] or 0) >=1 then 
        p.flag_more_unit = true
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
|cff00ff00+150%  木头加成|r
|cff00ff00+150%  火灵加成|r
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
['木头加成'] = 150,
['火灵加成'] = 150,

need_map_level = 2,
--特效
effect = [[lingyu8.mdx]]
}



for i,name in ipairs({'血雾领域','龙腾领域','飞沙热浪领域','灵霄烟涛领域','孤风青龙领域','远影苍龙领域'}) do
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