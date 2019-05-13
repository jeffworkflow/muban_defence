require 'ui.base.panel'



texture_class = extends( panel_class,{
    --图片 类型 和基类
    _type  = 'panel',
    _base  = 'BACKDROP',

    texture_map = {},
    new = function (parent,image_path,x,y,width,height)
        local ui = ui_base_class.create('texture',x,y,width,height)

        ui.__index = texture_class

        if ui.texture_map[ui._name] ~= nil then 
            ui_base_class.destroy(ui._index)
            print('创建图片失败 字符串id已存在')
            return 
        end 

        if parent then 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, parent.id, ui._type,0)
        else 
            ui.id = japi.CreateFrameByTagName( ui._base, ui._name, game_ui, ui._type,0)
        end 

        if ui.id == nil or ui.id == 0 then 
            ui_base_class.destroy(ui._index)
            print('创建图片失败')
            return 
        end
  
        ui.texture_map[ui._name] = ui
        ui.texture_map[ui.id] = ui
        ui.parent = parent

        

        ui:set_position(x,y)
        ui:set_control_size(width,height)
        ui:set_normal_image(image_path)

        return ui 
    end,

    create = function (...)
        return texture_class.new(nil,...)
    end,

    add_child = function (...)
        return texture_class.new(...)
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        if self._timer then 
            self._timer:remove()
            self._timer = nil
        end 
        self.texture_map[self.id] = nil 
        self.texture_map[self._name] = nil

        ui_base_class.destroy(self)
       

    end,

    play_animation = function (self,path,count,is_loop)
        local num = 0

        if self._timer then 
            self._timer:remove()
            self._timer = nil
        end 
        self._timer = game.loop(33,function (timer)
            num = num + 1
            local str = path .. string.format("\\0_%05d.blp",num)
            if self.id == nil or self.id == 0 then 
                timer:remove()
            end 
            self:set_normal_image(str)
            if num == 14 then 
                num = 0
            end 
        end)
    end,

})

local mt = getmetatable(texture_class)

mt.__tostring = function (self)
    local str = string.format('图像 %d',self.id)
    return str
end
