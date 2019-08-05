--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['真魔鬼的交易']
mt{
--等久
level = 1,
--图标
art = [[zmgdjy.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[|n消耗 |cffff00004个红色物品|r 兑换 |cff00ff00一个魔鬼的物品|r|n|n|cffcccccc最大兑换次数12次]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--最大购买次数
max_buy_cnt = 12,
--物品技能
is_skill = true,
}

function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()

    local red_cnt = 0
    local temp_item = {}
    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.color == '红' and red_cnt < 4 then 
            red_cnt = red_cnt +1
            table.insert(temp_item,item)
        end    
    end    
    if red_cnt < 4 then 
        p:sendMsg('材料不足')
        return 
    end    
    --限定购买次数
    -- if not p.buy_cnt then 
    --     p.buy_cnt = {} 
    -- end
    -- p.buy_cnt[self.name] = p.buy_cnt[self.name] or 0 + 1  
    -- if p.buy_cnt[self.name] >self.max_buy_cnt then
    --     p:sendMsg('超出次数') 
    --     return 
    -- end 
    --限定购买次数
    local shop_item = ac.item.shop_item_map[self.name]
    if not shop_item.player_buy_cnt then 
        shop_item.player_buy_cnt = {}
    end
    shop_item.player_buy_cnt[player] = (shop_item.player_buy_cnt[player] or 1) + 1
    
    --删除物品
    for i,item in ipairs(temp_item) do 
        if item._count > 1 then 
            item:add_item_count(-1)
        else    
            item:item_remove()
        end    
    end    

    --添加 
    local list = ac.black_item
    local name = list[math.random(#list)]
    --满时，掉在地上
    hero:add_item(name,true)
    p:sendMsg('|cff00ff00兑换成功|r')
end

function mt:on_remove()
end