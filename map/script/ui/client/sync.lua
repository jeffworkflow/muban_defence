--[[
    用来处理控件的事件同步
]]
local ui = require 'ui.client.util'

local queue = game.sync_queue

local sync_key_map = {}

ac.sync_key_map = sync_key_map

local function control_has_func(control, func_name)
    local object = control
    while object ~= nil do 
        if object[func_name] then 
            return true 
        end 
        object = object.parent
    end 
    return false 
end 


local function seach_sync_func(control)
    for name, func in pairs(control) do 
        if type(func) == 'function' and name:find('on_sync_') then 
            ui.add_str(name)
        end 
    end 
    if control.parent then 
        seach_sync_func(control.parent)
    end     
end 

--将同步的控件信息记录到哈希表中
local function update_hashtable()
    for key, button in pairs(sync_key_map) do 
        if button.id == nil or button.id == 0 then 
            sync_key_map[key] = nil
        end 
    end 

    for _, button in pairs(class.button.button_map) do 
        local key = button.sync_key
        if key and sync_key_map[key] == nil then 
            sync_key_map[key] = button
            ui.add_str(key)
            seach_sync_func(button)
        end 
    end 

end 

--刷新队列
local function update_queue()

    update_hashtable()

    if #queue == 0 then 
        return 
    end 

    local first = queue[1] 

    table.remove(queue, 1)

    local control = first.control
    local func_name = 'on_sync_' .. first.event_name:sub(4, -1)

    local args = {}
    for i = 1, first.count do 
        local value = first.args[i]
        if type(value) ~= 'table' then 
            args[i] = value 
        end 
    end 
    --搜索是否拥有有效的回调方法
    local has = control_has_func(control, func_name)
    if has == false then 
        return 
    end 

    local info = {
        type = 'sync',
        func_name = 'on_sync',
        params = {
            [1] = ui.get_hash(control.sync_key),
            [2] = ui.get_hash(func_name),
            [3] = args,
        }
    }
    ui.send_message(info)
end 


--每0.15秒处理一次队列中的控件事件
game.loop(150, update_queue)