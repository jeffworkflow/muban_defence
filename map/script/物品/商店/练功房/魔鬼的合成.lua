--物品名称
local mt = ac.skill['魔鬼的合成']
mt{
    --类型
    item_type = "神符",
    art = [[zmgdjy.blp]],
    --物品技能
    is_skill = true,
    
    content_tip = '',
    auto_fresh_tip = false,
    cool = 1,

    art = [[zmgdjy.blp]],
    tip = [[

|cffffe799【说明】:|r

消耗 |cffff0000两个魔鬼的物品|r 兑换 |cffdf19d0另一个魔鬼的物品|r
]],
}



function mt:on_add()
    
end

function mt:on_cast_shot()
    local hero = self.owner
    -- hero:add_item('黑色物品合成')
end    
--实际是丢掉
function mt:on_remove()
end