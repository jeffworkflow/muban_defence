require 'ui.base.controls.class'
require 'ui.base.controls.panel'

class.button = extends(class.panel){

    --按钮 类型 和 基类
    _type   = 'TestButton',
    _base   = 'GLUETEXTBUTTON',

    button_map = {},

    new = function (parent,image_path,x,y,width,height,has_ani)
        local ui = class.ui_base.create('button',x,y,width,height)

        ui.is_enable = true 
        ui.normal_image = image_path

        ui.__index = class.button

        if ui.button_map[ui._name] ~= nil then 
            class.ui_base.destroy(ui)
            log.error('创建按钮失败 字符串id已存在')
            return 
        end 
        if parent then 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, parent.id, ui._type,0)
        else 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, game_ui, ui._type,0)
        end 

        if ui.id == nil or ui.id == 0 then 
            class.ui_base.destroy(ui)
            log.error('创建按钮失败')
            return 
        end

        local panel = ui:add_panel(image_path,0,0,width,height)
        if panel == nil then 
            ui:destroy()
            log.error('按钮背景创建失败')
            return
        end
        panel._control = ui
        ui._panel = panel
        ui.button_map[ui._name] = ui
        ui.button_map[ui.id] = ui
        ui.parent = parent
        
        ui:set_position(x,y)
        ui:set_control_size(width,height)
        japi.FrameSetEnable(ui.id,false)

        if has_ani then 
            function ui:on_button_mouse_enter()
                self._ = {
                    x = self.x,
                    y = self.y,
                    w = self.w,
                    h = self.h 
                }
                self:set_position(self.x,self.y - self.h * 0.2)
                self:set_control_size(self.w * 1.2, self.h * 1.2)
            end 
    
            function ui:on_button_mouse_leave()
                self:set_position(self._.x,self._.y)
                self:set_control_size(self._.w,self._.h)
            end 
    
            function ui:on_button_mousedown()
                self:on_button_mouse_leave()
            end 
            function ui:on_button_mouseup()
                local x,y = game.get_mouse_pos()
                if self:point_in_rect(x,y) and self:get_is_show() then 
                    self:on_button_mouse_enter()
                else 
                    self:on_button_mouse_leave()
                end 
            end 
        end 
        return ui
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        self.button_map[self.id] = nil 
        self.button_map[self._name] = nil

        class.ui_base.destroy(self)

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
               
                hide_event_callback(
                    'on_button_update_cooldown',
                    button,
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
        
                        hide_event_callback('on_button_cooldown_end',button)
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

    set_normal_image = function (self,image_path,flag)
        self.normal_image = image_path
        self._panel:set_normal_image(image_path,flag)
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

local mt = getmetatable(class.button)

mt.__tostring = function (self)
    local str = string.format('按钮 %d',self.id or 0)
    return str
end
