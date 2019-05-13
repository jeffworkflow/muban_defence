--[[

    基础类的封装 主要重载一些UI功能为对象形式

]]
--类的继承 子类继承父类
storm = require 'jass.storm'
japi  = require 'jass.japi'

game_ui     = japi.GetGameUI()

global_blp_map = {}

handle_system_class = {
    is_show = true,

    create = function ()
        local object = {}
        object.top = 1 
        object.stack = {}
        object.map = {}
        object.id_table = {}
        setmetatable(object,{__index = handle_system_class})
        return object
    end,

    destroy = function (self)
        
    end,
    create_handle = function (self)
        local id = self.top
        local stack = self.stack
        if #stack == 0 then
            id = self.top
            self.top = self.top + 1
        else
            id = stack[#stack]
            table.remove(stack,#stack)
            self.map[id] = nil
        end
        self.id_table[id] = 1
        return id
    end,

    close_handle = function (self,id)
        if self.id_table[id] == nil and self.map[id] ~= nil then
            ui_print('重复回收',id)
        elseif self.id_table[id] == nil then
            ui_print('非法回收',id)
        end
        if self.map[id] == nil and self.id_table[id] ~= nil then
            self.map[id] = 1
            self.id_table[id] = nil
            table.insert(self.stack,id)
        end
    end,


}

function blp_rect(path,left,top,right,bottom)
    left = math.modf(left)
    top = math.modf(top)
    right = math.modf(right)
    bottom = math.modf(bottom)


    local key = string.format("%i_%i_%i_%i.blp",left,top,right,bottom)
    local newPath = path:gsub('%.blp',key .. '.blp')
    if global_blp_map[newPath] == nil then 
        japi.EXBlpRect(path,newPath,left,top,right,bottom)
        global_blp_map[newPath] = true 
    end 
    return newPath
end 

function blp_sector(path,x,y,r,angle,section)
    x = math.modf(x)
    y = math.modf(y)
    angle = math.modf(angle)
    r = math.modf(r) 
    section = math.modf(section) 
    local key = string.format("%i_%i_%i_%i_%i.blp",x,y,r,angle,section)
    local newPath = path:gsub('%.blp',key .. '.blp')
    if global_blp_map[newPath] == nil then 
        japi.EXBlpSector(path,newPath,x,y,r,angle,section)
        global_blp_map[newPath] = true 
    end 
    return newPath

end 

storm.save('ui\\loaded.fdf','')
function load_fdf(data)
    storm.save('ui\\loaded.fdf',storm.load('ui\\loaded.fdf') .. data)
    storm.save('ui\\Load.fdf',data)
    storm.save('ui\\Load.toc','ui\\Load.fdf\r\n')
    japi.LoadToc('ui\\Load.toc')
end

function converScreenPosition(x,y)
    x = x / 1920 * 0.8
    y = (1080 - y) / 1080 * 0.6
    return x,y
end

function converScreenSize(width,height)
    width = width / 1920 * 0.8
    height = height / 1080 * 0.6
    return width,height
end


function extends (parent_class,child_class)
    local tbl = {}
    local mt = getmetatable(parent_class)
    if mt ~= nil then 
        tbl.__tostring = mt.__tostring
        tbl.__call = mt.__call
    end
    tbl.__index = parent_class
    setmetatable(child_class,tbl)
    return child_class
end


function event_callback (event_name,controls,...)
    local retval = true
    local object = controls
    while object ~= nil do
        if object.is_show == false then 
            return
        end
        object = object.parent
    end

    if controls[event_name] ~= nil then
        retval = controls[event_name](controls,...)
    end
    if controls.message_stop == true then --停止消息对父类的转发
        return 
    end
    if retval == nil then 
        retval = true
    end
    --将消息转发到父类对象里
    object = controls.parent
    while object ~= nil and retval ~= false do
        local method = object[event_name]
        if method ~= nil then
            retval = method(object,controls,...)
        end
        object = object.parent
    end
end



function hide_event_callback(event_name,controls,...)
    local retval = true
    local object = controls
    while object ~= nil do
        object = object.parent
    end

    if controls[event_name] ~= nil then
        retval = controls[event_name](controls,...)
    end
    if controls.message_stop == true then --停止消息对父类的转发
        return 
    end
    if retval == nil then 
        retval = true
    end
    --将消息转发到父类对象里
    object = controls.parent
    while object ~= nil and retval ~= false do
        local method = object[event_name]
        if method ~= nil then
            retval = method(object,controls,...)
        end
        object = object.parent
    end
end


handle_manager_class = {
    
    create = function ()
        local object = {
            top     = 1,
            stack   = {},
            map     = {},
            id_table= {},
            __index = handle_manager_class
        }
        object.top = 1 
        object.stack = {}
        object.map = {}
        object.id_table = {}
        setmetatable(object,object)
        return object
    end,

    destroy = function (self)
        
    end,

    allocate = function (self)
        local id = self.top
        local stack = self.stack
        if #stack == 0 then
            id = self.top
            self.top = self.top + 1
        else
            id = stack[#stack]
            table.remove(stack,#stack)
            self.map[id] = nil
        end
        self.id_table[id] = 1
        return id
    end,

    free = function (self,id)
        if self.id_table[id] == nil and self.map[id] ~= nil then
            ui_print('重复回收',id)
        elseif self.id_table[id] == nil then
            ui_print('非法回收',id)
        end
        if self.map[id] == nil and self.id_table[id] ~= nil then
            self.map[id] = 1
            self.id_table[id] = nil
            table.insert(self.stack,id)
        end
    end,


}


ui_base_class = {

    is_show = true,

    tooltip_list = {}, --存放所有提示框对象的列表

    handle_manager = handle_manager_class.create(),

    create = function (types,x,y,width,height)
        local index = ui_base_class.handle_manager:allocate()
        local ui = {
            x = x,
            y = y,
            w = width,
            h = height,
            children = {},
            _index = index,
            _name = types .. '_object_' .. tostring(index)
        }
        setmetatable(ui,ui)

        return ui
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        
        --从父控件表中移除该控件
        if self.parent and self.parent.children then 
            for i,child in ipairs(self.parent.children) do 
                if child == self then 
                    table.remove(self.parent.children,i)
                    break
                end 
            end

            if self.parent.on_update_child then 
                self.parent:on_update_child(self)
            end 
        end 


        japi.DestroyFrame(self.id)
        ui_base_class.handle_manager:free(self._index)
        
        self.id = nil
        
        local children = self.children
        self.children = nil
        for index,object in ipairs(children) do
            object:destroy()
        end
        

    end,

    
    show = function (self)
        if self.is_show then 
            return 
        end 
        self.is_show = true 
        japi.FrameShow(self.id,true)
    end,
    
    hide = function (self)
        if self.is_show == false then 
            return 
        end 
        self.is_show = false
        japi.FrameShow(self.id,false)
    end,
    

    set_alpha = function (self,value)
        if value <= 1 then 
            value = value * 0xff
        end
        japi.FrameSetAlpha(self.id,value)
    end,


    get_alpha = function (self)
        return japi.FrameGetAlpha(self.id)
    end,

    get_position = function (self)
        return self.x,self.y
    end,

    set_position = function (self,x,y)
        if self.id == nil or self.id == 0 then 
            return 
        end 
        self.x = x 
        self.y = y
        if self.parent and self.parent.enable_scroll and self ~= self.parent.scroll_button then 
            y = y - self.parent.scroll_y
        end 
        if self:is_in_scroll_panel() then 
            return 
        end 
        if self.parent == nil then 
            x,y = converScreenPosition(x,y)
            
            japi.FrameSetAbsolutePoint(self.id,0,x,y)
        else
            x =  x / 1920 * 0.8
            y = -y / 1080 * 0.6
            if self._base == 'TEXT' then 
                local align = self.align or 0
                if type(self.align) == 'string' then
                    align = self.align_map[self.align]
                end
                japi.FrameSetPoint(self.id,align,self._panel.id,align,0,0)--x,y)
                return
            end 
            japi.FrameSetPoint(self.id,0,self.parent.id,0,x,y)--x,y)
        end
    end,

    set_control_size = function (self,width,height)
        if self.id == nil or self.id == 0 then 
            return 
        end 
        self.w = width
        self.h = height 
        if self:is_in_scroll_panel() then 
            return 
        end 
        width,height = converScreenSize(width,height)
       
        japi.FrameSetSize(self.id,width,height)
        
    end,

    set_normal_image = function (self,image_path,flag)
        if self.id == nil or self.id == 0 then 
            return 
        end 

        if image_path == '' then 
            --image_path = 'Transparent.tga'
        end
        
        if image_path == '' then 
            image_path = 'Transparent.tga'
        elseif image_path:find("%.png") ~= nil then 
            image_path = "resource\\" .. image_path:gsub("%.png",".blp")
        elseif global_blp_map[image_path] == nil and storm.load(image_path) == nil then 
            image_path = 'Transparent.tga'
        end 
        
        self.normal_image = image_path
        japi.FrameSetTexture(self.id,image_path,flag or 0)
    end,

    set_tooltip = function(self,tip,x,y,width,height,font_size,offset)

        ui_base_class.remove_tooltip()

        offset = offset or 1
        local ox,oy
        if self ~= nil then 
            ox,oy = self:get_real_position()
            ox = ox + self.w / 2
        else
            ox = japi.GetMouseVectorX() / 1024
            oy = (-(japi.GetMouseVectorY() - 768)) / 768 
            ox = ox * 1920
            oy = oy * 1080
        end
       
        x = ox + x - width / 2 
        
        local path = 'image\\提示框\\Item_Prompt.tga'
        if type(tip) == 'string' then 
            local y = oy + y - height

            local panel = panel_class.create(path,x,y,width,height)
            local text = panel:add_text(tip,0,font_size,width,64,font_size,1) 
            panel:set_alpha(0.8)
            table.insert(ui_base_class.tooltip_list,panel)
        end
    end,

    

    remove_tooltip = function ()
        local count = #ui_base_class.tooltip_list
        for i = 1,count do 
            local control = ui_base_class.tooltip_list[1]
            if control ~= nil then 
                control:destroy()
            end 
            table.remove(ui_base_class.tooltip_list,1)
        end
    end,

    get_this_class = function (self)
        local metatable = getmetatable(self)
        return metatable.__index
    end,
    
    get_parent_class = function (self)
        local class = self:get_this_class()
        if class ~= nil then
            local metatable = getmetatable(class)
            return metatable.__index
        end
        return nil
    end,

    point_in_rect = function (self,x,y)
        local ox,oy = self:get_real_position()
        if x >= ox and 
            y >= oy and
            x <= ox + self.w and
            y <= oy + self.h 
            
        then
            return true
        end
        return false
    end,

    --获取实际坐标 父控件坐标 + 子控件偏移
    get_real_position = function (self)
        local ox,oy = 0,0
        local object = self 
        while object ~= nil do
            ox = ox + (object.x or 0)
            oy = oy + (object.y or 0)
            object = object.parent
        end
        return ox,oy
    end,

    get_is_show = function (self)
        local object = self 
        while object ~= nil do
            if object.is_show == false then 
                return false
            end 
            object = object.parent
        end
        return true
    end,
    
    
    get_child_max_y = function (self)
        local y = 0 
        if self.children then 
            for name,control in ipairs(self.children) do 
                if control.id 
                and (control.y + control.h) > y 
                and control ~= self.scroll_button 
                and control.is_show then 
                    y = control.y + control.h
                end 
            end 
        end 
        return y
    end,

    --是否在滚动的面板中
    is_in_scroll_panel = function (self)
        
        local parent = self.parent
        if parent and parent.scroll_button then 
            if self == parent.scroll_button then 
                return false 
            end 
            local y = self.y - (parent.scroll_y or 0)
            if (self.x < 0 or y < 0 
            or y + self.h > parent.h) and self ~= parent.scroll_button then 
                --隐藏超过面板的控件
                japi.FrameShow(self.id,false)
                parent.scroll_button:show()

                return true
            end 

            local max_y = parent:get_child_max_y() 
            --如果所有控件都在面板内 则隐藏滚动条
            if max_y < parent.h then 
                parent.scroll_button:hide()
            end 
            
            
            if self.is_show then 
                --显示滚动到面板中的控件
                japi.FrameShow(self.id,true)
            end 
        end 

        return false 
    end,
}

