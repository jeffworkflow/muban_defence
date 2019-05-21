
local rect = require 'types.rect'
-- 传送 快速达到 兑换
ac.exchange_kill ={
    --商品名（map.table.单位.商店） = 属性名，数值，上限次数，耗费杀敌数，图标,说明
    ['杀敌数加成'] = {'杀敌数加成',5,2,10,[[sdsdh.blp]],'挑着boss'} ,
    ['木头加成'] = {'木头加成',5,20,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['攻速加成'] = {'攻击速度',5,20,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['溅射加成'] = {'溅射',5,20,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['杀怪+50力量'] = {'杀怪力量',50,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['杀怪+50敏捷'] = {'杀怪敏捷',50,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['杀怪+50智力'] = {'杀怪智力',50,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['杀怪+25全属性'] = {'杀怪全属性',25,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['杀怪+75攻击力'] = {'杀怪攻击',75,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
    ['杀怪+0.1护甲'] = {'杀怪护甲',0.1,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
}

for key,value in pairs(ac.exchange_kill) do 
    --物品名称
    local mt = ac.skill[key]
    mt{
    --等久
    level = 1,
    --图标
    art = value[5],
    --说明
    tip = value[6],
    --属性名
    attr_name = value[1],
    --属性值
    attr_val = value[2],
    --最大购买次数
    max_buy_cnt = value[3],
    --消耗
    kill_count = value[4],
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    --物品技能
    is_skill = true,
    auto_fresh_tip = true,
    }

    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        hero = p.hero
        
        local shop_item = ac.item.shop_item_map[self.name]
        if not shop_item.player_buy_cnt then 
            shop_item.player_buy_cnt = {}
        end
        shop_item.player_buy_cnt[p] = (shop_item.player_buy_cnt[p] or 1) + 1

        --增加属性
        hero:add(self.attr_name,self.attr_val)
        
    end

end    
