local hook = require 'jass.hook'
local japi = require 'jass.japi'
local message = require 'jass.message'
local error_handle = require('jass.runtime').error_handle
local dbg = require 'jass.debug'

local base


local width,height = 0,0
local pointer

--鼠标按下的时候 把响应的按钮收集起来 以便弹起的时候 来响应弹起事件
local left_is_down = false
local left_button_list = {}

local right_button_list = {}
local right_is_down = false

local button_enter_event_list = {}
local button_leave_event_list = {}

local is_active = true
local clock = os.clock()

--创建一个按钮 用来当做拖拽时的影子
local texture = nil

local game_event = {}

--绑定世界坐标的控件
local world_controls = {}

local ht = InitHashtable()


local function get_handle_type (handle)
    if handle == nil or handle == 0 then 
        return nil
    end 

    if GetHandleId(handle) == 0x100000 then 
        return nil 
    end

    local retval
    RemoveSavedHandle(ht,1,1)
    SaveFogStateHandle(ht,1,1,handle)
    if LoadItemHandle(ht,1,1) ~= nil and LoadItemHandle(ht,1,1) ~= 0 then 
        retval = 1
    elseif LoadUnitHandle(ht,1,1) ~= nil and LoadUnitHandle(ht,1,1) ~= 0 then
        retval = 2
    end
    RemoveSavedHandle(ht,1,1)
    return retval
end

--全局事件回调
local function game_event_callback(name,...)

    local hash_table = {}
    local ret = false 
    for index,event_table in ipairs(game_event) do
        local func = event_table[name]
        if func ~= nil then 
            ret = ret or func(...)
        end 
    end

    return ret
end

--同步队列
game.sync_queue = {}

game.register_event = function(module)
    table.insert(game_event, module)
end


game.get_mouse_pos = function ()
    local x = japi.GetMouseVectorX() / 1024
    local y = (-(japi.GetMouseVectorY() - 768)) / 768 
    x = x * 1920
    y = y * 1080
    return x,y
end

game.set_mouse_pos = function (x,y)
    x = x / 1920 * 1024
    y = 768 - y / 1080 * 768
    japi.SetMousePos(x,y)
end 


--最后一个参数默认不用填
game.world_to_screen = function (x, y, z)
    local screen_x, screen_y, scale = message.world_to_screen(x, y, z)
    if  screen_x and screen_y then 
        return screen_x * 1920 / 0.8, screen_y * 1080 / 0.6, scale
    end 
end

game.screen_to_world = function (x, y)
    local screen_x, screen_y = x / 1920 * 0.8, y / 1080 * 0.6
    return message.screen_to_world(x, y)
end


game.bind_world = function (control, enable)
    if enable then 
        world_controls[control] = true
    else 
        world_controls[control] = nil
    end 
end 

game.add_event_sync = function (control, event_name, ...)
    --保存其他控件事件以及参数
    table.insert(game.sync_queue, {
        control = control,
        event_name = event_name,
        args = {...},
        count = select('#', ...)
    })
end 


game.wait(0,function ()
    base.on_init()
end)


--计时器检测事件
game.loop(0.03,function ()
    local object = japi.GetTargetObject()
    if object ~= nil then 
        if object ~= pointer  then 
            local type = get_handle_type(pointer)

            if type == 1 then 
                base.on_item_mouse_leave(pointer)
                
            elseif type == 2 then 
                base.on_unit_mouse_leave(pointer)
            end
            type = get_handle_type(object)
            
            if type == 1 then 
                base.on_item_mouse_enter(object)
            elseif type == 2 then
                base.on_unit_mouse_enter(object)
            end
            pointer = object
        end
    end
    
    if japi.IsWindowActive() == false and is_active == true then 
        is_active = false
        if left_is_down or right_is_down then 
            base.on_mouse_up()
            base.on_mouse_right_up()
        end
    else
        is_active = true
    end
end)


base = {
    
    on_mouse_down = function ()
        local id = japi.GetMouseFocus()
        local button = class.button.button_map[id]

        left_is_down = true

        if button ~= nil then
            button.is_down = true
            if button.active_image and button.active_image ~= '' then
                button:set_active_image(button.active_image)
            end
            
            button:event_notify('on_button_mousedown')
            
            table.insert(left_button_list,button)

            if button.is_drag == true then 
                
                width,height = button.w,button.h
                game.wait(0.15,function ()
                    if left_is_down == true then 
                        if texture ~= nil then 
                            base.on_mouse_up()
                        end

                        local x = japi.GetMouseVectorX() / 1024 * 1920
                        local y = (-(japi.GetMouseVectorY() - 768)) / 768 * 1080
                        texture = class.texture:builder
                        {
                            parent_id = second_ui,
                            x = x - button.w / 2,
                            y = y - button.h / 2,
                            w = width,
                            h = height,
                            normal_image = button.normal_image,
                            alpha = 0.8,
                        }
                        texture.button = button
                        --button:set_position(x,y)

                        button:event_notify('on_button_begin_drag')
                    end
                end)

            end
        end

        local ret = game_event_callback('on_mouse_down')
        local handle = japi.GetTargetObject()
        local type = get_handle_type(handle)
        
        if type == 1 then 
            ret = game_event_callback('on_item_mouse_down',handle) or ret
        elseif type == 2 then 
            ret = game_event_callback('on_unit_mouse_down',handle) or ret
        end

        
        return ret 
    end,

    on_mouse_up = function ()
        local id = japi.GetMouseFocus()
        local button = class.button.button_map[id]

        left_is_down = false
        if texture ~= nil then 
            if button == texture.button then 
                texture.button:event_notify('on_button_drag_and_drop')
            else
                texture.button:event_notify('on_button_drag_and_drop',button)
            end
            texture:destroy()
            texture = nil
        end 
        for index,object in ipairs(left_button_list) do
            object.is_down = nil
            if object.is_enter and object.hover_image and object.hover_image ~= '' then
                object:set_hover_image(object.hover_image)
            else
                object:set_normal_image(object.normal_image)
            end

            if object ~= button then 
                object:event_notify('on_button_mouseup')
            else
                if object.is_enable then
                    object:event_notify('on_button_clicked')
                    local time = os.clock()
                    if object._click_time and time - object._click_time <= 0.3 then 
                        object:event_notify('on_button_double_clicked')
                    end 
                    object._click_time = time
                end
                object:event_notify('on_button_mouseup')
            end
        end
        left_button_list = {}

        local ret = game_event_callback('on_mouse_up')

        local handle = japi.GetTargetObject()
        local type = get_handle_type(handle)

        if type == 1 then 
            ret = game_event_callback('on_item_mouse_up',handle) or ret
            ret = game_event_callback('on_item_clicked',handle) or ret
        elseif type == 2 then 
            ret = game_event_callback('on_unit_mouse_up',handle) or ret
            ret = game_event_callback('on_unit_clicked',handle) or ret
        end

        return ret 
    end,

    on_mouse_right_down = function ()
        local id = japi.GetMouseFocus()
        local button = class.button.button_map[id]

        right_is_down = true

        if button ~= nil then 
            button:event_notify('on_button_right_mousedown')
            table.insert(right_button_list,button)
        end 

        return game_event_callback('on_mouse_right_down')
    end,

    on_mouse_right_up = function ()
        local id = japi.GetMouseFocus()
        local button = class.button.button_map[id]

        right_is_down = false 

        for index,object in ipairs(right_button_list) do
            if object ~= button then 
                object:event_notify('on_button_right_mouseup')
            else
                object:event_notify('on_button_right_mouseup')
                button:event_notify('on_button_right_clicked')
            end
        end
        right_button_list = {}

        local ret 

        local handle = japi.GetTargetObject()
        local type = get_handle_type(handle)
        if type == 1 then 
            ret = game_event_callback('on_item_right_clicked',handle) or ret
        elseif type == 2 then 
            ret = game_event_callback('on_unit_right_clicked',handle) or ret
        end
        ret = game_event_callback('on_mouse_right_up') or ret 
        return ret
    end,

    on_mouse_move = function ()
        
        local x = japi.GetMouseVectorX() / 1024
        local y = (-(japi.GetMouseVectorY() - 768)) / 768 
        x = x * 1920
        y = y * 1080
        if texture ~= nil then 
            local button = texture.button
            texture:set_position(x - texture.w / 2,y - texture.h / 2)
            button:event_notify('on_button_update_drag',texture,x - button.w / 2,y - button.h / 2)
        end 

        for id,button in pairs(class.button.button_map) do
            local ox,oy = button:get_real_position()
        
            if x >= ox and  y >= oy and x <= ox + button.w and y <= oy + button.h then
                local is_show = button:get_is_show() ~= false
                if button.is_enter == nil and is_show then 
                    button.is_enter = true
                    table.insert(button_enter_event_list, button)
                end

                if button.is_enter and is_show and button.is_move_event then 
                    button:event_notify('on_button_mouse_move',x,y)
                end 
            elseif button.is_enter == true then 
                table.insert(button_leave_event_list, button)
                button.is_enter = nil
            end
        end

        --先处理离开事件， 再派发进入事件
        if #button_leave_event_list > 0 then 
            class.ui_base.remove_tooltip()
        end 
        for i = #button_leave_event_list, 1, -1 do
            local button = button_leave_event_list[i]
            button:event_notify('on_button_mouse_leave')
            table.remove(button_leave_event_list, i)

            if button.is_down and button.active_image and button.active_image ~= '' then
                button:set_active_image(button.active_image)
            else
                button:set_normal_image(button.normal_image)
            end 
        end

        for i = #button_enter_event_list, 1, -1 do
            local button = button_enter_event_list[i]
            button:event_notify('on_button_mouse_enter')
            table.remove(button_enter_event_list, i)

            if button.hover_image and button.hover_image ~= '' then
                button:set_hover_image(button.hover_image)
            else
                button:set_normal_image(button.normal_image)
            end 
        end 

        game_event_callback('on_mouse_move')
    end,

    on_mouse_wheeldelta = function ()
        

        local x = japi.GetMouseVectorX() / 1024
        local y = (-(japi.GetMouseVectorY() - 768)) / 768 
        x = x * 1920
        y = y * 1080

        for id,panel in pairs(class.panel.object_map) do
            local ox,oy = panel:get_real_position()
        
            if panel.is_scroll 
            and x >= ox and  y >= oy 
            and x <= ox + panel.w and y <= oy + panel.h 
            then
                local bool = japi.GetWheelDelta() > 0
                local y = panel.scroll_y or 0
                if bool then 
                    if y > 0 then 
                        y = y - (panel.scroll_interval_y  or 10)
                    end 
                else 
                    if y + panel.h < panel:get_child_max_y() then 
                        y = y +  (panel.scroll_interval_y or 10)
                    end 
                end 
                panel.scroll_y = y
                panel:event_notify('on_panel_scroll',bool)
                panel:event_notify('on_panel_scroll_fix',bool)
                
            end 
        end 

        return game_event_callback('on_mouse_wheeldelta',japi.GetWheelDelta() > 0)
    end,

    on_key_down = function ()
        local code = japi.GetTriggerKey()
        local str = KEY_STR[code]
        

        if str then 
            for id,button in pairs(class.button.button_map) do
                if button.is_enable and button.keys and button:get_is_show() then
                    for index, key in ipairs(button.keys) do 
                        if key == str then 
                            button:event_notify('on_button_key_down', str)
                            break
                        end 
                    end 
                end
            end
        end 

       return game_event_callback('on_key_down', code) 
    end,

    on_key_up = function ()
        local code = japi.GetTriggerKey()
        local str = KEY_STR[code]
        
        if str then 
            for id,button in pairs(class.button.button_map) do
                if button.is_enable and button.keys and button:get_is_show() then
                    for index, key in ipairs(button.keys) do 
                        if key == str then 
                            button:event_notify('on_button_key_up', str)
                            break
                        end 
                    end 
                end
            end 
        end 

        return game_event_callback('on_key_up',code)
    end,

    --指向物品事件
    on_item_mouse_enter = function (item_handle)
        game_event_callback('on_item_mouse_enter',item_handle)
        --print('进入物品',item_handle)
    end,

    --离开物品事件
    on_item_mouse_leave = function (item_handle)
        game_event_callback('on_item_mouse_leave',item_handle)
        --print('离开物品',item_handle)
    end,

    --指向单位事件
    on_unit_mouse_enter = function (unit_handle)
        game_event_callback('on_unit_mouse_enter',unit_handle)
        --print('进入单位',unit_handle)
    end,
 
    --离开单位事件
    on_unit_mouse_leave = function (unit_handle)
        game_event_callback('on_unit_mouse_leave',unit_handle)
        --print('离开单位',unit_handle)
    end,

   
    on_update_window_size = function ()
        game_event_callback('on_update_window_size')
    end,


    
    on_update = function ()
        local c = os.clock()
        local delta = c - clock 
        clock = c 

        base.on_mouse_move()
        game_event_callback('on_update', delta)

        local center = ac.player.self:getCamera()

        for control in pairs(world_controls) do 
            local unit = control.world_unit 
            local x, y, z 
            if unit then 
                if unit.removed then
                    if control.world_auto_remove then 
                        control:destroy()
                    else 
                        control:hide()
                    end
                    goto continue
                else 
                    if  unit.hide_life_bar or not unit:is_alive() or unit:has_restriction '隐藏' or not unit:is_visible(ac.player.self) then 
                        control:hide()
                        goto continue
                    else 
                        local p = unit:get_point()
                        if center * p > 4000 then 
                            control:hide()
                            goto continue
                        end 
                        x, y = p:get()
                        z = p:getZ()
                        z = z + unit:get_high()
                        z = z + message.unit_overhead(unit.handle)
                    end 
                end 
            else 
                x, y, z = control.world_x, control.world_y, control.world_z
            end 
            local screen_x, screen_y, scale = game.world_to_screen(x, y, z)
            
            if screen_x == nil or screen_x < 0 or screen_y < 32 or screen_x > 1920 or screen_y > 1080 then 
                control:hide()
            else 
                control:show()
                local x = screen_x - control.w + (control.offect_x or 0)
                local y = screen_y - control.h + (control.offect_y or 0)
                control:set_real_position(x, y, control.world_anchor)
                
                --control:set_relative_size(scale, false)
            end 

            ::continue::
        end 
    end,


    on_init = function()
        game_event_callback('on_init')
    end,

}



local event = {
    base.on_mouse_down,
    base.on_mouse_up,
    base.on_mouse_right_down,
    base.on_mouse_right_up,
    base.on_mouse_move,
    base.on_mouse_wheeldelta,
    base.on_key_down,
    base.on_key_up,
    base.on_update_window_size,
    base.on_update,
}

--窗口消息事件
function WindowEventCallBack(event_id)
    if event[event_id] ~= nil then 
        local bool, ret = xpcall(event[event_id],error_handle)
        return ret
    end 
    return false
end


local frame_event = {
    --文本框更新事件
    [9] = function (frame,id)
        local edit = edit_class.edit_map[frame]
        if edit == nil then 
            return 
        end 

        local text = edit:get_text()
        if edit.text ~= text then 
            local old_text = edit.text
            edit.text = text
            edit:event_notify('on_edit_text_changed',text,old_text)
        end 
    end,
}
--魔兽自带的控件消息事件
function FrameEventCallBack(frame,id)
    if frame_event[id] then 
        xpcall(frame_event[id],runtime.error_handle,frame,id)
    end 
end 


return game