local ui = require 'ui.server.util'

local skillcolumn = {}

skillcolumn.event = {}


--添加技能
function s_ui.add_skill(name,unit,slot)
    --创建一个物品
    local item = s_ui.create_item(name,unit)
    local map = unit:get_skillcolumn()
    if map[slot] then
        print('该位置已有技能了')
        return
    end
    map[slot] = item

    --添加技能给单位
    unit:add_skill(name,'英雄',slot)

    --发送到客户端
    local info = {
        type = 'skillcolumn',
        func_name = 'add_skill',
        params = {
            [1] = name,
            [2] = GetHandleId(unit.handle),
            [3] = slot,
        }
    }
    ui.send_message(unit:get_owner(), info)
end

ui.register_event('skillcolumn',skillcolumn.event)