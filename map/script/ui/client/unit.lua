local ui = require 'ui.client.util'

local unit = {}
local unit_class 
unit_class = {

    unit_map = {},

    get_object = function (handle)
        if handle == nil then
            return
        end

        local unit = unit_class.unit_map[handle]
        if unit == nil then
            unit = {
                handle = handle,    --单位局部
                this_page  = 1,      --当前页面 初始为 1
                max_page   = 1,      --最大页面 
                max_slot   = 42,     --槽位数量
                bag        = {},     --背包
                propbar = {},
                skillcolumn = {},

            }
            unit_class.unit_map[handle] = unit
  
            for i = unit.this_page,unit.max_page do
                unit.bag[i] = {}
            end 
            setmetatable(unit,{__index = unit_class})
        end
        return unit
    end,

    get_handle = function (self)
        return ConvertUnitState(self.handle)
    end,

    get_bag = function (self)
        return self.bag
    end,

    get_propbar = function(self)
        return self.propbar
    end,

    get_page = function (self,page_id)
        return self.bag[page_id or self.this_page]
    end,

    get_skillcolumn = function(self)
        return self.skillcolumn
    end,
} 


unit.event = {
    on_sync_state = function (handle,name,value)
        local unit = unit_class.get_object(handle)
        unit.state[name] = handle
        if ui.equipment.ui.unit == unit then 
            ui.equipment.ui:update_state(unit)
        end 
    end,

    on_sync_state_table = function (handle,tbl)
        local unit = unit_class.get_object(handle)

        for key,value in pairs(tbl) do 
            unit.state[key] = value
        end 

        if ui.equipment.ui.unit == unit then 
            ui.equipment.ui:update_state(unit)
        end
    end,

    create_unit = function(handle)
        local unit = unit_class.get_object(handle)
        
    end,
}

unit.unit_class = unit_class
setmetatable(unit_class,hero_class)


ui.register_event('unit',unit.event)


return unit