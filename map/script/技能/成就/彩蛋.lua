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
    
|cffFFE799【成就属性】：|r
|cff00ff00+16888 木头
+16888 火灵
+16888 杀敌数|r

]],
    add_wood = 16888,
    add_fire = 16888,
    add_kill = 16888,
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
    
|cffFFE799【成就属性】：|r
|cff00ff00+2500W 全属性
+5%     全伤加深
+5%     免伤|r

]],
    ['全伤加深'] = 5,
    ['免伤'] = 5,
    ['全属性'] = 25000000,
}

local mt = ac.skill['挖宝达人']
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
    art = [[wbdr.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+50%  物品获取率|r

]],
    ['物品获取率'] = 50,
    ['全属性'] = 5000000,
}
