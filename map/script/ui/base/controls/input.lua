require 'ui.base.controls.class'
require 'ui.base.controls.panel'
local edit_fpf = [[
    Frame "EDITBOX" "edit%d" {
        EditTextFrame "edit_text%d",
        Frame "TEXT" "edit_text%d" {
            LayerStyle "IGNORETRACKEVENTS",
            FrameFont "MasterFont", %f, "", 
        }
    }
]]

local input_map = {}

local function load_edit(fpf,size)
    if input_map[size] ~= nil then 
        return 
    end
    size = math.modf(size)
    input_map[size] = 1
    local data = string.format(fpf,size,size,size,size/1000)
    load_fdf(data)
end


class.input = extends(class.panel){

    --文本框 类型 和 基类
    _type   = 'edit',
    _base   = 'EDITBOX',

    input_map = {},

    new = function (parent,image_path,x,y,width,height,font_size)
        font_size = font_size or 16
        local ui = class.ui_base.create('input',x,y,width,height)
        
        ui.__index = class.input

        if ui.input_map[ui._name] ~= nil then 
            class.ui_base.destroy(ui)
            log.error('创建文本框失败 字符串id已存在')
            return 
        end 

        local panel = class.panel.new(parent,'',0,0,width,height)

        if panel == nil then 
            log.error('文本框背景创建失败')
            return
        end
        panel._control = ui
        ui._panel = panel
        load_edit(edit_fpf,font_size)
        ui._type = string.format('%s%d',ui._type,font_size)
        ui.id = japi.CreateFrameByTagName( ui._base, ui._name, panel.id, ui._type,0)
        if ui.id == nil or ui.id == 0 then 
            panel:destroy()
            class.ui_base.destroy(ui)
            log.error('创建文本框失败')
            return 
        end
        japi.RegisterFrameEvent(ui.id)

        ui.input_map[ui._name] = ui
        ui.input_map[ui.id] = ui
        ui.parent = parent


        ui:set_position(x,y)
        ui:set_control_size(width,height)
        --ui:set_text(edit)

        return ui
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        self._panel:destroy()

        self.input_map[self.id] = nil 
        self.input_map[self._name] = nil

        class.ui_base.destroy(self._index)
    end,

    set_text = function (self,text)
        self.text = text
        japi.FrameSetText(self.id,text)
    end,

    get_text = function (self)
        return japi.FrameGetText(self.id)
    end,

    set_focus = function (self,is_enable)
        if is_enable then 
            japi.SetEditFocus(self.id)
            japi.SendMessage(0x207,0,0)
            japi.SendMessage(0x208,0,0)
            japi.FrameSetFocus(self.id,is_enable)
            for i=1,self:get_text():len() do
                japi.SendMessage(0x100,KEY.RIGHT,0)
                japi.SendMessage(0x101,KEY.RIGHT,1)
            end
        else
            japi.FrameSetFocus(self.id,is_enable)
        end
    end,


    set_control_size = function (self,width,height)
        class.ui_base.set_control_size(self,width,height)
        self._panel:set_control_size(width,height)
    end,

    --[[
    on_input_text_changed = function (self,new_str,old_str)

    end,

    ]]

}

local mt = getmetatable(class.input)

mt.__tostring = function (self)
    local str = string.format('文本框 %d',self.id or 0)
    return str
end

