--异火升级
local fire = {
    --技能名 = 商店名，火灵基本价格，火灵增加价格，图标,tip
    ['星星之火'] = {'|cffffff00升级|r 星星之火',2500,2500,[[huo1.blp]],[[|n点击可升级星星之火 |cffff0000耗费2500*LV火灵|r |cff00ff00最大等级为10级|r|n]]},
    ['陨落心炎'] = {'|cffffff00升级|r 陨落心炎',5000,5000,[[huo2.blp]],[[|n点击可升级陨落心炎 |cffff0000耗费5000*LV火灵|r |cff00ff00最大等级为10级|r|n]]},
    ['三千焱炎火'] = {'|cffffff00升级|r 三千焱炎火',10000,10000,[[huo3.blp]],[[|n点击可升级三千焱炎火 |cffff0000耗费10000*LV火灵|r |cff00ff00最大等级为10级|r|n]]},
    ['虚无吞炎'] = {'|cffffff00升级|r 虚无吞炎',20000,20000,[[huo4.blp]],[[|n点击可升级虚无吞炎 |cffff0000耗费20000*LV火灵|r |cff00ff00最大等级为10级|r|n]]}, 
    ['陀舍古帝'] = {'|cffffff00升级|r 陀舍古帝',35000,35000,[[tsgd.blp]],[[|n点击可升级陀舍古帝 |cffff0000耗费35000*LV火灵|r |cff00ff00最大等级为10级|r|n]]}, 
    ['无尽火域'] = {'|cffffff00升级|r 无尽火域',50000,50000,[[wjhy.blp]],[[|n点击可升级无尽火域 |cffff0000耗费50000*LV火灵|r |cff00ff00最大等级为10级|r|n]]}, 
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
    content_tip = '|cffFFE799【任务说明】：|r|n',
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

        --升级星星之火
        local skl = hero:find_skill(key,nil,true)
        if skl then 
            skl:upgrade(1)
            player:sendMsg('|cffFFE799【系统消息】|r|cff00ff00升级'..key..'成功|r 升级后的属性可以在异火系统中查看',2)
        else
            player:sendMsg('|cffFFE799【系统消息】|r|cffff0000条件不符，升级失败|r',2) 
            return true
        end    

        local shop_item = ac.item.shop_item_map[self.name]
        if not shop_item.player_fire then 
            shop_item.player_fire ={}
        end
        --限定购买次数
        -- if not shop_item.player_buy_cnt then 
        --     shop_item.player_buy_cnt = {}
        -- end
        -- shop_item.player_buy_cnt[player] = (shop_item.player_buy_cnt[player] or 1) + 1

        --改变价格
        shop_item.player_fire[player] = (shop_item.player_fire[player] or self.fire_seed ) + self.cre
        -- print(player,'价格：',shop_item.player_fire[player],'拥有货币',player.fire_seed)
    end

end    