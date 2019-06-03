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
+10% 吸血
+500000 攻击回血
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
暴击几率+2.5%，暴击伤害+25%
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
        免伤几率+5%，每秒回血+5%
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
        分裂伤害+50%，攻击速度+50%
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
    +1亿攻击，-1W护甲
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
    art = [[bldp.blp]],
    tip = [[
   自动寻宝
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
+7500W攻击，-0.1攻击间隔
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
技暴几率+5%， 技暴伤害+50%， +500W全属性
    ]],
    ['技暴几率'] = 5,
    ['技暴伤害'] = 50,
    ['全属性'] = 5000000,
}   