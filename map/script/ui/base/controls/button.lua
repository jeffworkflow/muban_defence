require 'ui.base.controls.class'
require 'ui.base.controls.panel'

class.button = extends(class.panel){

--static
    button_map = {}, --存放所有存活的按钮控件

--public
    is_enable = true, --当前按钮是否启用状态  false为禁用

    has_ani = false, --是否带缩放动画效果

    normal_image = '', -- 按钮背景图片

    hover_image = '', --进入时的图像

    active_image = '', --左键按下激活时的图像

--private
    _type   = 'button',  --fdf 中的模板类型

    _base   = 'GLUETEXTBUTTON', --fdf 中的控件类型


    --构建
    build = function (self)
        if self.parent then 
            self._id = japi.CreateFrameByTagName( self._base, self._name, self.parent._id, self._type,0)
        else 
            self._id = japi.CreateFrameByTagName( self._base, self._name, game_ui, self._type,0)
        end 

        if self._id == nil or self._id == 0 then 
            class.ui_base.destroy(self)
            log.error('创建按钮失败')
            return 
        end

        local panel = self:add_panel(self.normal_image, 0, 0, self.w, self.h)
        if panel == nil then 
            self:destroy()
            log.error('按钮背景创建失败')
            return
        end
        panel._control = self
        self._panel = panel
        self.button_map[self._id] = self

        japi.FrameSetEnable(self._id, false)
        self:init()

        if self.has_ani then 
            self:add_traceable_animation()
        end 
        return self
    end,

    new = function (parent,image_path,x,y,width,height,has_ani)
        local ui = class.button:builder
        {
            parent = parent,
            normal_image = image_path,
            x = x,
            y = y,
            w = width,
            h = height,
            has_ani = has_ani,
        }
        return ui
    end,

    destroy = function (self)
        if self._id == nil or self._id == 0 then 
            return 
        end
        self._panel:destroy()

        self.button_map[self._id] = nil 

        class.ui_base.destroy(self)

    end,


    add_traceable_animation = function (self)
        function self:on_button_mouse_enter()
            if not self._is_ani then 
                self._is_ani = true 
  
                local w, h = self.w, self.h 
                self._scale = 1.2
                self:set_relative_size(self.relative_size or 1)
                self:set_position(self.x - (self.w - w) / 2 ,self.y - (self.h - h) / 2)
            end

            
        end 

        function self:on_button_mouse_leave()
            if self._is_ani then 
                
                local w, h = self.w, self.h
                self._scale = 1
                self:set_relative_size(self.relative_size or 1)
                self:set_position(self.x - (self.w - w) / 2 ,self.y - (self.h - h) / 2)
                self._is_ani = false
            end 

            
        end 

        function self:on_button_mousedown()
            
            self:on_button_mouse_leave()
        end 

        function self:on_button_mouseup()
            local x,y = game.get_mouse_pos()
            if self:point_in_rect(x,y) and self:get_is_show() then 
                self:on_button_mouse_enter()
            else 
                self:on_button_mouse_leave()
            end 
        end 
    end,

    --添加cd动画
    add_cd_animation = function (self,x,y,width,height)
        if self._cd_animation == nil then 
            local texture = self:add_texture('',x,y,width,height)
            texture.bx = x 
            texture.by = y
            texture.bw = width 
            texture.bh = height
            texture:set_alpha(0.7)
            texture:hide()
            self._cd_animation = texture
        end
    end,

    --时间单位 秒  currentValue 剩余时间   maxValue 总时间
    set_cd = function (self,currentValue,maxValue)
        if self._cd_animation == nil then 
            print('该按钮缺少cd动画 要调用add_cd_animation 初始化')
            return 
        end 
       
        if currentValue ~= nil and currentValue > 0 then 
            self:set_enable(false,true)
            self.is_cooldown = true 
            self._cd = currentValue
            self._max_cd = maxValue
            self._cd_animation:set_normal_image('image\\提示框\\Item_Prompt.tga')
            self._cd_animation:show()

            game.loop(50,function (timer)
                local button = self
                local texture = self._cd_animation

                button._cd = button._cd - 0.05
               
                button:event_callback(
                    'on_button_update_cooldown',
                    math.max(button._cd,0),
                    button._max_cd
                )
                --cd结束时 显示0.1秒图像 闪烁一下
                if button._cd >= 0 then 
                    local value = texture.bh * button._cd / button._max_cd
                    texture:show()
                    texture:set_position(texture.bx,texture.by + texture.bh - value)
                    texture:set_control_size(texture.bw,value)
                    
                else 
                    texture:set_normal_image('image\\图标背景\\lan.tga')
                    texture:set_position(texture.bx,texture.by)
                    texture:set_control_size(texture.bw,texture.bh)
                    if button._cd < -0.1 then 
                        local texture = button._cd_animation

                        button:set_enable(true)
        
                        button.is_cooldown = nil
                        texture:hide()
        
                        button:event_callback('on_button_cooldown_end')
                        timer:remove()
                    end 
                end
            end)
        end
        
    end,

    get_cd = function (self)
        return self._cd,self._max_cd
    end,

    set_enable_image = function (self,image_path,x,y,width,height)
        self._enable_param = {image_path or 'image\\提示框\\Item_Prompt.tga',x,y,width,height}
    end,

    --最后一位 为默认参数 如果不需要灰色图层 填 true即可
    set_enable = function (self,is_enable,not_black)
        self.is_enable = is_enable
        if is_enable then 
            if self._normal ~= nil then 
                self._normal:destroy()
                self._normal = nil
            end
        else
            if self._normal == nil 
            and self.normal_image ~= ''
            and storm.load(self.normal_image) ~= nil
            and not_black ~= true then 
                if self._enable_param then 
                    self._normal = self:add_texture(table.unpack(self._enable_param))
                else 
                    self._normal = self:add_texture('image\\提示框\\Item_Prompt.tga',0,0,self.w,self.h)
                end
                self._normal:set_alpha(0.7)
            end
        end
    end,

    set_message_stop = function (self,is_stop)
        self.message_stop = is_stop
    end,

    set_enable_drag = function (self,enable)
        self.is_drag = enable
    end,

    set_enable_move_event = function (self,enable)
        self.is_move_event = enable
    end,

    --正常状态下的图形
    set_normal_image = function (self,image_path,flag)
        self.normal_image = image_path
        self._panel:set_normal_image(image_path,flag)
    end,

    --进入时图形
    set_hover_image = function (self, image_path)

        self.hover_image = image_path
        if image_path == '' then 
            image_path = 'Transparent.tga'
        end 
        if self.is_enter then
            self._panel:set_normal_image(image_path)
        end 
    end,

    --点击激活时的图像
    set_active_image = function (self, image_path)

        self.active_image = image_path
        if image_path == '' then 
            image_path = 'Transparent.tga'
        end 
        if self.is_enter then
            self._panel:set_normal_image(image_path)
        end 
    end,

    set_control_size = function (self,width,height)
        class.ui_base.set_control_size(self,width,height)
        if self._panel then 
            self._panel:set_control_size(width,height)
        end
    end,


    set_alpha = function (self,alpha)
        self.alpha = alpha
        self._panel:set_alpha(alpha)
    end,

    set_level = function (self, level)
        class.panel.set_level(self,level)
        self._panel:set_level(level)
    end,


    __tostring = function (self)
        local str = string.format('按钮 %d',self._id or 0)
        return str
    end
    -----------------所有按钮事件------------------

    --[[
    --左键点击
    on_button_clicked = function (self)
        print('左键点击',tostring(self))
    end,

    --左键按下
    on_button_mousedown = function (self)
        print('左键按下',tostring(self))
    end,

    --左键弹起
    on_button_mouseup = function (self)
        print('左键弹起',tostring(self))
    end,

    --右键点击
    on_button_right_clicked = function (self)
        print('右键点击',tostring(self))
    end,

    --右键按下
    on_button_right_mousedown = function (self)
        print('右键按下',tostring(self))
    end,

    --右键弹起
    on_button_right_mouseup = function (self)
        print('右键弹起',tostring(self))
    end,

    --鼠标进入
    on_button_mouse_enter = function (self)
        print('鼠标进入',tostring(self))
    end,

    --鼠标离开
    on_button_mouse_leave = function (self)
        print('鼠标离开',tostring(self))
    end,

    --当用户按下 self.keys = {'Q','W','E','R'} 中的按键时 才会响应
    on_button_key_down = function (self, str)

    end,

    --当用户弹起 self.keys = {'Q','W','E','R'} 中的按键时 才会响应
    on_button_key_up = function (self, str)

    end,

    --开始拖拽按钮
    on_button_begin_drag = function (self)
        print('开始拖拽按钮',tostring(self))
    end,
    
    --拖拽结束
    -- self 自身拖拽的按钮  target 拖拽点上的按钮  如果拖到空地 target则为nil
    on_button_drag_and_drop = function (self,target)
        print('拖拽结束',tostring(self),tostring(target))
    end,

    --拖拽更新事件 icon为拖拽时生成的texture图像 可以改变大小 图像内容 不要自己删除。 
    -- x,y 为鼠标坐标
    on_button_update_drag = function (self,icon,x,y)
        print('拖拽更新事件',tostring(self),tostring(icon),x,y)
    end,
    
    --按钮更新冷却时间事件 cd 剩余时间  max_cd 总时间
    on_button_update_cooldown = function (self,cd,max_cd)

    end,

    --按钮冷却结束事件
    on_button_cooldown_end = function (self)
    
    end,

    ]]

   
}
