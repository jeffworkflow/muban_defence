
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['火灵翻倍']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNGlyph.blp]],
--说明
tip = [[|cffFFE799【说明】|r（|cff00ffff当前火灵:|r%has_vale%）

|cff00ff0050%火灵|cff00ff00翻倍|r  |cffff000050%火灵|cffff0000归零|r
]],
has_vale = function() 
    return ac.player.self.fire_seed
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
--币种
-- fire_seed = function(self)
--     local hero = self.owner
--     local p = hero:get_owner()
--     return p.fire_seed 
-- end,    
--实际概率
rate = 55 

}

-- if not mt.player_fire then 
--     mt.player_fire ={}
-- end
-- ac.loop(1000,function() 
--     mt.player_fire[ac.player.self] = ac.player.self.fire_seed    
--     -- print('木头翻倍',ac.player.self.kill_count)
-- end)  

-- function mt:on_add()
--     local shop_item = ac.item.shop_item_map[self.name]
--     if not shop_item.player_fire then 
--         shop_item.player_fire ={}
--     end
--     ac.loop(1000,function() 
--         shop_item.player_fire[ac.player.self] = ac.player.self.fire_seed    
--         -- print('木头翻倍',ac.player.self.kill_count)
--     end)  
-- end    

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()
    local fire_seed = p.fire_seed 
    local rand = math.random(100)
    if fire_seed <=0 then 
        p:sendMsg('|cffFFCC00不够资源|r')
        return 
    end    
    if rand <= self.rate then 
        hero:add_fire_seed(fire_seed)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        hero:add_fire_seed(-fire_seed)
        p:sendMsg('|cffff0000凉凉|r')
    end 
    
    local rate = 7.5
    local hero = p.hero
    if fire_seed >=90000 then 
        if math.random(10000)/100 <= rate then 
            local skl = hero:find_skill('一代幸运神',nil,true)
            if not skl then 
                ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','一代幸运神')
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r 翻倍一时爽，一直翻倍一直爽，|r 获得成就|cffff0000 "一代幸运神" |r，奖励 |cffff00005000万全属性，+100%杀敌数加成，+100%物品获取率，+100%木头加成，+100%火灵加成|r',6)
            end    
        end
    end     
end
