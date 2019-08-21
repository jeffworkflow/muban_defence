local mall = {
    {'JBLB','金币礼包'},
    {'MCLB','木材礼包'},
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


local mt = ac.skill['全赞助']
mt{
--等久
level = 0,
--图标
art = [[yjzz.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加88全属性，攻击加188全属性，每秒加588全属性
|cff00ffff杀敌数加成+30% 木头加成+30% 
物品获取率+30% 火灵加成+30% |r
|cffff0000攻击减甲+25 减少周围护甲1000|r

|cffffff00地图等级>=10，永久赞助的资源属性效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 88,
['攻击加全属性'] = 188,
['每秒加全属性'] = 588,
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
        local skl = hero:find_skill('全赞助',nil,true)
        skl:set_level(1)
    end    

end)
