require 'ui.base.class'
require 'ui.base.panel'
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


input_class = extends( panel_class,{

    --文本框 类型 和 基类
    _type   = 'edit',
    _base   = 'EDITBOX',

    input_map = {},

    new = function (parent,image_path,x,y,width,height,font_size)
        font_size = font_size or 16
        local ui = ui_base_class.create('input',x,y,width,height)
        
        ui.__index = input_class

        if ui.input_map[ui._name] ~= nil then 
            ui_base_class.destroy(ui._index)
            log.error('创建文本框失败 字符串id已存在')
            return 
        end 

        local panel 
        if parent then 
            panel = parent:add_panel(image_path,0,0,width,height)
        else 
            panel = panel_class.create(image_path,0,0,width,height)
        end 

        if panel == nil then 
            log.error('文本框背景创建失败')
            return
        end
        ui._panel = panel
        load_edit(edit_fpf,font_size)
        ui._type = string.format('%s%d',ui._type,font_size)
        ui.id = japi.CreateFrameByTagName( ui._base, ui._name, panel.id, ui._type,0)
        if ui.id == nil or ui.id == 0 then 
            panel:destroy()
            ui_base_class.destroy(ui._index)
            log.error('创建文本框失败')
            return 
        end
        

        ui.input_map[ui._name] = ui
        ui.input_map[ui.id] = ui
        ui.parent = parent


        ui:set_position(x,y)
        ui:set_control_size(width,height)
        --ui:set_text(edit)

        return ui
    end,

    create = function (...)
        return input_class.new(nil,...)
    end,

    add_child = function (...)
        return input_class.new(...)
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        self._panel:destroy()

        self.input_map[self.id] = nil 
        self.input_map[self._name] = nil

        ui_base_class.destroy(self._index)
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
                japi.SendMessage(0x101,KEY.RIGHT,1,0)
            end
        else
            japi.FrameSetFocus(self.id,is_enable)
        end
    end,


    set_control_size = function (self,width,height)
        ui_base_class.set_control_size(self,width,height)
        self._panel:set_control_size(width,height)
    end,

    --[[
    on_input_text_changed = function (self,new_str,old_str)

    end,

    ]]

})

local mt = getmetatable(input_class)

mt.__tostring = function (self)
    local str = string.format('文本框 %d',self.id)
    return str
end

