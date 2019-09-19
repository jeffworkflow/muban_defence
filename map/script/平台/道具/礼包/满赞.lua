local mall = {
    -- {'JBLB','金币礼包'},
    -- {'MCLB','木材礼包'},
    {'YJZZ','永久赞助'},
    {'YJCJZZ','永久超级赞助'},
    {'HDJ','皇帝剑'},
    {'HDD','皇帝刀'},
    {'JSYYY','绝世阳炎翼'},
    {'LHHMY','轮迴幻魔翼'},

    {'GL','骨龙'},
    {'XWK','小悟空'},

    {'YXZZB','至尊宝'},
    {'YXGL','鬼厉'},
    {'YXJX','剑仙'},
    {'YXZSB','剑仙直升包'},

    {'SXS','神仙水'},
    {'SZDLB','神装大礼包'},
    {'SJDLB','神技大礼包'},
    {'XBXFX','寻宝小飞侠'},
    
    {'GFQLLY','孤风青龙领域'},
    {'YYCLLY','远影苍龙领域'},

    {'ZLTZ','真龙天子'},
    {'BBDLB','百变英雄礼包'},
}


local mt = ac.skill['满赞']
mt{
--等久
level = 0,
--图标
art = [[quanzz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000购买全部商城道具|cffcccccc（新版/旧版齐天大圣、限量首充/首充大礼包 除外）|r后自动激活

|cffFFE799【满赞奖励】|r
|cff00ff00杀怪加全属性+888 攻击加全属性+888 每秒加全属性+888
|cff00ffff攻击减甲+888 减少周围护甲+1888
|cffffff00暴击加深+488% 技暴加深+488% 会心伤害+488%
|cffff0000物理伤害加深+488% 技能伤害加深+488% 全伤加深+488%

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 888,
['攻击加全属性'] = 888,
['每秒加全属性'] = 888,
['攻击减甲'] = 888,
['减少周围护甲'] = 1888,
['暴击加深'] = 488,
['技暴加深'] = 488,
['会心伤害'] = 488,
['物理伤害加深'] = 488,
['技能伤害加深'] = 488,
['全伤加深'] = 488,


}

ac.game:event '玩家-注册英雄' (function(_,p,hero)
    if not p.mall then 
        return 
    end
    local flag = true
    for i,data in ipairs(mall) do 
        local mall_name = data[2]
        if not p.mall[mall_name] or p.mall[mall_name] < 1  then 
            flag = false
            break
        end
    end        

    if flag then 
        local skl = hero:find_skill('满赞',nil,true)
        skl:set_level(1)
    end    

end)
