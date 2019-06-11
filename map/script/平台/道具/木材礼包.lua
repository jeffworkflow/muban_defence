local mt = ac.skill['木材礼包']
mt{
--等久
level = 1,

--图标
art = [[mtlb.blp]],
is_skill =true ,
content_tip = '\n|cffFFE799【领取条件】|r',
--说明
tip = [[商城购买|cffff0000木材礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00初始木头+10，初始杀敌数+1000 |r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
award_wood = 10,
award_all_attr = 1000,

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
        hero:add_wood(self.award_wood)
        hero:add_kill_count(self.award_all_attr)
        -- hero:add('全属性',self.award_all_attr)
        p.mall_flag[name] = true
        local tip = '|cffFFE799【系统消息】|r恭喜 |cffff0000'..p:get_name()..'|r 获得|cffFFE799木材礼包 【礼包奖励】|r|cff00ff00初始木头+10，初始杀敌数+1000 |r'
        p:sendMsg(tip)
    else
        p:sendMsg('条件不足或已领取过')    
    end   
end