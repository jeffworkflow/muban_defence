require 'ui.base.class'

panel_class = extends( ui_base_class,{

    --背景 类型 和基类
    _type  = 'panel',
    _base  = 'BACKDROP',

    panel_map = {},

    new = function (parent,image_path,x,y,width,height,scroll)
        local ui = ui_base_class.create('panel',x,y,width,height)

        ui.scroll_y = 0
        ui.enable_scroll = scroll or false 
       
        
        ui.__index = panel_class
      

        if ui.panel_map[ui._name] ~= nil then 
            ui_base_class.destroy(ui._index)
            log.error('创建背景失败 字符串id已存在')
            return 
        end 

        if parent then 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, parent.id, ui._type,0)
        else 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, game_ui, ui._type,0)
        end 
     
        if ui.id == nil or ui.id == 0 then 
            ui_base_class.destroy(ui._index)
            log.error('创建背景失败')
            return 
        end
   

        ui.panel_map[ui._name] = ui
        ui.panel_map[ui.id] = ui
        ui.parent = parent
        
        ui:set_position(x,y)
        ui:set_control_size(width,height)
        ui:set_normal_image(image_path)
        if scroll then 
            ui:add_scroll_button()
        end 

        return ui
    end,

    create = function (...)
        return panel_class.new(nil,...)
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end

        self.panel_map[self.id] = nil 
        self.panel_map[self._name] = nil

        ui_base_class.destroy(self)
    end,


    add_child = function (...)
        return panel_class.new(...)
    end,

    add_panel = function (self,...)
        local child = panel_class.add_child(self,...)
        table.insert(self.children,child)
        
        return child
    end,

    add_button = function (self,...)
        local child = button_class.add_child(self,...)
        table.insert(self.children,child)
        
        return child
    end,

    add_text = function (self,...)
        local child = text_class.add_child(self,...)
        table.insert(self.children,child)
        
        return child
    end,

    add_texture = function (self,...)
        local child = texture_class.add_child(self,...)
        table.insert(self.children,child)
        
        return child
    end,

    add_sprite = function (self,...)
        local child = sprite_class.add_child(self,...)
        table.insert(self.children,child)
        
        return child
    end,

    add_input = function (self,...)
        local child = input_class.add_child(self,...)
        table.insert(self.children,child)
        
        return child
    end,

     --添加一个可以拖动的标题 来拖动整个界面
    add_title_button = function (self,image_path,title,x,y,width,height,font_size)
        local button = self:add_button(image_path,x,y,width,height)
        button.text = button:add_text(title,0,0,width,height,font_size,4)
        button.message_stop = true
        button:set_enable_drag(true)

        --移动
        button.on_button_update_drag = function (self,icon_button,x,y)
            icon_button:set_control_size(0,0)
            self.parent:set_position(x,y)
            return false 
        end
        return button
    end,

    --添加一个关闭按钮 点击即可关闭
    add_close_button = function (self,x,y,width,height)
        width = width or 36
        height = height or 36
        x = x or self.w - width * 1.5
        y = y or 14

        local button = self:add_button('image\\背包\\diany_02.png',x,y,width,height)

        --左键按下 修改图片
        button.on_button_mousedown = function (self)
            self:set_normal_image('image\\背包\\diany_02_liang1.png')
            return false
        end

        --左键弹起 恢复图片
        button.on_button_mouseup = function (self)
            self:set_normal_image('image\\背包\\diany_02.png')
            return false
        end

        --按钮点击关闭
        button.on_button_clicked = function (self)
            ui_base_class.remove_tooltip()
            self.parent:hide()
            return false 
        end 
        --按钮文本提示
        button.on_button_mouse_enter = function (self)
            ui_base_class.set_tooltip(self,"关闭",0,0,240,64,16) 
            return false 
        end 
        return button
    end,

    set_scroll_y = function (self,y)
        local max_y = self:get_child_max_y()
        if y == 0 then 
        elseif y + self.h > max_y then 
            y = max_y - self.h
        elseif y < 0 then 
            y = 0
        end     

        self.scroll_y = y
        --滚动的时候刷新UI所有子控件位置
        for key,control in pairs(self.children) do
            if control ~= self.scroll_button then  
                control:set_position(control.x,control.y)
            end 
        end 
        local value = y / (max_y - self.h)
        local button = self.scroll_button
        if button then 
            button:set_position( button.x,value * (self.h - button.h))
        end

    end,

    --添加一个滚动条
    add_scroll_button = function (self)
        local path = 'image\\提示框\\Item_Prompt.tga'
        local button = self:add_button(path,self.w - 16,0,16,64)

        button.message_stop = true
        button:set_enable_drag(true)

        --移动
        button.on_button_update_drag = function (self,icon_button,x,y)
            local oy = self.y
            y = y - self.parent.y
            
            if y + self.h > self.parent.h then 
                y = self.parent.h - self.h
            elseif y < 0 then
                y = 0
            end 
            icon_button:set_control_size(1,1)
            self:set_position(self.x,y)


            local value = y / (self.parent.h - self.h)
            local sy = value * (self.parent:get_child_max_y() - self.h)
            
            self.parent:set_scroll_y(sy)
            return false 
        end
        self.scroll_button = button 
    end,


    --当鼠标滚动面板事件
    on_panel_scroll_fix = function (self)
        self:set_scroll_y(self.scroll_y)
    end,

    --[[
    --面板滚动事件 bool 
    on_panel_scroll = function (self,bool)

    end,

    ]]

    __tostring = function (self)
        local str = string.format('面板 %d',self.id)
        return str
    end
})

