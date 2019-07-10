local mt = ac.skill['神仙水']
mt{
--等久
level = 0,
--图标
art = [[sxs2.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00全属性+50万 攻击+100万
初始金币+80万 杀敌数+1500|r

]],
init_gold = 800000,
init_kill_count = 1500,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = 500000,
['攻击'] = 1000000,
}
function mt:on_add()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero

    hero:addGold(self.init_gold)
    hero:add_kill_count(self.init_kill_count)
end    
