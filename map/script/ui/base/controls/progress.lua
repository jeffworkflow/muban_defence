require 'ui.base.controls.model'



class.progress = extends(class.model){

    new = function (parent,path,x,y,width,height,font_size,font_alien,background)
        local param
        if type(path) == 'table' then 
            param = path 
            path = param.path 
        else 
            param = {}
        end 
        x = x or param.x or 0
        y = y or param.y or 0
        width = width or param.w or 0
        height = height or param.h or 0
        font_size = font_size or param.font_size or 10 
        font_alien = font_alien or param.font_alien or 'center'
        background = background or param.background or 'bar_cover.tga'

        local ui = class.model.new(parent,path,x,y,width,height)


        

        for k,v in pairs(param) do 
            ui[k] = v
        end 

        ui._texture = ui:add_texture('bar_cover.tga',ui.offset_x,ui.offset_y,width,height)
        ui._text = ui:add_text('',ui.offset_x,ui.offset_y,width,height,font_size,font_alien)
        ui:set_animation(0,true)

       
        ui.rate = 0
        ui.__index = class.progress

        ui:clear()
        return ui 
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        class.ui_base.destroy(self)
    end,

    set_value = function (self,value,max_value)
        local rate
        if max_value == 0 then 
            rate = 0 
        else 
            rate = value / max_value 
        end 
		local str = string.format('%.0f / %.0f (%.0f%%)',value,max_value, rate * 100 )
        self._text:set_text(str)
        self.rate = rate 
        if rate >= 1 then rate = 0.9999 end 
        if rate <= 0 then 
            rate = 0.0001
        end 

        local width = self.w * rate
        self._texture:set_position(width + self.offset_x,self.offset_y)
		self._texture:set_control_size(self.w - width ,self.h)
    end,

    clear = function (self)
        self._text:set_text('')
        self._texture:set_position(self.offset_x,self.offset_y)
		self._texture:set_control_size(self.w,self.h)
    end,


}

local mt = getmetatable(class.progress)

mt.__tostring = function (self)
    local str = string.format('进度条 %d',self.id or 0)
    return str
end
