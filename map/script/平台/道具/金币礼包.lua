local mt = ac.skill['金币礼包']
mt{
--等久
level = 1,
--图标
art = [[jblb.blp]],
is_skill =true ,
--说明
tip = [[ 
领取条件：商城购买金币礼包
属性：
+%award_gold% 金币
+%award_kill_cnt% 杀敌数
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
--奖励金币
award_gold = 1000,
--奖励杀敌数
award_kill_cnt = 300,
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
        hero:addGold(self.award_gold)
        p:add_kill_count(self.award_kill_cnt)
        p.mall_flag[name] = true
    else
        p:sendMsg('条件不足或已领取过')    
    end    
end