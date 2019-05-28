require 'ui.base.controls.class'
require 'ui.base.controls.panel'

class.model = extends(class.panel){

    --模型 类型 和 基类
    _type   = 'model',
    _base   = 'SPRITE',

    model_map = {},

    new = function (parent,model_path,x,y,width,height)
        local ui = class.ui_base.create('model',x,y,width,height)

        ui.align = 'right'

        ui.__index = class.model

        if ui.model_map[ui._name] ~= nil then 
            class.ui_base.destroy(ui)
            print('创建模型失败 字符串id已存在')
            return  
        end 
        
        local panel 
        if parent then 
            panel = parent.id
        else 
            panel = game_ui
        end 
       
        ui._paernt_id = panel
        ui.id = japi.CreateFrameByTagName( ui._base, ui._name, panel, ui._type,0)
        if ui.id == nil or ui.id == 0 then 
            class.ui_base.destroy(ui)
            print('创建模型失败')
            return 
        end
        
        ui.model_map[ui._name] = ui
        ui.model_map[ui.id] = ui
        ui.parent = parent
        ui.texture_map = {}
 
        ui:set_model(model_path)
        ui:set_position(x,y)
        ui:set_control_size(width,height)
        ui:set_animation(0,true)
        ui:set_progress(1)
        return ui

    end,


    destroy = function (self)
        if self.id == nil or self.id == 0 then 
            return 
        end
        self.model_map[self.id] = nil 
        self.model_map[self._name] = nil

        class.ui_base.destroy(self)
    end,

    ---------------------
    --设置动画进度 百分比
    set_progress = function (self,rote)
        self.progress_value = rote
        japi.FrameSetAnimateOffset(self.id,rote)
    end,

    --设置动画
    set_animation = function (self,index,bool)
        japi.FrameSetAnimate(self.id,index,bool == true)
    end,


    --同单位一样的 按照索引播放指定动画
    set_animation_by_index = function (self,index)
        japi.FrameSetAnimationByIndex(self.id,index)
    end,

    --设置模型路径
    set_model = function (self,path)
        self.path = path 
        self.texture_map = {}
        japi.FrameSetModel(self.id,path,0,0)
    end,

    set_color = function (self,color)
        self.color = color 
        print('设置模型',self.id,color)
        japi.FrameSetModelColor(self.id,color)
    end,

    --设置模型缩放倍率
    set_size = function (self,size)
        local real_size = (self.relative_size or 1) * size
        japi.FrameSetModelSize(self.id,real_size)
    end,

    --获取模型缩放倍率
    get_size = function (self)
        return japi.FrameGetModelSize(self.id)
    end,

    --设置模型按xyz轴缩放
    set_scale = function (self,x,y,z)
        local size = (self.relative_size or 1)
        x = size * x
        y = size * y 
        z = size * z
        japi.FrameSetModelScale(self.id,x,y,z)
    end,

    --设置模型旋转x轴
    set_rotate_x = function (self,value)
        japi.FrameSetModelRotateX(self.id,value)
    end,

    --设置模型旋转y轴
    set_rotate_y = function (self,value)
        japi.FrameSetModelRotateY(self.id,value)
    end,

    --设置模型旋转z轴
    set_rotate_z = function (self,value)
        japi.FrameSetModelRotateZ(self.id,value)
    end,

    --获取动画播放倍率
    get_speed = function (self)
        return japi.FrameGetModelSpeed(self.id)
    end,

    --设置动画播放倍率
    set_speed = function (self,value)
        japi.FrameSetModelSpeed(self.id,value)
    end,

    --设置模型与控件的偏移坐标
    set_model_offset = function (self,x,y)
        x = x / 1920 * 0.8 
        y = (-y / 1080) * 0.6
        japi.FrameSetModelXY(self.id,x,y)
    end,

    --获取偏移坐标
    get_model_offset = function (self)
        x = japi.FrameGetModelX(self.id)
        y = japi.FrameGetModelY(self.id)
        
        x = x / 0.8 * 1920
        y = y / 0.6 * 1080 * -1
        return x,y 
    end,

    replace_id_texture = function (self,image_path,id)

        if self.texture_map[id] == image_path then 
            return 
        end 
   
        self.texture_map[id] = image_path

        if image_path == '' then 
            image_path = 'Transparent.tga'
        end
        japi.FrameSetModelTexture(self.id,image_path,id)
    end,

    _color_map = {
        ['红'] = 0, ['蓝'] = 1, ['青'] = 2, ['紫'] = 3, ['黄'] = 4, ['橙'] = 5, ['绿'] = 6,
        ['粉'] = 7, ['灰'] = 8, ['淡蓝'] = 9, ['暗绿'] = 10, ['棕'] = 11,
    },

    --设置模型的队伍颜色 0 - 15  0为红色
    set_team_color = function (self,color_id)
        local path1,path2 = '',''
        if color_id or color_id ~= '' then 
            if type(color_id) == 'string' then 
                color_id = self._color_map[color_id] or 0
            end 
            path1 = string.format('ReplaceableTextures\\TeamColor\\TeamColor%02d.blp',color_id)
            path2 = string.format('ReplaceableTextures\\TeamGlow\\TeamGlow%02d.blp',color_id)
        end 
        --队伍颜色
        self:replace_id_texture(path1,1)
        --光晕贴图
        self:replace_id_texture(path2,2)

    end,

    

}

local mt = getmetatable(class.model)

mt.__tostring = function (self)
    local str = string.format('模型 %d',self.id or 0)
    return str
end

