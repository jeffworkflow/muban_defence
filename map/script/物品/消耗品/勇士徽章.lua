--物品名称
local mt = ac.skill['勇士徽章']
mt{
--等久
level = 1,
--图标
art = [[icon\zhaohuan.blp]],
--说明
tip = [[可兑换物品,可存档]],
--品质
color = '紫',
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--购买价格
wood = 100,
--物品数量
_count = 1,
--物品详细介绍的title
content_tip = '使用说明：'
}

ac.game:event '物品-消耗品叠加' (function(_,item,old_value) --old_value
    -- print(item.name,old_value)
    local hero = item.owner
    local player = hero:get_owner()
    if player.id>10 then return end
    player:AddServerValue('yshz',old_value) --保存存档

end);
--添加时存档数据到服务器
function mt:on_add()
    -- print(self.name,self._count)
    local hero = self.owner
    local player = hero:get_owner()
    if player.id>10 then return end
    player:AddServerValue('yshz',self._count) --保存存档
end    
function mt:on_cast_start()
    local hero = self.owner
    local items = self
    local player = hero:get_owner()
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

end

--移除时减服务器存档数据
function mt:on_remove()
    -- print(self.name,self._count)
    local hero = self.owner
    local player = hero:get_owner()
    if player.id>10 then return end
    player:AddServerValue('yshz',-self._count) --保存存档
end

--