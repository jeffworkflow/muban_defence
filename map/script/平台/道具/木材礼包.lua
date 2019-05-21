local mt = ac.skill['木材礼包']
mt{
--等久
level = 1,

--图标
art = [[mtlb.blp]],
is_skill =true ,

--说明
tip = [[    
领取条件：商城购买金币礼包
属性：
+%award_wood% 木头
+%award_all_attr% 全属性
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
award_wood = 100,
award_all_attr = 100,

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
        p:add_wood(self.award_wood)
        hero:add('全属性',self.award_all_attr)
        p.mall_flag[name] = true
    else
        p:sendMsg('条件不足或已领取过')    
    end   
end