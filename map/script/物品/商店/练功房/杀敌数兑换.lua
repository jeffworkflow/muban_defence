
local rect = require 'types.rect'
-- 杀敌数兑换
-- 传送 快速达到 兑换
ac.exchange_kill ={
    --商品名（map.table.单位.商店） = 属性名，数值，上限次数，耗费杀敌数，图标,说明
    ['杀敌数加成'] = {'杀敌数加成',4,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+4%杀敌数加成|r|n|n'} ,
    ['木头加成'] = {'木头加成',4,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+4%木头加成|r|n|n'} ,
    ['物品获取率加成'] = {'物品获取率',4,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+4%物品获取率|r|n|n'} ,
    ['火灵加成'] = {'火灵加成',4,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+4%火灵加成|r|n|n'} ,
    ['分裂伤害加成'] = {'分裂伤害',5,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+5%分裂伤害|r|n|n'} ,
    ['攻速加成'] = {'攻击速度',5,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+5%攻击速度|r|n|n'} ,
    ['杀怪力量成长'] = {'杀怪加力量',60,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+60杀怪加力量|r|n'} ,
    ['杀怪敏捷成长'] = {'杀怪加敏捷',60,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+60杀怪加敏捷|r|n'} ,
    ['杀怪智力成长'] = {'杀怪加智力',60,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+60杀怪加智力|r|n'} ,
    ['杀怪全属性成长'] = {'杀怪加全属性',25,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+25杀怪加全属性|r|n'} ,
    ['杀怪攻击成长'] = {'杀怪加攻击',100,999999,400,[[sdsdh.blp]],'|n|n消耗 |cffff0000%real_kill_cnt% 杀敌数|r 兑换一次 |cff00ff00+100杀怪加攻击|r|n'} ,
    -- ['杀怪护甲成长'] = {'杀怪加护甲',0.1,999999,400,[[sdsdh.blp]],'挑着boss'} ,
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
    --每次增加 20级后，每级+50
    cre = 10,
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    content_tip = '|cffFFE799【说明】：|r',
    store_affix = '兑换 ',
    --物品技能
    is_skill = true,
    real_kill_cnt = 400    
    -- auto_fresh_tip = true,
    }
  

    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local player = hero:get_owner()
        hero = p.hero
        
        local shop_item = ac.item.shop_item_map[self.name]
        if not shop_item.player_kill then 
            shop_item.player_kill ={}
        end
        --限定购买次数
        if not shop_item.player_buy_cnt then 
            shop_item.player_buy_cnt = {}
        end
        shop_item.player_buy_cnt[player] = (shop_item.player_buy_cnt[player] or 1) + 1
        -- print(shop_item.player_buy_cnt[player])
        --改变价格
        if shop_item.player_buy_cnt[player] >20 then
            shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + 50
        else
            shop_item.player_kill[player] = (shop_item.player_kill[player] or self.kill_count ) + self.cre  
        end   
        if player:is_self() then 
            shop_item.real_kill_cnt = shop_item.player_kill[player]
            shop_item:set_tip(shop_item:get_tip())
        end    
        --增加属性
        hero:add(self.attr_name,self.attr_val)

        --文字提醒
        p:sendMsg('|cff00ff00兑换 '..self.name..' 成功|r',5)
        
    end

end    
