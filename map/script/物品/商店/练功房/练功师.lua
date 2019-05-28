
local rect = require 'types.rect'
-- 传送 快速达到
-- 练功师
ac.pratice_man ={
    --商品名 = 刷怪单位名，图标,说明
    ['经验怪'] = {'经验怪',[[ReplaceableTextures\CommandButtons\BTNTomeBrown.blp]],'挑着boss'} ,
    ['小金币怪'] = {'小金币怪',[[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],'挑着boss'} ,
    ['中金币怪'] = {'中金币怪',[[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],'挑着boss'} ,
    ['大金币怪'] = {'大金币怪',[[ReplaceableTextures\CommandButtons\BTNChestOfGold.blp]],'挑着boss'} ,
    ['小木头怪'] = {'小木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'挑着boss'} ,
    ['中木头怪'] = {'中木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'挑着boss'} ,
    ['大木头怪'] = {'大木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'挑着boss'} ,
    ['超大木头怪'] = {'超大木头怪',[[ReplaceableTextures\CommandButtons\BTNBundleOfLumber.blp]],'挑着boss'} ,
    ['小火种怪'] = {'小火种',[[ReplaceableTextures\CommandButtons\BTNVoidWalker.blp]],'挑着boss'} ,
    ['中火种怪'] = {'中火种',[[ReplaceableTextures\CommandButtons\BTNVoidWalker.blp]],'挑着boss'} ,
    ['大火种怪'] = {'大火种',[[ReplaceableTextures\CommandButtons\BTNVoidWalker.blp]],'挑着boss'} ,
}

for key,value in pairs(ac.pratice_man) do 
    --物品名称
    local mt = ac.skill[key]
    mt{
    --等久
    level = 1,
    --图标
    art = value[2],
    --说明
    tip = value[3],
    unit_name = value[1],
    --说明
    gold = 10,
    --物品类型
    item_type = '神符',
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    --物品技能
    is_skill = true,
    }

    function mt:on_cast_start()
        local hero = self.owner
        local p = hero:get_owner()
        local ret = 'lgfsg'..p.id
        local name = key..p.id
        local cep = ac.creep[name]
        cep:set_region(ret)
        cep.owner = p
        cep:start()
        
    end

    ac.wait(10,function()
        for i = 1,10 do 
            local player = ac.player(i)
            if player:is_player() then 
                local name = key..i
                local mt = ac.creep[name]{    
                    creeps_datas = value[1]..'*15',
                    cool = 1,
                    create_unit_cool = 0.01,
                    is_leave_region_replace = true,
                    is_region_replace = true,
                }
            end    
        end    
    end)
end    
