
local rect = require 'types.rect'
-- 传送 快速达到
ac.quick_arrive ={
    --商品名 = 目的区域,图标,说明,消费钱,消费木头
    ['神兵挑战-凝脂剑'] = {ac.map.rects['传送-武器1'],'wuqi2.blp','挑着boss',500} ,
    ['神兵挑战-元烟剑'] = {ac.map.rects['传送-武器2'],'wuqi18.blp','挑着boss',500} ,
    ['神兵挑战-暗影'] = {ac.map.rects['传送-武器3'],'wuqi20.blp','挑着boss',500} ,
    ['神兵挑战-青涛魔剑'] = {ac.map.rects['传送-武器4'],'wuqi19.blp','挑着boss',500} ,
    ['神兵挑战-青虹紫霄剑'] = {ac.map.rects['传送-武器5'],'wuqi7.blp','挑着boss',500} ,
    ['神兵挑战-熔炉炎刀'] = {ac.map.rects['传送-武器6'],'wuqi4.blp','挑着boss',500} ,
    ['神兵挑战-紫炎光剑'] = {ac.map.rects['传送-武器7'],'wuqi6.blp','挑着boss',500} ,
    ['神兵挑战-封神冰心剑'] = {ac.map.rects['传送-武器8'],'wuqi3.blp','挑着boss',500} ,
    ['神兵挑战-冰莲穿山剑'] = {ac.map.rects['传送-武器9'],'wuqi15.blp','挑着boss',500} ,
    ['神兵挑战-十绝冰火剑'] = {ac.map.rects['传送-武器10'],'wuqi17.blp','挑着boss',500} ,

    ['防具boss1'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss2'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss3'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss4'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss5'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss6'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss7'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss8'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss9'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,
    ['防具boss10'] = {ac.map.rects['传送-甲1'],'','挑着boss'} ,

    ['技能BOSS1'] = {ac.map.rects['传送-技能1'],'','挑着boss'} ,
    ['技能BOSS2'] = {ac.map.rects['传送-技能1'],'','挑着boss'} ,
    ['技能BOSS3'] = {ac.map.rects['传送-技能1'],'','挑着boss'} ,
    ['技能BOSS4'] = {ac.map.rects['传送-技能1'],'','挑着boss'} ,
    
    ['洗练石boss1'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
    ['洗练石boss2'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
    ['洗练石boss3'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
    ['洗练石boss4'] = {ac.map.rects['传送-洗练石1'],'','挑着boss'} ,
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
    content_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = ''
    }
    if value[4] then 
        mt.gold = value[4]
    end
    if value[5] then 
        mt.wood = value[5]
    end
    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local rect = self.target_rect
        -- print(rect)
        hero:blink(rect,true,false,true)
    end

end    
