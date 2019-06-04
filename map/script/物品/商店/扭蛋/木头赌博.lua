
local rect = require 'types.rect'

--物品名称
local mt = ac.skill['木头赌博']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNGrabTree.blp]],
--说明
tip = [[木头 50%翻倍， 50%0]],
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
-- wood = function(self)
--     local hero = self.owner
--     local p = hero:get_owner()
--     return p.wood 
-- end,
--实际概率
rate = 60 
}

if not mt.player_wood then 
    mt.player_wood ={}
end
ac.loop(1000,function() 
    mt.player_wood[ac.player.self] = ac.player.self.wood    
    -- print('木头赌博',ac.player.self.wood)
end)  
function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local wood = p.wood
    local rand = math.random(100)
    if wood <=0 then 
        p:sendMsg('|cffFFCC00不够赌|r')
        return 
    end  
    if rand <= self.rate then 
        hero:add_wood(wood*2)
        p:sendMsg('|cff00ff00翻倍|r')
    else
        -- hero:add_wood(-wood)
        p:sendMsg('|cffff0000凉凉|r')
    end    
end
