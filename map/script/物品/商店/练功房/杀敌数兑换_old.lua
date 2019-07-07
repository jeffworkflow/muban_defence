
local rect = require 'types.rect'
-- 杀敌数兑换
-- 传送 快速达到 兑换
ac.exchange_kill ={
    --商品名（map.table.单位.商店） = 属性名，数值，上限次数，耗费杀敌数，图标,说明
    -- 
    ['杀敌数加成'] = {'杀敌数加成',25,4,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+25%杀敌数加成|r|n|n|cffcccccc兑换上限次数：4次|r'} ,
    ['木头加成'] = {'木头加成',25,4,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+25%木头加成|r|n|n|cffcccccc兑换上限次数：4次|r'} ,
    ['物品获取率加成'] = {'物品获取率',25,4,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+25%物品获取率|r|n|n|cffcccccc兑换上限次数：4次|r'} ,
    ['火灵加成'] = {'火灵加成',25,4,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+25%火灵加成|r|n|n|cffcccccc兑换上限次数：4次|r'} ,
    ['分裂伤害加成'] = {'分裂伤害',25,4,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+25%分裂伤害|r|n|n|cffcccccc兑换上限次数：4次|r'} ,
    ['攻速加成'] = {'攻击速度',25,4,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+25%攻击速度|r|n|n|cffcccccc兑换上限次数：4次|r'} ,
    ['杀怪力量成长'] = {'杀怪加力量',30,999999,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+30杀怪加力量|r|n'} ,
    ['杀怪敏捷成长'] = {'杀怪加敏捷',30,999999,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+30杀怪加敏捷|r|n'} ,
    ['杀怪智力成长'] = {'杀怪加智力',30,999999,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+30杀怪加智力|r|n'} ,
    ['杀怪全属性成长'] = {'杀怪加全属性',12,999999,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+12杀怪加全属性|r|n'} ,
    ['杀怪攻击成长'] = {'杀怪加攻击',50,999999,1000,[[sdsdh.blp]],'|n|n消耗 |cffff00001000杀敌数|r 兑换一次 |cff00ff00+50杀怪加攻击|r|n'} ,
    -- ['杀怪护甲成长'] = {'杀怪加护甲',0.1,999999,1000,[[sdsdh.blp]],'挑着boss'} ,
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

    content_tip = '|cffFFE799【说明】：|r',

    store_affix = '兑换 ',
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

        --文字提醒
        p:sendMsg('|cff00ff00兑换 '..self.name..' 成功|r',5)
        
    end

end    
