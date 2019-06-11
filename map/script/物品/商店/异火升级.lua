--异火升级
local fire = {
    --技能名 = 商店名，火灵基本价格，火灵增加价格，图标,tip
    ['星星之火'] = {'升级星星之火',2500,2500,[[other\suiji101.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]},
    ['陨落心炎'] = {'升级陨落心炎',2500,2500,[[other\suiji101.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]},
    ['三千焱炎火'] = {'升级陨落心炎',2500,2500,[[other\suiji101.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]},
    ['虚无吞炎'] = {'升级陨落心炎',2500,2500,[[other\suiji101.blp]],[[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]]}, 
}

for key,val in pairs(fire) do 
    local mt = ac.skill['升级'..key]
    mt{
    --等久
    level = 1,
    --正出售商品名
    store_name = val[1],
    --图标
    art = val[4],
    --说明
    tip =val[5],
    content_tip = '|cffFFE799【说明】：|r|n',
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --购买价格
    fire_seed = val[2],
    --每次增加
    cre = val[3],
    --最大购买次数
    max_buy_cnt = 10,
    --物品技能
    is_skill = true,
    }

    function mt:on_cast_start()
        local hero = self.owner
        local player = hero:get_owner()
        hero = player.hero

        local shop_item = ac.item.shop_item_map[self.name]
        if not shop_item.player_fire then 
            shop_item.player_fire ={}
        end
        --限定购买次数
        if not shop_item.player_buy_cnt then 
            shop_item.player_buy_cnt = {}
        end
        shop_item.player_buy_cnt[player] = (shop_item.player_buy_cnt[player] or 1) + 1

        --改变价格
        shop_item.player_fire[player] = (shop_item.player_fire[player] or self.fire_seed ) + self.cre
        
        --升级星星之火
        local skl = hero:find_skill(key,nil,true)
        if skl then 
            skl:upgrade(1)
            player:sendMsg('升级成功：'..key)
        else
            player:sendMsg('还没有 '..key)    
            return true
        end    

    end

end    