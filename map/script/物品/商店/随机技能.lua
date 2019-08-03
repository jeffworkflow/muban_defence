--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['随机技能']
mt{
--等久
level = 1,
--图标
art = [[other\suijijineng.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[|n获得 |cffff0000随机技能|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--购买价格
wood = 1,
--物品技能
is_skill = true,
}

function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local hero = self.owner
    local shop_item = ac.item.shop_item_map[self.name]
    if not shop_item.player_wood then 
        shop_item.player_wood = {}
    end
    --改变商店物品物价
    shop_item.player_wood[hero:get_owner()] =  (shop_item.player_wood[hero:get_owner()] or self.wood) * 2
    shop_item.player_wood[hero:get_owner()] = math.min(shop_item.player_wood[hero:get_owner()],5000) --上限5000
    --给英雄随机添加物品
    local rand_list = ac.unit_reward['商店随机技能']
    local rand_name = ac.get_reward_name(rand_list)
    if not rand_name then 
        return
    end    
    -- skill_list2 英雄技能库
    local list = ac.skill_list2
    --添加给英雄
    local name = list[math.random(#list)]
    ac.item.add_skill_item(name,hero)

end

function mt:on_remove()
end