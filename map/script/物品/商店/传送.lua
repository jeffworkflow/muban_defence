
local rect = require 'types.rect'
-- 传送 快速达到
ac.quick_arrive ={
    --商品名 = 目的区域,图标,说明,消费钱,消费木头
    ['神兵-凝脂剑'] = {ac.map.rects['传送-武器1'],'wuqi2.blp','\n挑战BOSS并获得|cff00ff00 【一阶神兵】-凝脂剑|r',0,20,0} ,
    ['神兵-元烟剑'] = {ac.map.rects['传送-武器2'],'wuqi18.blp','挑战BOSS并获得|cff00ff00 二阶神兵-元烟剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-暗影'] = {ac.map.rects['传送-武器3'],'wuqi20.blp','挑战BOSS并获得|cff00bdec 三阶神兵-暗影|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-青涛魔剑'] = {ac.map.rects['传送-武器4'],'wuqi19.blp','挑战BOSS并获得|cff00bdec 四阶神兵-青涛魔剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-青虹紫霄剑'] = {ac.map.rects['传送-武器5'],'wuqi7.blp','挑战BOSS并获得|cffffff00 五阶神兵-青虹紫霄剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-熔炉炎刀'] = {ac.map.rects['传送-武器6'],'wuqi4.blp','挑战BOSS并获得|cffffff00 六阶神兵-熔炉炎刀|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-紫炎光剑'] = {ac.map.rects['传送-武器7'],'wuqi6.blp','挑战BOSS并获得|cffff0000 七阶神兵-紫炎光剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-封神冰心剑'] = {ac.map.rects['传送-武器8'],'wuqi3.blp','挑战BOSS并获得|cffff0000八阶神兵-封神冰心剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-冰莲穿山剑'] = {ac.map.rects['传送-武器9'],'wuqi15.blp','挑战BOSS并获得|cffdf19d0 九阶神兵-冰莲穿山剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,
    ['神兵-十绝冰火剑'] = {ac.map.rects['传送-武器10'],'wuqi17.blp','挑战BOSS并获得|cffdf19d0 十阶神兵-十绝冰火剑|r\n\n|cffFFE799【神兵属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',500} ,

    ['神甲-芙蓉甲'] = {ac.map.rects['传送-甲1'],'jia1.blp','\n挑战BOSS并获得|cff00ff00 【一阶神甲】-芙蓉甲|r',0,20,0} ,
    ['神甲-鱼鳞甲'] = {ac.map.rects['传送-甲2'],'jia2.blp','挑战BOSS并获得|cff00ff00 二阶神甲-鱼鳞甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-碧云甲'] = {ac.map.rects['传送-甲3'],'jia3.blp','挑战BOSS并获得|cff00bdec 三阶神甲-碧云甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-青霞甲'] = {ac.map.rects['传送-甲4'],'jia4.blp','挑战BOSS并获得|cff00bdec 四阶神甲-青霞甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-飞霜辉铜甲'] = {ac.map.rects['传送-甲5'],'jia5.blp','挑战BOSS并获得|cffffff00 五阶神甲-飞霜辉铜甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-天魔苍雷甲'] = {ac.map.rects['传送-甲6'],'jia6.blp','挑战BOSS并获得|cffffff00 六阶神甲-天魔苍雷甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-金刚断脉甲'] = {ac.map.rects['传送-甲7'],'jia7.blp','挑战BOSS并获得|cffff0000 七阶神甲-金刚断脉甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-丹霞真元甲'] = {ac.map.rects['传送-甲8'],'jia8.blp','挑战BOSS并获得|cffff0000 八阶神甲-丹霞真元甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-血焰赤阳甲'] = {ac.map.rects['传送-甲9'],'jia9.blp','挑战BOSS并获得|cffdf19d0 九阶神甲-血焰赤阳甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,
    ['神甲-神魔蚀日甲'] = {ac.map.rects['传送-甲10'],'jia10.blp','挑战BOSS并获得|cffdf19d0 十阶神甲-神魔蚀日甲|r\n\n|cffFFE799【神甲属性】：|r|cff00ff00\n+4W 攻击\n+10% 攻速|r',0,20,0} ,

    ['技能升级lv1'] = {ac.map.rects['传送-技能1'],'','挑着boss'} ,
    ['技能升级lv2'] = {ac.map.rects['传送-技能2'],'','挑着boss'} ,
    ['技能升级lv3'] = {ac.map.rects['传送-技能3'],'','挑着boss'} ,
    ['技能升级lv4'] = {ac.map.rects['传送-技能4'],'','挑着boss'} ,
    


    ['挑战一号洗练石'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
    ['挑战二号洗练石'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
    ['挑战三号洗练石'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
    ['挑战四号洗练石'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,

    ['境界-小斗气'] = {ac.map.rects['传送-境界1'],'tupo1.blp','挑着boss',0,0,10} ,
    ['境界-斗者'] = {ac.map.rects['传送-境界2'],'tupo2.blp','挑着boss',0,0,10} ,
    ['境界-斗师'] = {ac.map.rects['传送-境界3'],'tupo3.blp','挑着boss',0,0,10} ,
    ['境界-斗灵'] = {ac.map.rects['传送-境界4'],'tupo4.blp','挑着boss',0,0,10} ,
    ['境界-斗王'] = {ac.map.rects['传送-境界5'],'tupo5.blp','挑着boss',0,0,10} ,
    ['境界-斗皇'] = {ac.map.rects['传送-境界6'],'tupo6.blp','挑着boss',0,0,10} ,
    ['境界-斗宗'] = {ac.map.rects['传送-境界7'],'tupo7.blp','挑着boss',0,0,10} ,
    ['境界-斗尊'] = {ac.map.rects['传送-境界8'],'tupo8.blp','挑着boss',0,0,10} ,
    ['境界-斗圣'] = {ac.map.rects['传送-境界9'],'tupo9.blp','挑着boss',0,0,10} ,
    ['境界-斗帝'] = {ac.map.rects['传送-境界10'],'tupo10.blp','挑着boss',0,0,10} ,
}


for key,value in pairs(ac.quick_arrive) do 

    --物品名称
    local mt = ac.skill[key]
    mt{
    --等久
    level = 1,
    --目的区域
    target_rect = value[1],
    --图标
    art = value[2],
    --说明
    tip = value[3],
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '|cffFFE799【任务说明】：|r',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '挑战 '
    }
    if value[4] then 
        mt.gold = value[4]
    end
    if value[5] then 
        mt.wood = value[5]
    end
    if value[6] then 
        mt.fire_seed = value[6]
    end
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local rect = self.target_rect
        -- print(rect)
        hero = p.hero
        hero:blink(rect,true,false,true)
    end

end    
