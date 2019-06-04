
local rect = require 'types.rect'
-- 传送 快速达到
ac.quick_arrive ={
    --商品名 = 目的区域,图标,说明,消费钱,消费木头，火种，杀敌数，积分，商店名字
    ['神兵-凝脂剑'] = {ac.map.rects['传送-武器1'],'wuqi2.blp','\n挑战BOSS并获得|cff00ff00 【一阶神兵】-凝脂剑|r\n',0,20,0,0,0,} ,
    ['神兵-元烟剑'] = {ac.map.rects['传送-武器2'],'wuqi18.blp','\n挑战BOSS并获得|cff00ff00 【二阶神兵】-元烟剑|r\n',0,75,0} ,
    ['神兵-暗影'] = {ac.map.rects['传送-武器3'],'wuqi20.blp','\n挑战BOSS并获得|cff00ffff 【三阶神兵】-暗影|r\n',0,150,0} ,
    ['神兵-青涛魔剑'] = {ac.map.rects['传送-武器4'],'wuqi19.blp','\n挑战BOSS并获得|cff00ffff 【四阶神兵】-青涛魔剑|r\n',0,500,0} ,
    ['神兵-青虹紫霄剑'] = {ac.map.rects['传送-武器5'],'wuqi7.blp','\n挑战BOSS并获得|cffffff00 【五阶神兵】-青虹紫霄剑|r\n',0,1500,0} ,
    ['神兵-熔炉炎刀'] = {ac.map.rects['传送-武器6'],'wuqi4.blp','\n挑战BOSS并获得|cffffff00 【六阶神兵】-熔炉炎刀|r\n',0,3000,0} ,
    ['神兵-紫炎光剑'] = {ac.map.rects['传送-武器7'],'wuqi6.blp','\n挑战BOSS并获得|cffff0000 【七阶神兵】-紫炎光剑|r\n',500} ,
    ['神兵-封神冰心剑'] = {ac.map.rects['传送-武器8'],'wuqi3.blp','\n挑战BOSS并获得|cffff0000 【八阶神兵】-封神冰心剑|r\n',500} ,
    ['神兵-冰莲穿山剑'] = {ac.map.rects['传送-武器9'],'wuqi15.blp','\n挑战BOSS并获得|cffdf19d0 【九阶神兵】-冰莲穿山剑|r\n',500} ,
    ['神兵-十绝冰火剑'] = {ac.map.rects['传送-武器10'],'wuqi17.blp','\n挑战BOSS并获得|cffdf19d0 【十阶神兵】-十绝冰火剑|r\n',500} ,

    ['神甲-芙蓉甲'] = {ac.map.rects['传送-甲1'],'jia1.blp','\n挑战BOSS并获得|cff00ff00 【一阶神甲】-芙蓉甲|r\n',0,20,0} ,
    ['神甲-鱼鳞甲'] = {ac.map.rects['传送-甲2'],'jia2.blp','\n挑战BOSS并获得|cff00ff00 【二阶神甲】-鱼鳞甲|r\n',0,75,0} ,
    ['神甲-碧云甲'] = {ac.map.rects['传送-甲3'],'jia3.blp','\n挑战BOSS并获得|cff00ffff 【三阶神甲】-碧云甲|r\n',0,150,0} ,
    ['神甲-青霞甲'] = {ac.map.rects['传送-甲4'],'jia4.blp','\n挑战BOSS并获得|cff00ffff 【四阶神甲】-青霞甲|r\n',0,500,0} ,
    ['神甲-飞霜辉铜甲'] = {ac.map.rects['传送-甲5'],'jia5.blp','\n挑战BOSS并获得|cffffff00 【五阶神甲】-飞霜辉铜甲|r\n',0,1500,0} ,
    ['神甲-天魔苍雷甲'] = {ac.map.rects['传送-甲6'],'jia6.blp','\n挑战BOSS并获得|cffffff00 【六阶神甲】-天魔苍雷甲|r\n',0,3000,0} ,
    ['神甲-金刚断脉甲'] = {ac.map.rects['传送-甲7'],'jia7.blp','\n挑战BOSS并获得|cffff0000 【七阶神甲】-金刚断脉甲|r\n',0,20,0} ,
    ['神甲-丹霞真元甲'] = {ac.map.rects['传送-甲8'],'jia8.blp','\n挑战BOSS并获得|cffff0000 【八阶神甲】-丹霞真元甲|r\n',0,20,0} ,
    ['神甲-血焰赤阳甲'] = {ac.map.rects['传送-甲9'],'jia9.blp','\n挑战BOSS并获得|cffdf19d0 【九阶神甲】-血焰赤阳甲|r\n',0,20,0} ,
    ['神甲-神魔蚀日甲'] = {ac.map.rects['传送-甲10'],'jia10.blp','\n挑战BOSS并获得|cffdf19d0 【十阶神甲】-神魔蚀日甲|r\n',0,20,0} ,

    ['技能升级书lv1'] = {ac.map.rects['传送-技能1'],'jinengshengji1.blp','\n挑战BOSS并获得|cff00ff00 【技能升级书lv1】|r\n',0,100,0,0,0,nil,0,450} ,
    ['技能升级书lv2'] = {ac.map.rects['传送-技能2'],'jinengshengji1.blp','\n挑战BOSS并获得|cff00ffff 【技能升级书lv2】|r\n',0,1000,0,0,0,nil,0,450} ,
    ['技能升级书lv3'] = {ac.map.rects['传送-技能3'],'jinengshengji1.blp','\n挑战BOSS并获得|cffffff00 【技能升级书lv3】|r\n',0,10000,0,0,0,nil,0,450} ,
    ['技能升级书lv4'] = {ac.map.rects['传送-技能4'],'jinengshengji1.blp','\n挑战BOSS并获得|cffff0000 【技能升级书lv4】|r\n',0,100000,0,0,0,nil,0,450} ,
    
    ['洗练石boss1'] = {ac.map.rects['传送-洗练石1'],'xilianshi.blp','\n挑战BOSS并获得|cff00ff00 【一号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,200,0,0,0,nil,0,450} ,
    ['洗练石boss2'] = {ac.map.rects['传送-洗练石2'],'xilianshi.blp','\n挑战BOSS并获得|cff00ffff 【二号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,2000,0,0,0,nil,0,450} ,
    ['洗练石boss3'] = {ac.map.rects['传送-洗练石3'],'xilianshi.blp','\n挑战BOSS并获得|cffffff00 【三号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,20000,0,0,0,nil,0,450} ,
    ['洗练石boss4'] = {ac.map.rects['传送-洗练石4'],'xilianshi.blp','\n挑战BOSS并获得|cffff0000 【四号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,200000,0,0,0,nil,0,450} ,

    ['境界-小斗气'] = {ac.map.rects['传送-境界1'],'tupo1.blp','\n挑战BOSS并突破境界至|cff00ff00 【小斗气】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+200w 全属性\n-10%   技能冷却\n+10%   每秒回血\n+2.5%  暴击几率\n+25%   暴击加深\n|r',0,0,1000,0,0,nil,0,450} ,
    ['境界-斗者'] = {ac.map.rects['传送-境界2'],'tupo2.blp','\n挑战BOSS并突破境界至|cff00ff00 【斗者】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+300w 全属性\n+2.5%  免伤\n+2.5%  闪避\n+10%   触发概率加成\n|r',0,0,5000,0,0,nil,0,450} ,
    ['境界-斗师'] = {ac.map.rects['传送-境界3'],'tupo3.blp','\n挑战BOSS并突破境界至|cff00ffff 【斗师】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,0} ,
    ['境界-斗灵'] = {ac.map.rects['传送-境界4'],'tupo4.blp','\n挑战BOSS并突破境界至|cff00ffff 【斗灵】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
    ['境界-斗王'] = {ac.map.rects['传送-境界5'],'tupo5.blp','\n挑战BOSS并突破境界至|cffffff00 【斗王】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
    ['境界-斗皇'] = {ac.map.rects['传送-境界6'],'tupo6.blp','\n挑战BOSS并突破境界至|cffffff00 【斗皇】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
    ['境界-斗宗'] = {ac.map.rects['传送-境界7'],'tupo7.blp','\n挑战BOSS并突破境界至|cffff0000 【斗宗】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
    ['境界-斗尊'] = {ac.map.rects['传送-境界8'],'tupo8.blp','\n挑战BOSS并突破境界至|cffff0000 【斗尊】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
    ['境界-斗圣'] = {ac.map.rects['传送-境界9'],'tupo9.blp','\n挑战BOSS并突破境界至|cffdf19d0 【斗圣】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
    ['境界-斗帝'] = {ac.map.rects['传送-境界10'],'tupo10.blp','\n挑战BOSS并突破境界至|cffdf19d0 【斗帝】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,0,10,0,0,nil,0,500} ,
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
    content_tip = '|cffFFE799【任务说明】：|r\n',
    --物品技能
    is_skill = true,
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
    if value[7] then 
        mt.kill_count = value[7]
    end
    
    if value[8] then 
        mt.jifen = value[8]
    end
    -- if value[9] then 
        --商店名
        mt.store_name = '|cffdf19d0挑战 |r' .. key
    -- end
   


    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local rect = self.target_rect
        -- print(rect)
        hero = p.hero
        hero:blink(rect,true,false)
        
        local x,y=hero:get_point():get()

        p:setCamera(ac.point(x+(value[10] or 0),y+(value[11] or 0)))
    end

end    
