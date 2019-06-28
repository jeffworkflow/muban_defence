local client = require 'ui.client.util'


local ui = extends(client){}


ui.hashtable = {}

ui.init = function () --预存数据表里的物的名字
    for file_type,file_data in pairs(ac.table) do
        for name,value in pairs(file_data) do
            local hash = ui.get_hash(name)
            local value = ui.hashtable[hash]   
            if value ~= nil and value ~= name then 
                print('哈希值发生碰撞了',name,value)
            else 
                ui.hashtable[hash] = name
            end
        end
    end
end

ui.get_str = function (hash)
    return ui.hashtable[hash]
end

ui.to_hash = function (str)
    local function uint32_t (int)
        return int & 0xffffffff
    end
    local hash = uint32_t(5381)
    local length = str:len()
    for i = 1,length do
        local byte = str:sub(i,i):byte()
        hash = uint32_t(uint32_t(uint32_t(hash << 5) + hash) + byte)
    end
    return hash
end

ui.get_hash = function (str)
    return ui.to_hash(str)
    --return string.pack("I4",ui.to_hash(str))
end

ui.event = {}


ui.register_event = function (name,event_table)
    ui.event[ui.get_hash(name)]=event_table
    local list = {}
    for key,value in pairs(event_table) do 
        table.insert(list,key)
    end 
    for index,key in ipairs(list) do 
        event_table[ui.get_hash(key)] = event_table[key]
    end 
end


ui.send_message = function (player,info)
    if info == nil and type(info) ~= 'table' then 
        return
    end
    if player then 
        if type(player) == 'userdata' then 
            print(debug.traceback())
        end 
        player = player.handle
    end 

    if GetLocalPlayer() == player or player == nil then 
        local msg = string.format("%s",ui.encode(info))
        client.on_custom_ui_event(msg)
    end
end

ui.on_custom_ui_event = function (player,message)
    local info_table = ui.decode(message)
    if info_table == nil then
        return
    end
    local event_type = info_table.t
    local func_name = info_table.f
    local params = info_table.p
    if event_type and func_name then
        local event_table = ui.event[event_type]
        if event_table ~= nil then
            local func = event_table[func_name]
            if func ~= nil then
                ui.player = player
                if params == nil then
                    func()
                else
                    func(table.unpack(params,1,#params))
                end
            end
        end
    end

end

ui.print = function (player,...)
    
    local paramCount = select('#', ...) 
    local args = {...}
    local s = ''
    for index = 1 , paramCount do 
        s=s..tostring(args[index])..' '
    end

    local info = {
        type = 'bag',
        func_name = 'on_print',
        params = {
            [1] = s,
        }
    }
    ui.send_message(player,info)
end


ui.copy_table = function (old)
    local new = {}
    for key,value in pairs(old) do
        if type(value) == 'table' then
            new[key] = ui.copy_table(value)
        else
            new[key] = value
        end
    end
    return new
end

ui.init()

return ui