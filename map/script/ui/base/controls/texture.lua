require 'ui.base.controls.panel'


class.texture = extends(class.panel){

    --存放所有存活的 texture控件对象
    object_map = {},

    new = function (parent,image_path,x,y,width,height)
        local control = class.texture:builder
        {
            parent = parent,
            normal_image = image_path,
            x = x,
            y = y,
            w = width,
            h = height,
        }
        return control 
    end,

    destroy = function (self)
        if self._id == nil or self._id == 0 then 
            return 
        end
        if self._timer then 
            self._timer:remove()
            self._timer = nil
        end 
        class.panel.destroy(self)
    end,

    play_animation = function (self,path,count,is_loop)
        local num = 0

        if self._timer then 
            self._timer:remove()
            self._timer = nil
        end 
        self._timer = game.loop(33,function (timer)
            num = num + 1
            local str = path .. string.format("\\0_%05d.png",num)
            if self._id == nil or self._id == 0 then 
                timer:remove()
            end 
            self:set_normal_image(str)
            if num >= count then 
                num = 0
            end 
        end)
    end,


    __tostring = function (self)
        local str = string.format('图像 %d',self._id or 0)
        return str
    end,
}
