local mt = ac.skill['剑仙直升包']
mt{
--等久
level = 1,
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
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['会心伤害'] = 68,
['攻击距离'] = 200,
}
function mt:on_add()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    -- print('剑仙直升包11111')
    --设置为远程
    hero:setMelee(false)
    
    if not hero.weapon then 
        hero.weapon = {}
    end    
    hero.weapon['弹道速度'] = 30000
end    

ac.game:event '玩家-注册英雄后'(function(_, _, hero)
    if hero:get_name() ~='剑仙' then 
        return 
    end    
    local p = hero:get_owner()
	if p.mall and p.mall['剑仙直升包'] then 
        hero:add_skill('剑仙直升包','隐藏')
	end   
end)





