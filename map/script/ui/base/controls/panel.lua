require 'ui.base.controls.class'

class.panel = extends(class.ui_base){

    --背景 类型 和基类
    _type  = 'panel',
    _base  = 'BACKDROP',

    panel_map = {},

    new = function (parent,image_path,x,y,width,height,scroll)
        local ui = class.ui_base.create('panel',x,y,width,height)

        ui.scroll_y = 0
        ui.enable_scroll = scroll or false 
       
        
        ui.__index = class.panel
      

        if ui.panel_map[ui._name] ~= nil then 
            class.ui_base.destroy(ui)
            log.error('创建背景失败 字符串id已存在')
            return 
        end 

        if parent then 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, parent.id, ui._type,0)
        else 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, game_ui, ui._type,0)
        end 
     
        if ui.id == nil or ui.id == 0 then 
            class.ui_base.destroy(ui)
            log.error('创建背景失败')
            return 
        end
   
        ui.panel_map[ui.id] = ui
        ui.parent = parent
        
        ui:set_position(x,y)
        ui:set_control_size(width,height)
        ui:set_normal_image(image_path)
        if scroll then 
            --添加一个滚动条
            ui:add_scroll_button()
        end 

        return ui
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end

        self.panel_map[self.id] = nil 
        self.panel_map[self._name] = nil

        class.ui_base.destroy(self)
    end,


    add = function (self,class,...)
        local child = class.add_child(self,...)
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

        local button = self:add_button('image\\背包\\bar_CloseButton_normal.tga',x,y,width,height)

        --左键按下 修改图片
        button.on_button_mousedown = function (self)
            self:set_normal_image('image\\背包\\bar_CloseButton_Press.tga')
            return false
        end

        --左键弹起 恢复图片
        button.on_button_mouseup = function (self)
            self:set_normal_image('image\\背包\\bar_CloseButton_normal.tga')
            return false
        end

        --按钮点击关闭
        button.on_button_clicked = function (self)
            class.ui_base.remove_tooltip()
            self.parent:hide()
            return false 
        end 
        --按钮文本提示
        button.on_button_mouse_enter = function (self)
            class.ui_base.set_tooltip(self,"关闭",0,0,240,64,16) 
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
            local px,py = self.parent:get_real_position()
            local oy = self.y
            y = y - py
            
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

    --移动动画 x y 是移动到目标的位置 value 为正数是 变大 负数是缩小 当小于0.01的时候就会隐藏value指变大或缩小百分比，target_size 为到某个程度后停止变大或缩小
    -- move_animation = function (self,tx,ty,value,target_value)
    --    local size = self.relative_size or 1  
    --    local interval = math.abs(value) * 2
    --    game.loop(33,function (timer)
           
    --        local sx,sy = self:get_real_position()
    --        local x,y = self.x,self.y 
       
    --        local exit = 0 
    --        if math.abs(sx - tx) > interval then 
    --            if sx > tx then 
    --                x = x - interval
    --            else 
    --                x = x + interval
    --            end 
    --        else 
    --            exit = exit + 1
    --        end 
    --        if math.abs(sy - ty) > interval then 
    --            if sy > ty then 
    --                y = y - interval
    --            else 
    --                y = y + interval
    --            end 
    --        else 
    --            exit = exit + 1
    --        end 

    --        if value > 0 then 
    --            self:show()
    --        end 
    --        if exit == 2 then 
    --            if size < 0.1 then 
    --                self:hide()
    --            end 
              
    --            timer:remove()
    --        else 
    --            self:set_position(x,y)
           
    --            size = size + (value / 100)
    --            if size > 0.1 and size < 10  then 
    --                 if target_size then
    --                     if ((value > 0 and size< target_size) or (value<0 and size > target_size)) then
    --                         self:set_relative_size(size)
    --                     end    
    --                 else    
    --                     self:set_relative_size(size)
    --                 end    
    --            end 
    --        end 
    --    end)
    -- end,



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
        local str = string.format('面板 %d',self.id or 0)
        return str
    end
}

