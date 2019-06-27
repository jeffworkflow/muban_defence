
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['杀敌数赌博']
mt{
--等久
level = 1,
--图标
art = [[shadidubo.blp]],
--说明
tip = [[|cffFFE799【说明】|r（|cff00ffff当前杀敌数:|r%has_vale%）

|cff00ff0050%杀敌数翻倍|r  |cffff000050%杀敌数归零|r
]],
has_vale = function() 
    return ac.player.self.kill_count
end ,
auto_fresh_tip = true,
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
content_tip = '',
--物品技能
is_skill = true,
--商店名词缀
store_affix = '',
--实际概率
rate = 60 

}
--会掉线
-- function mt:on_add()
--     local shop_item = ac.item.shop_item_map[self.name]
--     if not shop_item.player_kill then 
--         shop_item.player_kill ={}
--     end
--     ac.loop(1000,function() 
--         shop_item.player_kill[ac.player.self] = ac.player.self.kill_count    
--         -- print('木头赌博',ac.player.self.kill_count)
--     end)  
-- end    


function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local kill_count = p.kill_count 
    local rand = math.random(100)
    if kill_count <=10 then 
        p:sendMsg('|cffFFCC00不够赌|r')
        return 
    end    
    if rand <= self.rate then 
        hero:add_kill_count(kill_count)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        hero:add_kill_count(-kill_count)
        p:sendMsg('|cffff0000凉凉|r')
    end    
end
