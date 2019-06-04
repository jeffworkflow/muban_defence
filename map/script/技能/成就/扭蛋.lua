local mt = ac.skill['红色小水滴']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[hsxsd.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+10%  吸血
+50W 攻击回血|r

]],
    ['吸血'] = 10,
    ['攻击回血'] = 500000,
}

local mt = ac.skill['发光的蓝色灰烬']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[fgdlshj.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+2.5% 暴击几率
+25% 暴击伤害|r

]],
    ['暴击几率'] = 2.5,
    ['暴击伤害'] = 25,
}

local mt = ac.skill['发光的草药']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[fgdyc.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+5% 免伤几率
+5% 每秒回血|r

]],
    ['免伤几率'] = 5,
    ['每秒回血'] = 5,
}

local mt = ac.skill['奇美拉的头颅']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[ReplaceableTextures\CommandButtons\BTNChimaera.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+50% 分裂伤害
+50% 攻击速度|r

]],
    ['分裂伤害'] = 50,
    ['攻击速度'] = 50,
}

--====================高级扭蛋成就===================

local mt = ac.skill['玻璃大炮']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[bldp.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+1亿 攻击
-1w 护甲|r

]],
    ['攻击'] = 1000000000,
    ['护甲'] = -10000,
}

local mt = ac.skill['黄金罗盘']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[hjlp.blp]],
    tip = [[
|cffFFE799【扭蛋属性】：|r
|cff00ff00自动寻宝|r

]],
}
function mt:on_add()
    print('自动寻宝')
end 

local mt = ac.skill['诸界的毁灭者']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[zsdhmz.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00
+7500w 攻击
-0.1     攻击间隔|r

]],
    ['攻击'] = 75000000,
    ['攻击间隔'] = -0.1,
}   

local mt = ac.skill['末日的钟摆']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[mrzb.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+500w 全属性
+5%    技暴几率
+50%  技暴加深|r

]],
    ['技暴几率'] = 5,
    ['技暴伤害'] = 50,
    ['全属性'] = 5000000,
}   