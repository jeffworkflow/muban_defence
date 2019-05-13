local ui = require 'ui.server.util'

local mt = {
    --获取背包
    get_bag = function(self)
        return self.bag
    end,

    get_skillcolumn = function(self)
        return self.skillcolumn
    end,
}


s_ui.unit_map = {}


function s_ui.unit_init(unit)
    for name,method in pairs(mt) do
        if unit[name] == nil then 
            unit[name] = method
        else
            print('已经有',name,'方法了')
        end
    end
    UnitAddAbility(unit.handle,base.string2id('AHta'))
   
    s_ui.unit_map[GetHandleId(unit.handle)] = unit
    --槽位数量
    unit.max_slot = 25
    --创建一个背包表
    unit.bag = {}
    --技能栏
    unit.skillcolumn = {}

    --转发到客户端创建
    local info = {
        type = 'unit',
        func_name = 'create_unit',
        params = {
            [1] = GetHandleId(unit.handle),

        }
    }
    ui.send_message(unit:get_owner(), info)
end

