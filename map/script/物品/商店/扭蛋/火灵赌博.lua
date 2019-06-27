
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['火灵赌博']
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
rate = 60 

}

-- if not mt.player_fire then 
--     mt.player_fire ={}
-- end
-- ac.loop(1000,function() 
--     mt.player_fire[ac.player.self] = ac.player.self.fire_seed    
--     -- print('木头赌博',ac.player.self.kill_count)
-- end)  

-- function mt:on_add()
--     local shop_item = ac.item.shop_item_map[self.name]
--     if not shop_item.player_fire then 
--         shop_item.player_fire ={}
--     end
--     ac.loop(1000,function() 
--         shop_item.player_fire[ac.player.self] = ac.player.self.fire_seed    
--         -- print('木头赌博',ac.player.self.kill_count)
--     end)  
-- end    

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local fire_seed = p.fire_seed 
    local rand = math.random(100)
    if fire_seed <=0 then 
        p:sendMsg('|cffFFCC00不够赌|r')
        return 
    end    
    if rand <= self.rate then 
        hero:add_fire_seed(fire_seed)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        hero:add_fire_seed(-fire_seed)
        p:sendMsg('|cffff0000凉凉|r')
    end    
end
