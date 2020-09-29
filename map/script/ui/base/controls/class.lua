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
        local _id = self.top
        local stack = self.stack
        if #stack == 0 then
            _id = self.top
            self.top = self.top + 1
        else
            _id = stack[#stack]
            table.remove(stack,#stack)
            self.map[_id] = nil
        end
        self.id_table[_id] = 1
        return _id
    end,

    free = function (self,_id)
        if self.id_table[_id] == nil and self.map[_id] ~= nil then
           print('重复回收',_id, debug.traceback())
        elseif self.id_table[_id] == nil then
            print('非法回收',_id, debug.traceback())
        end
        if self.map[_id] == nil and self.id_table[_id] ~= nil then
            self.map[_id] = 1
            self.id_table[_id] = nil
            table.insert(self.stack,_id)
        end
    end,


}


class.ui_base = {

--static
    handle_manager = class.handle_manager.create(),

--public
    x = 0, --x轴

    y = 0, --y轴

    w = 0, -- width 控件宽
    
    h = 0, --height 控件高

    is_show = true, --当前是否显示状态 默认true

    children = nil, --控件的 所有存活的子控件

    bind_world = false, --是否绑定在世界坐标

    world_x = 0, --世界坐标x轴

    world_y = 0, --世界坐标y轴

    world_z = 0, --世界坐标z轴

    world_unit = nil, --控件绑定头顶的单位对象

    level = 0, --层级

    alpha = 1, --透明度


--private
    _index = nil, --唯一整数识标

    _name = nil, --唯一的字符串识标

    create = function (types,x,y,width,height)
        local index = class.ui_base.handle_manager:allocate()
        local ui = {
            x = x,
            y = y,
            w = width,
            h = height,
            children = {},
            _index = index,
            _name = types .. '_object_' .. tostring(index),
        }
        setmetatable(ui,ui)
        return ui
    end,

    destroy = function (self)
        if self._id == nil or self._id == 0 then 
            return 
        end
        if self.bind_world then 
            self:unbind_world()
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
        japi.DestroyFrame(self._id)
        class.ui_base.handle_manager:free(self._index)
        self._id = nil
        
        local children = self.children
        self.children = nil
        for index,object in ipairs(children) do
            object:destroy()
        end
    end,

    init = function (self)
        
        self:set_position(self.x, self.y)
        self:set_control_size(self.w, self.h)
        self:set_level(self.level)
        self:set_alpha(self.alpha)
       
        if self.is_show == false then 
            japi.FrameShow(self._id,false)
        end
        return self
    end,

    show = function (self)
        if self.is_show then 
            return 
        end 
        self.is_show = true 
        japi.FrameShow(self._id,true)
    end,
    
    hide = function (self)
        if self.is_show == false then 
            return 
        end 
        self.is_show = false
        japi.FrameShow(self._id,false)
    end,
    

    set_alpha = function (self,value)
        if value <= 1 then 
            value = value * 0xff
        end
        japi.FrameSetAlpha(self._id,value)
    end,

    set_time = function (self,time)
        game.wait(time * 1000,function ()
            self:destroy()
        end)
    end,

    get_alpha = function (self)
        return japi.FrameGetAlpha(self._id)
    end,

    get_position = function (self)
        return self.x,self.y
    end,

    set_position = function (self,x,y)
        if self._id == nil or self._id == 0 then 
            return 
        end 
        self.x = x 
        self.y = y
        if self.parent and self.parent.is_scroll and self ~= self.parent.scroll_button then 
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
            japi.FrameSetPoint(self._id,align,self._panel._id,align,0,0)
            return
        end 

        if self.parent == nil then 
            x,y = converScreenPosition(x,y)
 
            japi.FrameSetAbsolutePoint(self._id,0,x,y)
        else
            x =  x / 1920 * 0.8
            y = -y / 1080 * 0.6
            
            japi.FrameSetPoint(self._id,0,self.parent._id,0,x,y)
        end
    end,

    get_width = function (self)
        return japi.FrameGetWidth(self._id) / 0.8 * 1920
    end,

    get_height = function (self)
        return japi.FrameGetHeight(self._id) / 0.6 * 1080
    end,

    set_width = function (self, width)
        self.w = width
        japi.FrameSetWidth(self._id, width / 1920 * 0.8)
    end,

    set_height = function (self, height)
        self.h = height
        japi.FrameSetHeight(self._id, height / 1080 * 0.6)
    end,

    --设置控件大小
    set_control_size = function (self,width,height)
        if self._id == nil or self._id == 0 then 
            return 
        end 
        self.w = width
        self.h = height 
    
        width,height = converScreenSize(width,height)
       
        japi.FrameSetSize(self._id,width,height)
        
        self:is_in_scroll_panel()
    end,

    set_level = function (self, level)
        japi.FrameSetLevel(self._id, level)
    end,
      

    --一次性设置所有控件相对原本的大小
    set_relative_size = function (self, size, not_scale_font)
        local scale = self._scale or 1
        local default = self.default_size or 1
        local old_size = (self.relative_size or 1) * default

        local real_size = 1 / old_size * size * scale
        self.relative_size = size 
        self.default_size = scale

        if self.set_size and not_scale_font ~= true then 
            self:set_size(self.size or 1)
        end 
        if self._control == nil then 
            self:set_control_size(self.w * real_size,self.h * real_size)
        end
        for index,child in ipairs(self.children) do
            if child._control == nil then
                child._scale = scale 
                child:set_relative_size(size, not_scale_font)
                child:set_position(child.x * real_size,child.y * real_size)
            end
        end
    end,

    set_normal_image = function (self,image_path,flag)
        if self._id == nil or self._id == 0 then 
            return 
        end 
        
        if image_path == '' then 
            image_path = 'Transparent.tga'
        end 
        if image_path == self.normal_image then 
            return 
        end 
        
        self.normal_image = image_path
        japi.FrameSetTexture(self._id,image_path,flag or 0)
    end,


    update_normal_image = function (self)
        if self._id == nil or self._id == 0 then 
            return 
        end
        local image = self.normal_image or ''
        self.normal_image = ''
        self:set_normal_image(image)
    end,

    set_tooltip = function(self,tip,x,y,width,height,font_size,offset)

    end,


    remove_tooltip = function ()
       
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

    --设置实际坐标位置 坐标 - 父控件坐标 = 子控件偏移
    set_real_position = function (self, x, y)
        local rx, ry = self:get_real_position()
        x = x - (rx - self.x) 
        y = y - (ry - self.y)
        self:set_position(x, y)
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
                if control._id 
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
            japi.FrameShow(self._id,false)
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
            japi.FrameShow(self._id,true)
        end 
       

        return false 
    end,

    --绑定在单位头顶 血条位置
    bind_unit_overhead = function (self, unit)

        self.world_unit = unit
        self.bind_world = true 
        game.bind_world(self, true)
    end,

    --绑定世界坐标
    set_world_position = function (self, x, y, z)
        if self.parent then 
            print('必须是底层控件才可以绑定到世界坐标', debug.traceback())
            return 
        end 

        self.world_x = x or 0
        self.world_y = y or 0
        self.world_z = z or 0

        self.bind_world = true 

        game.bind_world(self, true)
    end,

    unbind_world = function (self)
        self.bind_world = false 
        self.world_unit = nil
        game.bind_world(self, false)
    end,


    --控件事件分发回调
    event_notify = function (self, event_name, ...)
        local object = self
        while object ~= nil do
            if object.is_show == false then 
                return
            end
            object = object.parent
        end

        self:event_callback(event_name, ...)

        if self.sync_key then 
            game.add_event_sync(self, event_name, ...)
        end 
    end,

    --事件回调
    event_callback = function (self, event_name, ...)
        local retval = true
        local func = self[event_name]
        if func then
            retval = func(self,...)
        end
        if self.message_stop == true then --停止消息对父控件的转发
            return 
        end
        if retval == nil then 
            retval = true
        end
        --将消息转发到父类对象里
        local object = self.parent
        while object ~= nil and retval ~= false do
            local method = object[event_name]
            if method ~= nil then
                retval = method(object, self, ...)
            end
            object = object.parent
        end
    end,


    --[[
        获取指定锚点相对偏移 以0,0,控件宽,高 坐标起始点以及终点
        anchor = 
            topleft         = 0,
            top             = 1,
            topright        = 2,
            left            = 3,
            center          = 4,
            right           = 5,
            bottomleft      = 6,
            bottom          = 7,
            bottomright     = 8,

        is_negation 是否取反 anchor 左 返回 右 的值
    ]]
    get_anchor_offset = function (self, anchor, is_negation)
        anchor = anchor or 0 
        anchor = class.text.align_map[anchor] or anchor

        if is_negation then 
            anchor = math.abs(8 - anchor) 
        end 

        if anchor == 0 then 
            return 0, 0
        elseif anchor == 1 then 
            return self.w / 2, 0
        elseif anchor == 2 then 
            return self.w, 0
        elseif anchor == 3 then 
            return 0, self.h / 2
        elseif anchor == 4 then 
            return self.w/ 2, self.h / 2
        elseif anchor == 5 then 
            return self.w, self.h / 2
        elseif anchor == 6 then 
            return 0, self.h
        elseif anchor == 7 then 
            return self.w / 2, self.h
        elseif anchor == 8 then 
            return self.w, self.h
        end 
        return 0, 0
    end,

    get_anchor_offset_position = function (self, anchor, is_negation)
        local x, y = self:get_real_position()
        local ox, oy = self:get_anchor_offset(anchor, is_negation)
        return x + ox, y + oy 
    end,

    --设置锚点位置, 
    --self 自己
    --self_anchor 自己的锚点
    --target 目标
    --target_anchor 目标的锚点
    --x 相对偏移x轴
    --y 相对偏移y轴
    set_anchor_position = function (self, self_anchor, target, target_anchor, x, y)
        local self_x, self_y = self:get_anchor_offset_position(self_anchor)

        local target_x, target_y = target_anchor:get_anchor_offset_position(target_anchor)

        self:set_real_position(target_x + x, target_y + y)
    end,
    
    set_tooltip_follow = function (self, tooltip, anchor, offset_x, offset_y)
        local self_x, self_y = self:get_anchor_offset_position(anchor)

        local w, h = tooltip:get_anchor_offset(anchor, true)

        local x, y = self_x + (offset_x or 0), self_y + (offset_y or 0)
        x = x - w
        y = y - h
        x = math.max(0,math.min(1920 - tooltip.w, x))
        y = math.max(0,math.min(1080 - tooltip.h, y))

        tooltip:set_real_position(x, y)
    end,
   
}

