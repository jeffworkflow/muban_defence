local mt = ac.skill['金币礼包']
mt{
--等久
level = 1,
--图标
art = [[jblb.blp]],
is_skill =true ,
content_tip = '\n|cffFFE799【领取条件】|r',
--说明
tip = [[商城购买|cffff0000金币礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00每秒加250金币，杀怪+250金币，攻击+250金币|r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
--每秒金币
per_gold = 250,
--杀怪加金币
kill_gold = 250,
--攻击加金币
attack_gold = 250,
}

function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local name = self.name
    if p.mall[name] and not p.mall_flag[name] then 
        --添加给英雄
        hero:add('每秒加金币',self.per_gold)
        hero:add('杀怪加金币',self.kill_gold)
        hero:add('攻击加金币',self.attack_gold)
        p.mall_flag[name] = true
        
        local tip = '|cffFFE799【系统消息】|r恭喜 |cff00ffff'..p:get_name()..'|r 获得|cffff0000金币礼包|r |cffFFE799【礼包奖励】|r|cff00ff00每秒加250金币，杀怪+250金币，攻击+250金币|r'
        p:sendMsg(tip)
    else
        p:sendMsg('条件不足或已领取过')    
    end    
end