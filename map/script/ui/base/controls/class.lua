--[[

    基础类的封装 主要重载一些UI功能为对象形式

]]


storm = require 'jass.storm'
japi  = require 'jass.japi'

game_ui     = japi.GetGameUI()

global_blp_map = {}





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
    height = height / 1080  * 0.6
    return width,height
end


function extends (...)
    local parents = {...}
	local count = select('#',...)
    return function (child_class)
        local parent_class = parents[1]
        local tbl = {}
        local mt = getmetatable(parent_class)
        if mt ~= nil then
            tbl.__tostring = mt.__tostring
            tbl.__call = mt.__call
        end

        if count == 1 then
            tbl.__index = parent_class
        else
            tbl.__index = function (self,key)
                for i = 1,count do
					local v = parents[i]
                    if v and v[key] then
                        return v[key]
                    end
                end
            end
        end

        setmetatable(child_class,tbl)
        return child_class
    end
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


--给所有类注册模板方法 
class = {
    __newindex = function (self,name,value)
        if not rawget(value,'create') then 
            --create = new(nil,...)
            value.create = function (...)
                return value.new(nil,...)
            end
        end
    
        if not rawget(value,'add_child') then 
            --add_child = new(...)
            value.add_child = function (...)
                return value.new(...)
            end
        end

        if not rawget(value,'get_instance') then 
            value.get_instance = function ()
                local instance = value.instance 
                if instance == nil then 
                    instance = value.create()
                    value.instance = instance
                end 
                return instance
            end 
        end 

        rawset(self,name,value)

        if class.panel and not class.panel['add_' .. name] then 
            -- add_<class> = parent:add(class,...)
            class.panel['add_' .. name]  = function (parent,...)
                return parent:add(value,...)
            end
        end 
        
    end,
}

setmetatable(class,class)


class.handle_manager = {
    
    create = function ()
        local object = {
            top     = 1,
            stack   = {},
            map     = {},
            id_table= {},
            __index = class.handle_manager
        }
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


class.ui_base = {

    is_show = true,

    tooltip_list = {}, --存放所有提示框对象的列表

    handle_manager = class.handle_manager.create(),

    create = function (types,x,y,width,height)
        local index = class.ui_base.handle_manager:allocate()
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
        class.ui_base.handle_manager:free(self._index)
        
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

    set_time = function (self,time)
        game.wait(time * 1000,function ()
            self:destroy()
        end)
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

        if self._base == 'TEXT' then 
            --文本仅改变对齐方式，而坐标由文本的panel 来控制
            local align = self.align or 0
            if type(self.align) == 'string' then
                align = self.align_map[self.align] or 0
            end
            align = math.max(align,0)
            japi.FrameSetPoint(self.id,align,self._panel.id,align,0,0)
            return
        end 

        if self.parent == nil then 
            x,y = converScreenPosition(x,y)
 
            japi.FrameSetAbsolutePoint(self.id,0,x,y)
        else
            x =  x / 1920 * 0.8
            y = -y / 1080 * 0.6
            
            japi.FrameSetPoint(self.id,0,self.parent.id,0,x,y)
        end
    end,

    --设置控件大小
    set_control_size = function (self,width,height)
        if self.id == nil or self.id == 0 then 
            return 
        end 
        self.w = width
        self.h = height 
    
        width,height = converScreenSize(width,height)
       
        japi.FrameSetSize(self.id,width,height)
        
        self:is_in_scroll_panel()
    end,

    --一次性设置所有控件相对原本的大小
    set_relative_size = function (self,size)
        local old_size = self.relative_size or 1 
        local real_size = 1 / old_size * size 
        self.relative_size = size 
        if self.set_size then 
            self:set_size(self.size or 1)
        end 
        if self._control == nil then 
            self:set_control_size(self.w * real_size,self.h * real_size)
        end
        for index,child in ipairs(self.children) do
            if child._control == nil then 
                child:set_relative_size(size)
                child:set_position(child.x * real_size,child.y * real_size)
            end
        end
    end,

    set_normal_image = function (self,image_path,flag)
        if self.id == nil or self.id == 0 then 
            return 
        end 
        
        if image_path == '' then 
            image_path = 'Transparent.tga'
       elseif image_path:find("%.png") ~= nil then 
           image_path = "resource\\" .. image_path:gsub("%.png",".blp")
       --elseif global_blp_map[image_path] == nil and storm.load(image_path) == nil then 
       --    image_path = 'Transparent.tga'
        end 
        if image_path == self.normal_image then 
            return 
        end 
        
        self.normal_image = image_path
        japi.FrameSetTexture(self.id,image_path,flag or 0)
    end,


    update_normal_image = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        local image = self.normal_image or ''
        self.normal_image = ''
        self:set_normal_image(image)
    end,

    set_tooltip = function(self,tip,x,y,width,height,font_size,offset)

        class.ui_base.remove_tooltip()

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

            local panel = class.panel.create(path,x,y,width,height)
            local text = panel:add_text(tip,0,font_size,width,64,font_size,1) 
            panel:set_alpha(0.8)
            table.insert(class.ui_base.tooltip_list,panel)
        end
    end,

    

    remove_tooltip = function ()
        local count = #class.ui_base.tooltip_list
        for i = 1,count do 
            local control = class.ui_base.tooltip_list[1]
            if control ~= nil then 
                control:destroy()
            end 
            table.remove(class.ui_base.tooltip_list,1)
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
            if object.parent then
                oy = oy - (object.parent.scroll_y or 0)
            end
            object = object.parent
        end
        return ox,oy
    end,

    get_is_show = function (self)
        local object = self 
        while object ~= nil do
            if object.is_show == false or object.scroll_hide then 
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
        if parent == nil then 
            return false
        end 

        local scroll = parent.scroll_button
        if scroll == nil then 
            return false
        end 
 
        if self == scroll then 
            return false 
        end 
        local max_y = parent:get_child_max_y() 
        local y = self.y - (parent.scroll_y or 0)
        if (self.x < 0 or y < 0 or y + self.h > parent.h) and self ~= scroll then 

            self.scroll_hide = true 
            --隐藏超过面板的控件
            japi.FrameShow(self.id,false)
            --显示滚动条 并设置滚动条尺寸
            scroll:show()
            local size = parent.h / max_y 
            scroll:set_control_size(scroll.w,size * parent.h )
            return true
        end 
        
        --如果所有控件都在面板内 则隐藏滚动条
        if max_y < parent.h then 
            scroll:hide()
        end 
        
        
        if self.is_show then 
            --显示滚动到面板中的控件
            self.scroll_hide = nil
            japi.FrameShow(self.id,true)
        end 
       

        return false 
    end,
}

