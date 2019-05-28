local ui = require 'ui.server.util'
local unit = require 'types.unit'
local trg = CreateTrigger()
--注册同步事件
japi.RegisterMessageEvent(trg)
TriggerAddAction(trg,function ()
    local message = japi.GetTriggerMessage()
    local player = japi.GetMessagePlayer()
    print(message:len(),message,player)
  
    ui.on_custom_ui_event(player,message)
end)

----注册拾取物品触发
--trg = CreateTrigger()
--TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_PICKUP_ITEM )
--TriggerAddAction(trg,function ()
--    local handle = GetManipulatedItem()
--    local unit_handle = GetTriggerUnit()
--    local hero = bag.unit_map[GetHandleId(unit_handle)]
--    local item = bag.item_map[GetHandleId(handle)]
--    if hero ~= nil and item ~= nil then 
--        local pos = hero:get_nil_slot(1) --获取一个空槽位
--        if pos ~= nil then 
--            hero:add_item(item)
--            print(handle)
--            RemoveItem(GetManipulatedItem())
--        else 
--            print('捡起物品失败 背包满了')
--        end
--    end
--end)
--
----注册使用望远镜技能触发 获取使用的物品
--trg = CreateTrigger()
--TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_ISSUED_POINT_ORDER )
--TriggerAddAction(trg,function ()
--
--    if GetIssuedOrderIdBJ() ~= 852270 then 
--        return 
--    end    
--
--    local page_id = math.modf(GetOrderPointX())
--    local slot_id = math.modf(GetOrderPointY())
--    
--    local id = GetHandleId(GetTriggerUnit())
--    local ac_unit = bag.unit_map[id]
--
--    if ac_unit == nil then 
--        return 
--    end 
--    if page_id > 0 and page_id <= ac_unit.max_page and slot_id > 0 and slot_id <= ac_unit.max_slot then 
--        local item = ac_unit:get_item(page_id,slot_id)
--        if item ~= nil then 
--            item_event.on_use_item(ac_unit,item)
--        end 
--    end 
--
--
--end)
--
----注册选择单位触发 选择单位的时候 刷新背包
--trg = CreateTrigger()
--for i=0,11 do
--    TriggerRegisterPlayerSelectionEventBJ(trg,Player(i),true)
--end
--TriggerAddAction(trg,function ()
--
--    local unit = GetTriggerUnit()
--    local id = GetHandleId(unit)
--    local player = GetTriggerPlayer()
--
--    if bag.unit_map[id] == nil then 
--        return 
--    end 
--
-- 
--
--    if GetOwningPlayer(unit) == player and IsUnitType(unit, UNIT_TYPE_HERO) then 
--        
--        local ac_player = ac.player(GetPlayerId(player) + 1)
--        ac_player.select_unit = bag.unit_map[id]
--
--        local info = {
--            type = 'bag',
--            func_name = 'on_select_unit',
--            params = {
--                [1] = GetHandleId(unit),
--            }
--        }
--        ui.send_message(ac_player,info)
--    end 
--end)
--
--
--function register_item_destroy_event(item_handle)
--    local trg = CreateTrigger()
--    TriggerRegisterDeathEvent(trg,item_handle)
--    TriggerAddAction(trg,function ()
--        local handle = GetTriggerWidget()
--        if bag.item_map[GetHandleId(handle)] then 
--            local info = {
--                type = 'bag',
--                func_name = 'on_discard_clear',
--                params = {
--                    [1] = GetHandleId(handle),
--                }
--            }
--            ui.send_message(nil,info)
--            bag.item_map[GetHandleId(handle)] = nil
--            DestroyTrigger(trg)
--            print('清除',handle)
--        end
--    end)
--end