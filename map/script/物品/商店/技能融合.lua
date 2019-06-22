--物品名称
local mt = ac.skill['技能融合']
mt{
    --类型
    item_type = "神符",
    art = [[other\hecheng.blp]],
    --物品技能
    is_skill = true,
    content_tip = '',
    tip = [[

|cffFFE799【使用说明】：|r
将 |cff00ff00三本技能书|r 合成 |cffdf19d0另一本随机技能书|r
 ]],
}



function mt:on_add()
    
end

function mt:on_cast_shot()
    local hero = self.owner
    hero:add_item('技能融合')
end    
--实际是丢掉
function mt:on_remove()
end