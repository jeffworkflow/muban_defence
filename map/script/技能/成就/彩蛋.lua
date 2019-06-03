local mt = ac.skill['倒霉蛋']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shuaishen.blp]], 
    tip = [[
        木头+5555，火种+5555，杀敌数+5555
    ]],
    add_wood = 5555,
    add_fire = 5555,
    add_kill = 5555,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_fire_seed(self.add_fire)
    hero:add_kill_count(self.add_kill)
end    

local mt = ac.skill['游戏王']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shuaishen.blp]], 
    tip = [[
        全伤+5%， 免伤+5%， +2500W全属性
    ]],
    ['全伤加深'] = 5,
    ['免伤'] = 5,
    ['全属性'] = 25000000,
}
