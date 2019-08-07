
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['杀敌数翻倍']
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
rate = 55 

}
--会掉线
-- function mt:on_add()
--     local shop_item = ac.item.shop_item_map[self.name]
--     if not shop_item.player_kill then 
--         shop_item.player_kill ={}
--     end
--     ac.loop(1000,function() 
--         shop_item.player_kill[ac.player.self] = ac.player.self.kill_count    
--         -- print('木头翻倍',ac.player.self.kill_count)
--     end)  
-- end    


function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()
    local kill_count = p.kill_count 
    local rand = math.random(100)
    if kill_count <=10 then 
        p:sendMsg('|cffFFCC00不够资源|r')
        return 
    end    
    if rand <= self.rate then 
        hero:add_kill_count(kill_count)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        hero:add_kill_count(-kill_count)
        p:sendMsg('|cffff0000凉凉|r')
    end    
    
    --超级彩蛋触发
    local rate = 7.5
    local hero = p.hero
    if kill_count >=10000 then 
        if math.random(10000)/100 <= rate then 
            local skl = hero:find_skill('一代幸运神',nil,true)
            if not skl then 
                ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','一代幸运神')
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 翻倍一时爽，一直翻倍一直爽，|r 获得成就|cffff0000 "一代幸运神" |r，奖励 |cffff00005000万全属性，+100%杀敌数加成，+100%物品获取率，+100%木头加成，+100%火灵加成|r',6)
            end    
        end
    end  
end
