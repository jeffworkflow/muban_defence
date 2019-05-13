require 'ui.base.class'
require 'ui.base.panel'

local font = [[
    Frame "TEXT" "text%d" {
        LayerStyle "IGNORETRACKEVENTS",
        FrameFont "resource\fonts\FZHTJW.ttf", %f, "", 
    }
]]


local font_map = {}

local function load_font(font,size)
    if font_map[size] ~= nil then 
        return 
    end
    size = math.modf(size)
    font_map[size] = 1
    local data = string.format(font,size,size/1000)
    load_fdf(data)
end

text_class = extends( panel_class,{

    --文字 类型 和 基类
    _type   = 'text',
    _base   = 'TEXT',

    text_map = {},

    align_map = {
        topleft         = 0,
        top             = 1,
        topright        = 2,
        left            = 3,
        center          = 4,
        right           = 5,
        buttomleft      = 6,
        button          = 7,
        buttomright     = 8
    },

    new = function (parent,text,x,y,width,height,font_size,align)
        font_size = font_size or 16
        local ui = ui_base_class.create('text',x,y,width,height)

        ui.align = align or 0
        
        ui.__index = text_class

        if ui.text_map[ui._name] ~= nil then 
            ui_base_class.destroy(ui._index)
            print('文字创建失败 字符串id已经存在')
            return 
        end 

        local panel 
        if parent then 
            panel = parent:add_panel('',0,0,width,height)
        else 
            panel = panel_class.create('',0,0,width,height)
        end 

        if panel == nil then 
            print('文字背景创建失败')
            return
        end
        ui._panel = panel 

        if type(font_size) == 'boolean' then 
            ui._type = 'old_text'
        else
            load_font(font,font_size)
            ui._type = string.format('%s%d',ui._type,font_size)
        end
        --ui._type = string.format('%s%d',ui._type,font_size)

        ui.id = japi.CreateFrameByTagName( ui._base, ui._name, panel.id, ui._type,align or 0)
        if ui.id == nil or ui.id == 0 then 
            panel:destroy()
            ui_base_class.destroy(ui._index)
            print('创建文字失败')
            return 
        end

        ui.text_map[ui._name] = ui
        ui.text_map[ui.id] = ui
        ui.parent = parent

        ui:set_position(x,y)
        --ui:set_control_size(width,height)
        ui:set_text(text)
        return ui
    end,

    create = function (...)
        return text_class.new(nil,...)
    end,

    add_child = function (...)
        return text_class.new(...)
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        self._panel:destroy()
 
        self.text_map[self.id] = nil 
        self.text_map[self._name] = nil

        ui_base_class.destroy(self)
    end,

    set_text = function (self,text)
        japi.FrameSetText(self.id,text)
    end,

    get_text = function (self)
        return japi.FrameGetText(self.id)
    end,


    set_color = function (self,...)
        local arg = {...}
        local color =0
        if #arg == 1 then 
            color = arg[1]
            local a = (color << 32) >> 56
            local r = (color << 40) >> 56
            local g = (color << 48) >> 56
            local b = (color << 56) >> 56
            self.color = {r = r,g = g,b = b,a = a/0xff}
        else 
            local r,g,b,a = table.unpack(arg)
            self._panel:set_alpha(a)
            self.color = {r = r,g = g,b = b,a = a}            
            color = 255 * 0x1000000 + r * 0x10000 + g * 0x100 + b
        end
        japi.FrameSetTextColor(self.id,color)
    end,

    set_alpha = function (self,alpha)
        local r,g,b = 255,255,255
        if self.color then 
           r = self.color.r 
           g = self.color.g 
           b = self.color.b 
        end 
        if alpha < 0 then 
            alpha = 0 
        end 
        self:set_color(r,g,b,alpha)
    end,
    set_control_size = function (self,width,height)
        ui_base_class.set_control_size(self,width,height)
        self._panel:set_control_size(width,height)
    end,

})
--批量重载方法
for name,func in pairs(ui_base_class) do
    if rawget(text_class,name) == nil then 
        text_class[name] = function (self,...)
            func(self,...)
            func(self._panel,...)
        end
    end
end
local mt = getmetatable(text_class)

mt.__tostring = function (self)
    local str = string.format('文本 %d',self.id)
    return str
end

