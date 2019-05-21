local mt = ac.skill['五星好评礼包']
mt{
--等久
level = 1,
--图标
art = [[hplb.blp]],
is_skill =true ,
--说明
tip = [[
领取条件：在平台评论区发表评论+评分5星
属性：
+%award_life% 生命上限
+%award_physical_damage% 物爆伤害
+%award_magic_damage% 法爆伤害
被攻击10%概率获得5全属性 --没实现
]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--购买价格
gold = 0,
award_life = 1000,
award_physical_damage = 50,
award_magic_damage = 50,

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
    if global_test then 
        map_level = 3
    end    
    local name = self.name
    if map_level>=3 and not p.mall_flag[name] then 
        --添加给英雄
        hero:add('生命上限',self.award_life)
        hero:add('物爆伤害',self.award_physical_damage)
        hero:add('法爆伤害',self.award_magic_damage)
        p.mall_flag[name] = true
    else
        p:sendMsg('条件不足或已领取过')    
    end   
end