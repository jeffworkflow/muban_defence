require 'ui.base.class'
require 'ui.base.panel'
local ui = require 'ui.client.util'
local model = [[
    Frame "SPRITE" "model%i" {
        LayerStyle "IGNORETRACKEVENTS",
        BackgroundArt "%s",
        //SetAllPoints,
    }
]]
local model_map = {}

local function load_model(model_path)
    local hash = math.abs(ui.to_hash(model_path))
    if model_map[hash] ~= nil then 
        return hash
    end
    model_map[hash] = 1
    local data = string.format(model,hash,model_path)
    load_fdf(data)
    return hash
end

sprite_class = extends( panel_class,{

    --模型 类型 和 基类
    _type   = 'model',
    _base   = 'SPRITE',

    sprite_map = {},

    new = function (parent,model_path,x,y,width,height)
        local ui = ui_base_class.create('sprite',x,y,width,height)

        ui.align = 'right'

        ui.__index = sprite_class

        if ui.sprite_map[ui._name] ~= nil then 
            ui_base_class.destroy(ui._index)
            print('创建模型失败 字符串id已存在')
            return 
        end 
        
        local panel 
        if parent then 
            panel = parent:add_panel('',0,0,width,height)
        else 
            panel = panel_class.create('',0,0,width,height)
        end 
        if panel == nil then 
            print('模型背景创建失败')
            return
        end
        ui._panel = panel
        local hash = load_model(model_path)
        ui._type = string.format('%s%d',ui._type,hash)
     
        ui.id = japi.CreateFrameByTagName( ui._base, ui._name, panel.id, ui._type,0)
 
        if ui.id == nil or ui.id == 0 then 
            panel:destroy()
            ui_base_class.destroy(ui._index)
            print('创建模型失败')
            return 
        end
        
        ui.sprite_map[ui._name] = ui
        ui.sprite_map[ui.id] = ui
        ui.parent = parent
 
        ui:set_position(x,y)
        ui:set_control_size(width,height)
        ui:set_animation(0)
        ui:set_progress(1)
        return ui

    end,

    create = function (...)
        return sprite_class.new(nil,...)
    end,

    add_child = function (...)
        return sprite_class.new(...)
    end,

    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        self._panel:destroy()

        self.sprite_map[self.id] = nil 
        self.sprite_map[self._name] = nil

        ui_base_class.destroy(self)
    end,

    set_position = function (self,x,y)
        self._panel:set_position(x,y)
        --self.x = x 
        --self.y = y
        --local x = -self. w / 2 + self._panel.x + self._panel.w / 2 + x
        --local y =  -1080 + self._panel.y + self._panel.h + y
        panel_class.set_position(self,x,y)
    end,

    --设置动画
    set_animation = function (self,index,bool)
        japi.FrameSetAnimate(self.id,index,bool == true)
    end,

    --设置动画进度 百分比
    set_progress = function (self,rote)
        self.progress_value = rote
        japi.FrameSetAnimateOffset(self.id,rote)
    end,

    set_control_size = function (self,width,height)
        panel_class.set_control_size(self,width,height)
        self._panel:set_control_size(width,height)
    end,

})

local mt = getmetatable(sprite_class)

mt.__tostring = function (self)
    local str = string.format('模型 %d',self.id)
    return str
end

