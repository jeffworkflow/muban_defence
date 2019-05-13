local event = {}

event.on_add_item = function (unit,item,count)
    if item.on_add ~= nil then 
        item:on_add()
    end 
    ac.game:event_notify('背包-添加物品',unit,item,count)
    --print(unit.handle,'添加物品',item:get_name())
end

event.on_remove_item = function (unit,item)
    if item.on_remove ~= nil then 
        item:on_remove()
    end 
    ac.game:event_notify('背包-删除物品',unit,item)
    --print(unit.handle,'删除物品',item:get_name())
end

event.on_discard_item = function (unit,item)
    if item.on_discard ~= nil then 
        item:on_discard()
    end 
    ac.game:event_notify('背包-丢弃物品',unit,item)
    --print(unit.handle,'丢弃物品',item:get_name())
end

event.on_move_item = function (unit,item)
    if item.on_move ~= nil then 
        item:on_move()
    end 
    ac.game:event_notify('背包-移动物品',unit,item)
    --print(unit.handle,'移动物品',item:get_name())
end

event.on_use_item = function (unit,item)
    if item.on_use ~= nil then 
        item:set_cd()
        item:on_use()
    end 
    ac.game:event_notify('背包-使用物品',unit,item)
    --print(unit.handle,'使用物品',item:get_name())
end

event.on_sell_item = function (unit,item)
    if item.on_sell ~= nil then 
        item:on_sell()
    end 
    ac.game:event_notify('背包-出售物品',unit,item)
    --print(unit.handle,'出售物品',item:get_name())
end

event.on_equimpent = function (unit,item)
    if item.on_equipment ~= nil then 
        item:on_equipment()
    end 
    ac.game:event_notify('背包-装备物品',unit,item)
    --print(unit.handle,'装备物品',item:get_name())
end

event.on_cancel_equimpent = function (unit,item)
    if item.on_cancel_equimpent ~= nil then 
        item:on_cancel_equimpent()
    end 
    ac.game:event_notify('背包-取消装备',unit,item)
    --print(unit.handle,'取消装备',item:get_name())
end


return event