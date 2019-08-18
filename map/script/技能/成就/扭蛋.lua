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
|cff00ff00+100w  全属性
+10%  吸血
+50W 攻击回血|r

]],
    ['吸血'] = 10,
    ['攻击回血'] = 500000,
    ['全属性'] = 1000000,
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
|cff00ff00+500w 全属性
+5%   暴击几率
+50%  暴击加深
+50%  物理伤害加深
|r

]],
    ['暴击加深'] = 50,
    ['暴击几率'] = 5,
    ['全属性'] = 5000000,
    ['物理伤害加深'] = 50,
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
|cff00ff00+100w  全属性
+5% 免伤几率
+5% 每秒回血|r

]],
    ['免伤几率'] = 5,
    ['每秒回血'] = 5,
    ['全属性'] = 1000000,
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
|cff00ff00+100w  全属性
+50% 分裂伤害
+50% 攻击速度|r

]],
    ['分裂伤害'] = 50,
    ['攻击速度'] = 50,
    ['全属性'] = 1000000,
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
|cff00ff00+2亿  攻击
-5000 护甲|r

]],
    ['攻击'] = 200000000,
    ['护甲'] = -5000,
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
|cff00ff00赠送10张藏宝图|r
|cff00ff00赠送100点挖宝积分|r
|cff00ff00获得特殊技能：自动寻宝（点击藏宝图试试）|r
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
|cff00ff00+7500w 攻击
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
    ['技暴加深'] = 50,
    ['全属性'] = 5000000,
}   


local mt = ac.skill['矮人的火枪']
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
    art = [[arhq.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+100w 全属性
+50   攻击距离
+15   攻击减甲|r

]],
    ['攻击距离'] = 50,
    ['攻击减甲'] = 15,
    ['全属性'] = 1000000,
}   



local mt = ac.skill['龙族血统']
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
    art = [[lzxt.blp]],
    tip = [[

|cffFFE799【扭蛋属性】：|r
|cff00ff00+500w 全属性
+10   每秒加护甲|r

]],
    ['每秒加护甲'] = 10,
    ['全属性'] = 5000000,
}   