--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['随机物品']
mt{
--等久
level = 1,
--图标
art = [[other\suiji101.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[|n获得 |cffff0000随机物品|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--购买价格
wood = 100,
--每次增加
cre_wood = 200,
--物品技能
is_skill = true,
}

function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local hero = self.owner
    local shop_item = ac.item.shop_item_map[self.name]
    if not hero.buy_item_cnt then 
        hero.buy_item_cnt = 0
    end 
    if not shop_item.player_wood then 
        shop_item.player_wood = {}
    end

    local old_wood = shop_item.wood
    --可能会异步
    --改变商店物品物价
    hero.buy_item_cnt = hero.buy_item_cnt + 1
    shop_item.wood = math.min(shop_item.wood + self.cre_wood * hero.buy_item_cnt,500000)

    -- print( shop_item.wood,self.buy_cnt)
    if hero:get_owner() == ac.player.self then 
        shop_item:set_tip(shop_item:get_tip())
    end
    shop_item.player_wood[hero:get_owner()] = shop_item.wood
    shop_item.wood = old_wood  

    --给英雄随机添加物品
    local rand_list = ac.unit_reward['商店随机物品']
    local rand_name = ac.get_reward_name(rand_list)
    if not rand_name then 
        return
    end    
    
    local list = ac.quality_item[rand_name] 
    --添加 
    local name = list[math.random(#list)]
    --满时，掉在地上
    hero:add_item(name,true)

end

function mt:on_remove()
end