require 'ui.base.controls.class'
require 'ui.base.controls.panel'

local font = [[
    Frame "TEXT" "text%d" {
        LayerStyle "IGNORETRACKEVENTS",
        FrameFont "resource\fonts\fonts.TTF", %f, "", 
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


class.text = extends(class.panel){
--private

    _type   = 'text',--fdf 中的模板类型

    _base   = 'TEXT', --fdf 中的Frame类型

--public

    text = '', --文本内容

    align = 0, --对齐方式

    font_size = 16, --字体大小

    normal_image = '', --文本背景

    color = nil, -- 文本颜色

--static

    text_map = {}, --存放所有存活的文本控件对象

    --对齐方式的对照表
    align_map = {
        --自动换行
        auto_newline     = -1,
        auto_size        = -2,
        auto_width       = -3,
        auto_height      = -4,

        topleft         = 0,
        top             = 1,
        topright        = 2,
        left            = 3,
        center          = 4,
        right           = 5,
        bottomleft      = 6,
        bottom          = 7,
        bottomright     = 8,
    },


    --构建
    build = function (self)
        self.align = class.text.align_map[self.align or ''] or self.align or 0

        local panel = class.panel.new(self.parent,self.normal_image, 0, 0, self.w, self.h)

        if panel == nil then 
            print('文字背景创建失败')
            return
        end
        panel._control = self
        self._panel = panel 

        if self.font_size == nil then 
            self.font_size = 16
        end 
        
        if type(self.font_size) == 'boolean' then 
            self._type = 'old_text'
        else
            load_font(font,self.font_size)
            self._type = string.format('%s%d',self._type,self.font_size)
        end
 
        self._id = japi.CreateFrameByTagName( self._base, self._name, panel._id, self._type,math.max(0,self.align))
        if self._id == nil or self._id == 0 then 
            panel:destroy()
            class.ui_base.destroy(self)
            print('创建文字失败')
            return 
        end
        self.text_map[self._id] = self

        self:init()
        self:set_text(self.text)
        if self.color then 
            self:set_color(self.color)
        end 
        return self
    end,

    -- parent 当 create的时候是空值 add_text的时候是父控件
    -- text 字符串 文本值_addr
    -- x,y,w,h 坐标位置
    -- font_size 字体大小
    -- align 
    new = function (parent,text,x,y,width,height,font_size,align)
        local control = class.text:builder
        {
            parent = parent,
            text = text,
            x = x,
            y = y,
            w = width,
            h = height,
            font_size = font_size,
            align = align,
        }
        return control
    end,

    destroy = function (self)
        if self._id == nil or self._id == 0 then 
            return _id
        end
        self._panel:destroy()
 
        self.text_map[self._id] = nil 

        class.ui_base.destroy(self)
    end,

    show = function (self)
        self._panel:show()
        class.ui_base.show(self)
    end,

    hide = function (self)
        self._panel:hide()
        class.ui_base.hide(self)
    end,

    get_width = function (self)
        return japi.FrameGetTextWidth(self._id) / 0.8 * 1920
    end,

    get_height = function (self)
        return japi.FrameGetTextHeight(self._id) / 0.6 * 1080
    end,

    set_text = function (self,text)
        if self:get_text() == text then 
            return 
        end
        japi.FrameSetText(self._id,text)

        if self.align < -1 then 
            local _id = self._panel._id 

            local width = self:get_width() + self.x + 8
            local height = self:get_height() + self.y + 6
            if self.align == -3 then 
                height = self.h
            elseif self.align == -4 then 
                width = self.w 
            end 
            if width > 0 and height > 0 then
                self:set_width(width - self.font_size * 2) 
                self:set_control_size(width,height)
                if self.parent then 
                    self.parent:set_control_size(width,height)
                end 
            end 
        elseif self.normal_image ~= 'Transparent.tga' then
            --game.wait(100, function ()
            --    if self._id then 
            --        local width = self:get_width()
            --        local height = self:get_height()
            --        if width > 0 and height > 0 then 
            --            self:set_control_size(width,height)
            --        end 
            --    end 
            --end)
        end 
    end,

    get_text = function (self)
        return japi.FrameGetText(self._id)
    end,

    --设置间距 
    set_spacing = function (self,spacing)
        japi.FrameSetTextFontSpacing(self._id,spacing)
    end,

    set_size = function (self,size,path)
 
        local real_size = size * self.font_size * (self.relative_size or 1) * (self.default_size or 1)
        self.size = size 

        path = path or 'C:\\Windows\\Fonts\\simhei.ttf'

        if self._real_size == real_size and self.path == path then 
            return 
        end

        self._real_size = real_size 
        self.font_path = path 
        --path = path or 'resource\\Fonts\\FZHTJW.ttf'
  
        japi.FrameSetTextFont(self._id,path,real_size / 1000)
    end,

    set_color = function (self,...)
        local arg = {...}
        local color = 0
        if #arg == 1 then
            local param = arg[1]
            if type(param) == 'table' then 
                self.color = param
                color = 255 * 0x1000000 + param.r * 0x10000 + param.g * 0x100 + param.b
                self._panel:set_alpha(param.a)
            else
                color = param
                local a = (color << 32) >> 56
                local r = (color << 40) >> 56
                local g = (color << 48) >> 56
                local b = (color << 56) >> 56
                self.color = {r = r,g = g,b = b,a = a/0xff}
            end 
        else 
            local r,g,b,a = table.unpack(arg)
            self._panel:set_alpha(a)
            self.color = {r = r,g = g,b = b,a = a}            
            color = 255 * 0x1000000 + r * 0x10000 + g * 0x100 + b
        end
        japi.FrameSetTextColor(self._id,color)
    end,

    set_alpha = function (self,alpha)
        local r,g,b = 255,255,255
        if type(self.color) == 'table' then 
           r = self.color.r 
           g = self.color.g 
           b = self.color.b 
        elseif self.color then 
            color = self.color
            r = (color << 40) >> 56
            g = (color << 48) >> 56
            b = (color << 56) >> 56
        end 
        if alpha < 0 then 
            alpha = 0 
        end 
        self:set_color(r,g,b,alpha)
    end,
    set_control_size = function (self,width,height)
        self.w = width 
        self.h = height
        if self.align == -1 then 
            class.panel.set_control_size(self,width,height)
        end
        self._panel:set_control_size(width,height)
    end,

    set_position = function (self,x,y)
        class.ui_base.set_position(self,x,y)
        self._panel:set_position(x,y)
    end,

    set_normal_image = function (self,path,flag)
        self._panel:set_normal_image(path,flag)
    end,

    __tostring = function (self)
        local str = string.format('文本 %d',self._id or 0)
        return str
    end
}

