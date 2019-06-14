local mt = ac.skill['五星好评礼包']
mt{
--等久
level = 1,
--图标
art = [[hplb.blp]],
content_tip = '\n|cffFFE799【领取条件】|r',
is_skill =true ,
--说明
tip = [[给此图来个|cffff0000五星好评|r

|cffFFE799【礼包奖励】|r|cff00ff00被攻击10%几率获得5点全属性， 暴击加深+15%， 技暴加深+15% |r
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
award_physical_damage = 15,
award_magic_damage = 15,

--几率
chance = 10,

}

function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local map_level = p:Map_GetMapLevel() 
    --测试
    -- if global_test then 
    --     map_level = 3
    -- end    
    local name = self.name
    if map_level>=3 and not p.mall_flag[name] then 
        --添加给英雄
        hero:add('暴击加深',self.award_physical_damage)
        hero:add('技暴加深',self.award_magic_damage)

        --受到 伤害几率 加全属性
        hero:event '受到伤害效果' (function(trg, damage)
            --概率加全属性
            if math.random(100) <= self.chance then 
                hero:add('全属性',5)
            end    
        end)
        p.mall_flag[name] = true
        
        local tip = '|cffFFE799【系统消息】|r恭喜 |cff00ffff'..p:get_name()..'|r 获得|cffff0000五星好评礼包|r |cffFFE799【礼包奖励】|r|cff00ff00被攻击10%几率获得5点全属性， 暴击加深+15%， 技暴加深+15% |r'
        p:sendMsg(tip)
    else
        p:sendMsg('条件不足或已领取过')    
    end   
end