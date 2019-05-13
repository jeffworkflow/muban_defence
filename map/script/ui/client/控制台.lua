local ui = require 'ui.client.util'
local slk = require 'jass.slk'

local console = {}

local types = {
    ['小地图按钮']  = 'FrameGetMinimapButton',
    ['小地图']      = 'FrameGetMinimap',
    ['头像模型']    = 'FrameGetPortrait',
    ['技能按钮']    = 'FrameGetCommandBarButton',
    ['头像图标']    = 'FrameGetHeroBarButton',
    ['血条']        = 'FrameGetHeroHPBar',
    ['蓝条']        = 'FrameGetHeroManaBar',
    ['提示框']      = 'FrameGetTooltip',
}
local controls = {}

console.get = function (name,...)
    local args = {...}
    local row = args[1]
    local column = args[2]
    local func_name = types[name]
    if func_name == nil then 
        return 
    end 
    local key = string.format('%s%s%s',name,tostring(row or ''),tostring(column or ''))
    local instance = controls[key]
    if instance == nil then 
        local control_id = japi[func_name](row,column)
        if control_id == nil or control_id == 0 then 
            return 
        end 
        instance = extends(button_class,{
            id = control_id,
            w = 0,
            h = 0,
        })
        if name == '血条' or name == '蓝条' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  (x + self.w / 2) / 1920 * 0.8
                y = (1080 - y) / 1080 * 0.6
                japi.FrameSetPoint(self.id,1,game_ui,6,x,y)
            end
        elseif name == '头像模型' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  x / 1920 * 0.8
                y = (1080 - y - self.h) / 1080 * 0.6
                japi.FrameSetPoint(self.id,6,game_ui,6,x,y)
            end
        elseif name == '小地图' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                local ax =  x / 1920 * 0.8
                local ay = (1080 - y - self.h) / 1080 * 0.6
                local bx = (x + self.w) / 1920 * 0.8
                local by = (1080 - y) / 1080 * 0.6
                japi.FrameSetPoint(self.id,6,game_ui,6,ax,ay)
                japi.FrameSetPoint(self.id,2,game_ui,6,bx,by)
            end
        elseif name == '技能按钮' then 
            instance.w = 91
            instance.h = 69
            instance.row = row 
            instance.column = column
        elseif name == '提示框' then 
            instance.set_position = function (self,x,y)
                self.x = x
                self.y = y
                x =  (x - self.w * 1.5) / 1920 * 0.8
                y =  -y / 1080 * 0.6
                japi.FrameSetPoint(self.id,8,game_ui,1,x,y)
            end
        end 
        controls[key] = instance
    end 
    return instance
end 

local Console_class = {}
Console_class = extends( panel_class , {
    create = function()
        
        --创建一个底层面板
        local panel = panel_class.create('',0,0,1920,1080)

        --小地图
        local map = console.get('小地图')
        map:set_control_size(252,240)
        map:set_position(10,833)
        --小地图边框
        local map_bk = panel:add_texture('image\\控制台\\minimapborder.tga',0,763,296,318)
        --道具栏底层面板
        local djl = panel:add_texture('image\\控制台\\fumianban.tga',1150,785,227,295)

        --主控制台
        local kzt = panel:add_texture('image\\控制台\\zhumianban.tga',707,860,448,221)
        
        --血条
        local hp_bj = kzt:add_texture('image\\控制台\\xuetiaoBG.tga',14,127,408,32)
        local hp = hp_bj:add_texture('image\\控制台\\xuetiao.tga',2,2,404,28)

        --蓝条
        local mt_bj = kzt:add_texture('image\\控制台\\lantiaoBG.tga',14,169,408,32)
        local mp = mt_bj:add_texture('image\\控制台\\lantiao.tga',2,2,404,28)

        --创建一个头像框
        local portrait = panel:add_texture('image\\控制台\\portrait_wide.tga',479,809,276,271)
        local head = console.get('头像模型')
        head:set_control_size(131,155)
        head:set_position(552,894)
        --等级文字
        local lv_text = portrait:add_text('255',54,241,33,30,9,4)


        return panel
    end,

    
})

c_ui.Console = Console_class.create()