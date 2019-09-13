
local rect = require 'types.rect'
-- 传送 快速达到
ac.quick_arrive ={
    --商品名 = 目的区域,图标,说明,消费钱,消费木头，火灵，杀敌数，积分，商店名字
    ['神兵-凝脂剑'] = {ac.map.rects['传送-武器1'],'wuqi2.blp','\n挑战BOSS并获得|cff00ff00 【一阶神兵】-凝脂剑|r\n',0,20,0,0,0,} ,
    ['神兵-元烟剑'] = {ac.map.rects['传送-武器2'],'wuqi18.blp','\n挑战BOSS并获得|cff00ff00 【二阶神兵】-元烟剑|r\n',0,50,0} ,
    ['神兵-暗影'] = {ac.map.rects['传送-武器3'],'wuqi20.blp','\n挑战BOSS并获得|cff00ffff 【三阶神兵】-暗影|r\n',0,125,0} ,
    ['神兵-青涛魔剑'] = {ac.map.rects['传送-武器4'],'wuqi19.blp','\n挑战BOSS并获得|cff00ffff 【四阶神兵】-青涛魔剑|r\n',0,350,0} ,
    ['神兵-青虹紫霄剑'] = {ac.map.rects['传送-武器5'],'wuqi7.blp','\n挑战BOSS并获得|cffffff00 【五阶神兵】-青虹紫霄剑|r\n',0,1000,0} ,
    ['神兵-熔炉炎刀'] = {ac.map.rects['传送-武器6'],'wuqi4.blp','\n挑战BOSS并获得|cffffff00 【六阶神兵】-熔炉炎刀|r\n',0,2000,0} ,
    ['神兵-紫炎光剑'] = {ac.map.rects['传送-武器7'],'wuqi6.blp','\n挑战BOSS并获得|cffff0000 【七阶神兵】-紫炎光剑|r\n',0,4000,0} ,
    ['神兵-封神冰心剑'] = {ac.map.rects['传送-武器8'],'wuqi3.blp','\n挑战BOSS并获得|cffff0000 【八阶神兵】-封神冰心剑|r\n',0,8000,0} ,
    ['神兵-冰莲穿山剑'] = {ac.map.rects['传送-武器9'],'wuqi15.blp','\n挑战BOSS并获得|cffdf19d0 【九阶神兵】-冰莲穿山剑|r\n',0,10000,0} ,
    ['神兵-十绝冰火剑'] = {ac.map.rects['传送-武器10'],'wuqi17.blp','\n挑战BOSS并获得|cffdf19d0 【十阶神兵】-十绝冰火剑|r\n',0,14000,0} ,
    ['神兵-九幽白蛇剑'] = {ac.map.rects['传送-武器11'],'jybsj.blp','\n挑战BOSS并获得|cffdf19d0 【十一阶神兵】-九幽白蛇剑|r\n',0,20000,0} ,
    
    ['神甲-芙蓉甲'] = {ac.map.rects['传送-甲1'],'jia1.blp','\n挑战BOSS并获得|cff00ff00 【一阶神甲】-芙蓉甲|r\n',0,20,0} ,
    ['神甲-鱼鳞甲'] = {ac.map.rects['传送-甲2'],'jia2.blp','\n挑战BOSS并获得|cff00ff00 【二阶神甲】-鱼鳞甲|r\n',0,50,0} ,
    ['神甲-碧云甲'] = {ac.map.rects['传送-甲3'],'jia3.blp','\n挑战BOSS并获得|cff00ffff 【三阶神甲】-碧云甲|r\n',0,125,0} ,
    ['神甲-青霞甲'] = {ac.map.rects['传送-甲4'],'jia4.blp','\n挑战BOSS并获得|cff00ffff 【四阶神甲】-青霞甲|r\n',0,350,0} ,
    ['神甲-飞霜辉铜甲'] = {ac.map.rects['传送-甲5'],'jia5.blp','\n挑战BOSS并获得|cffffff00 【五阶神甲】-飞霜辉铜甲|r\n',0,1000,0} ,
    ['神甲-天魔苍雷甲'] = {ac.map.rects['传送-甲6'],'jia6.blp','\n挑战BOSS并获得|cffffff00 【六阶神甲】-天魔苍雷甲|r\n',0,2000,0} ,
    ['神甲-金刚断脉甲'] = {ac.map.rects['传送-甲7'],'jia7.blp','\n挑战BOSS并获得|cffff0000 【七阶神甲】-金刚断脉甲|r\n',0,4000,0} ,
    ['神甲-丹霞真元甲'] = {ac.map.rects['传送-甲8'],'jia8.blp','\n挑战BOSS并获得|cffff0000 【八阶神甲】-丹霞真元甲|r\n',0,8000,0} ,
    ['神甲-血焰赤阳甲'] = {ac.map.rects['传送-甲9'],'jia9.blp','\n挑战BOSS并获得|cffdf19d0 【九阶神甲】-血焰赤阳甲|r\n',0,10000,0} ,
    ['神甲-神魔蚀日甲'] = {ac.map.rects['传送-甲10'],'jia10.blp','\n挑战BOSS并获得|cffdf19d0 【十阶神甲】-神魔蚀日甲|r\n',0,14000,0} ,
    ['神甲-皇龙阴阳甲'] = {ac.map.rects['传送-甲11'],'syjhj.blp','\n挑战BOSS并获得|cffdf19d0 【十一阶神甲】-皇龙阴阳甲|r\n',0,20000,0} ,
    
    ['技能升级书lv1'] = {ac.map.rects['传送-技能1'],'jinengshengji1.blp','\n挑战BOSS并获得|cff00ff00 【技能升级书lv1】|r\n',0,75,0,0,0,nil,0,450} ,
    ['技能升级书lv2'] = {ac.map.rects['传送-技能2'],'jinengshengji2.blp','\n挑战BOSS并获得|cff00ffff 【技能升级书lv2】|r\n',0,500,0,0,0,nil,0,450} ,
    ['技能升级书lv3'] = {ac.map.rects['传送-技能3'],'jinengshengji3.blp','\n挑战BOSS并获得|cffffff00 【技能升级书lv3】|r\n',0,4000,0,0,0,nil,0,450} ,
    ['技能升级书lv4'] = {ac.map.rects['传送-技能4'],'jinengshengji4.blp','\n挑战BOSS并获得|cffff0000 【技能升级书lv4】|r\n',0,8000,0,0,0,nil,0,450} ,
    
    ['洗练石boss1'] = {ac.map.rects['传送-洗练石1'],'xilianshi.blp','\n挑战BOSS并获得|cff00ff00 【一号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,150,0,0,0,nil,0,450} ,
    ['洗练石boss2'] = {ac.map.rects['传送-洗练石2'],'xilianshi.blp','\n挑战BOSS并获得|cff00ffff 【二号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,1500,0,0,0,nil,0,450} ,
    ['洗练石boss3'] = {ac.map.rects['传送-洗练石3'],'xilianshi.blp','\n挑战BOSS并获得|cffffff00 【三号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,12000,0,0,0,nil,0,450} ,
    ['洗练石boss4'] = {ac.map.rects['传送-洗练石4'],'xilianshi.blp','\n挑战BOSS并获得|cffff0000 【四号洗练石】|r\n\n|cffcccccc【可洗练出装备的套装属性】|r',0,18000,0,0,0,nil,0,450} ,

    ['境界-小斗气'] = {ac.map.rects['传送-境界1'],'tupo1.blp','\n挑战BOSS并突破境界至|cff00ff00 【小斗气】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+200w 全属性\n+2.5%  免伤\n+2.5%  暴击几率\n+25%   暴击加深\n+10%    每秒回血\n|r',0,0,5000,0,0,nil,0,500} ,
    ['境界-斗者'] = {ac.map.rects['传送-境界2'],'tupo2.blp','\n挑战BOSS并突破境界至|cff00ff00 【斗者】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+300w 全属性\n+2.5%  闪避\n+2.5%  技暴几率\n+25%   技暴加深\n+5      攻击减甲\n|r',0,0,10000,0,0,nil,0,500} ,
    ['境界-斗师'] = {ac.map.rects['传送-境界3'],'tupo3.blp','\n挑战BOSS并突破境界至|cff00ffff 【斗师】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+400w 全属性\n+2.5%  免伤几率\n+2.5%  全伤加深\n+5%    触发概率加成\n|r',0,0,20000,0,0,nil,0,500} ,
    ['境界-斗灵'] = {ac.map.rects['传送-境界4'],'tupo4.blp','\n挑战BOSS并突破境界至|cff00ffff 【斗灵】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+500w 全属性\n+2.5%  免伤\n+2.5%  暴击几率\n+25%   暴击加深\n-5%    技能冷却\n|r',0,0,30000,0,0,nil,0,500} ,
    ['境界-斗王'] = {ac.map.rects['传送-境界5'],'tupo5.blp','\n挑战BOSS并突破境界至|cffffff00 【斗王】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+600w 全属性\n+2.5%  闪避\n+2.5%  技暴几率\n+25%   技暴加深\n+5      攻击减甲\n|r',0,0,40000,0,0,nil,0,500} ,
    ['境界-斗皇'] = {ac.map.rects['传送-境界6'],'tupo6.blp','\n挑战BOSS并突破境界至|cffffff00 【斗皇】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+700w 全属性\n+2.5%  免伤几率\n+2.5%  全伤加深\n+5%    触发概率加成\n|r',0,0,50000,0,0,nil,0,0} ,
    ['境界-斗宗'] = {ac.map.rects['传送-境界7'],'tupo7.blp','\n挑战BOSS并突破境界至|cffff0000 【斗宗】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+750w 全属性\n+2.5%  免伤\n+2.5%  暴击几率\n+25%   暴击加深\n-5%    技能冷却\n|r',0,0,60000,0,0,nil,0,500} ,
    ['境界-斗尊'] = {ac.map.rects['传送-境界8'],'tupo8.blp','\n挑战BOSS并突破境界至|cffff0000 【斗尊】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+800w 全属性\n+2.5%  闪避\n+2.5%  技暴几率\n+25%   技暴加深\n+5      攻击减甲\n|r',0,0,70000,0,0,nil,0,500} ,
    ['境界-斗圣'] = {ac.map.rects['传送-境界9'],'tupo9.blp','\n挑战BOSS并突破境界至|cffdf19d0 【斗圣】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+850w 全属性\n+2.5%  免伤几率\n+2.5%  全伤加深\n-0.05   攻击间隔\n|r',0,0,80000,0,0,nil,0,500} ,
    ['境界-斗帝'] = {ac.map.rects['传送-境界10'],'tupo10.blp','\n挑战BOSS并突破境界至|cffdf19d0 【斗帝】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+1000w 全属性\n+5%    全伤加深\n|r',0,0,100000,0,0,nil,0,500} ,
    ['境界-斗神'] = {ac.map.rects['传送-境界11'],'doushen.blp','\n挑战BOSS并突破境界至|cffdf19d0 【斗神】|r\n\n|cffFFE799【境界属性】：|r\n|cff00ff00+1500w 全属性\n+5%    对BOSS额外伤害\n|r',0,0,150000,0,0,nil,0,500} ,

    ['伏地魔'] = {ac.map.rects['传送-伏地魔'],'xianglian402.blp','\n满足一定条件后，战胜伏地魔，可获得|cffff0000顶级的紫金碧玺佩|r\n',0,100000,0} ,

    ['星星之火 '] = {ac.map.rects['传送-星星之火'],'huo1.blp','\n前往火焰熔炉，杀死守卫和boss，获得|cff00ff00初级异火：星星之火|r\n',0,0,20000,} ,
    ['陨落心炎 '] = {ac.map.rects['传送-陨落心炎'],'huo2.blp','\n前往火焰熔炉，杀死守卫和boss，获得|cff00ffff中级异火：陨落心炎火|r\n',0,0,40000,} ,
    ['三千焱炎火 '] = {ac.map.rects['传送-三千焱炎火'],'huo3.blp','\n前往火焰熔炉，杀死守卫和boss，获得|cffffff00高级异火：三千焱炎火|r\n',0,0,70000,} ,
    ['虚无吞炎 '] = {ac.map.rects['传送-虚无吞炎'],'huo4.blp','\n前往火焰熔炉，杀死守卫和boss，获得|cffff0000顶级异火：虚无吞炎|r\n',0,0,100000,} ,
    ['陀舍古帝 '] = {ac.map.rects['传送-陀舍古帝'],'tsgd.blp','\n前往杀死陀舍古帝的守卫，获得|cffff0000神级异火：陀舍古帝|r\n',0,0,150000,} ,
    ['无尽火域 '] = {ac.map.rects['传送-无尽火域'],'wjhy.blp','\n前往杀死无尽火域的守卫，获得|cffff0000神级异火：无尽火域|r\n',0,0,200000,} ,

    ['藏宝图 '] = {ac.map.rects['藏宝图 '],'cangbaotu.blp','\n前往藏宝区，杀死强盗和boss，获得|cff00ff00藏宝图|r\n\n|cff00ff00使用藏宝图可以获得大量挖宝积分|r|cffcccccc（搭配商城道具:寻宝小达人效果更佳）|r\n|cffffE799每点积分|r 奖励 |cff00ff00200全属性(属性永久存档 上限受地图等级影响)\n|cffffE799积分超过2000|r 奖励 |cff00ff00【称号】势不可挡（价值15元）\n|cffffE799积分超过5000|r 奖励 |cff00ffff【领域】血雾领域（价值25元）\n|cffffE799积分超过10000|r 奖励 |cff00ffff【宠物皮肤】冰龙（价值38元）\n|cffffE799积分超过20000|r 奖励 |cffffff00【神器】霸王莲龙锤（价值68元）\n|cffffE799积分超过30000|r 奖励 |cffff0000【翅膀】梦蝶仙翼（价值88元）\n',0,0,0,0} ,
    ['红发'] = {ac.map.rects['传送-红发'],'hongfa.blp','\n挑战四皇之一，并获得|cffff0000恶魔果实合成材料：格里芬|r\n',0,66666,0} ,
    ['黑胡子'] = {ac.map.rects['传送-黑胡子'],'heihuzi.blp','\n挑战四皇之一，并获得|cffff0000恶魔果实合成材料：黑暗项链|r\n',0,66666,0} ,
    ['百兽'] = {ac.map.rects['传送-百兽'],'baishou.blp','\n挑战四皇之一，并获得|cffff0000恶魔果实合成材料：最强生物心脏|r\n',0,66666,0} ,
    ['白胡子'] = {ac.map.rects['传送-白胡子'],'baihuzi.blp','\n挑战四皇之一，并获得|cffff0000恶魔果实合成材料：白胡子的大刀|r\n',0,66666,0} ,
    
    ['替天行道'] = {ac.map.rects['传送-替天行道'],'ttxd.blp','\n请大侠|cff00ffff闲暇的时候|r前往袭击食人魔，有几率获得|cff00ffff勇士徽章（可存档）|r\n\n|cffcccccc建议最后挑战|r',0,0,0,1000} ,
    
    ['物品吞噬极限'] = {ac.map.rects['传送-吞噬极限'],'tsjx.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000物品吞噬极限+1|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,
    ['技能强化极限'] = {ac.map.rects['传送-强化极限'],'jnqh.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000技能强化极限+1|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,
    ['暴击几率极限'] = {ac.map.rects['传送-暴击几率'],'bjjl.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000暴击几率+5%（无视暴击几率上限）|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,
    ['免伤几率极限'] = {ac.map.rects['传送-免伤几率'],'msjl.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000免伤几率+5%（无视免伤几率上限）|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,

    ['技暴几率极限'] = {ac.map.rects['传送-技暴几率'],'jbjx.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000技暴几率+5%（无视技暴几率上限）|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,
    ['闪避极限'] = {ac.map.rects['传送-闪避'],'sbjx.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000闪避+5%（无视闪避上限）|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,
    
    ['会心几率极限'] = {ac.map.rects['传送-会心几率'],'hxjx.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000会心几率+5%（无视会心几率上限）|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,
    ['免伤极限'] = {ac.map.rects['传送-免伤'],'msjx.blp','\n前往杀死|cff00ffff极限守卫和BOSS|r，奖励|cffff0000免伤+5%（无视免伤上限）|r\n\n|cffcccccc限时三分钟，尽最大努力，超越最强极限。|r',0,0,666666} ,

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
    mt.store_name = '|cffdf19d0挑战 |r' .. key
    if value[9] then 
        --商店名
        mt.store_name = value[9]
    end
   
    if key == '星星之火 ' then 
        mt.type_id ='EX02'
    end


    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local rect = self.target_rect
        -- print(rect)
        hero = p.hero
        hero:blink(rect,true,false)
        
        local x,y=hero:get_point():get()

        p:setCamera(ac.point(x+(value[10] or 0),y+(value[11] or 0)))

        --开始进行特殊处理 
        if finds(key,'物品吞噬极限','技能强化极限','暴击几率极限','免伤几率极限','技暴几率极限','闪避极限','会心几率极限','免伤极限') then 
            --开始刷怪
            ac.creep[key]:start()
            --倒计时
            if not ac.flag_jixian then
                ac.flag_jixian={}
            end    
            if ac.flag_jixian[key] then 
                ac.flag_jixian[key]:remove()
            end    
            ac.flag_jixian[key] = ac.timer_ex 
            {
                time = 3*60, 
                -- time = 30,  --测试
                title = key.."区,关闭倒计时：",
                func = function ()
                    --关闭刷怪
                    local crep = ac.creep[key] 
                    crep:finish(true)
                    ac.flag_jixian[key] = nil
                    --传送英雄出去
                    -- hero:blink(ac.map.rects['主城'],true,false,true) --不需要传送出去
                end,
            }
        end    

    end

end    
