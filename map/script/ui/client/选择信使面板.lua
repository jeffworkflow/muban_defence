local ui = require 'ui.client.util'
local slk = require 'jass.slk'

class.unit_list_box_tooltip = extends(class.panel){
    create = function ()
        local x,y,width,height = 0,0,300,300
        local panel = class.panel.create('',x,y,width,height)
        panel.__index = class.unit_list_box_tooltip

        local texture = panel:add_texture('image\\提示框\\bj2.tga',0,0,panel.w,panel.h)
        texture:set_alpha(0.8)
        local texture = panel:add_panel('image\\提示框\\BT.tga',5,5,panel.w-10,panel.h-10)
        texture:set_alpha(0.6)

        panel.text = texture:add_text('',0,0,texture.w,32,14,'center')
        panel.text:set_color(0xffe0e0e0)

        panel.actor = panel:add_actor('',width / 2, height - 100)
        panel.actor:set_size(0.8)

        panel:hide()
        return panel
    end,

    set_name = function (self,name)
        self.text:set_text(name)
        self.actor:set_actor(name)
    end,

}

class.unit_list_box_unit = extends(class.button){
    new = function (parent,name,x,y,width,height)
        local image = 'image\\排行榜\\background.tga'

        local button = class.button.new(parent,'',x,y,width,height)
        local background = button:add_texture(image,0,0,width,height)
        background:set_alpha(0.6)

        button.icon = button:add_texture('x.blp',8,8,64,64)

        button.name_text = button:add_text('阿达萨达',64,0,width - 64,height,12,'center')

        button.__index = class.unit_list_box_unit
        button:set_name(name)
        return button
    end,

    destroy = function (self)
        local panel = self.panel
        table.remove(panel.list,self.slot_id)
        panel:sort()
        class.button.destroy(self)
    end,

    set_name = function (self,name)
        local unit = ac.table.unit[name]
        if unit == nil or unit.id == nil then 
            print('没有单位数据1',name)
            return 
        end 
        
        local info = slk.unit[unit.id]
        if info == nil then 
            print('没有单位数据2',name)
            return 
        end 

        local data = ac.table.model[name]
        if data == nil then 
            print('没有模型数据',name)
            return 
        end

        self.data = data
        self.unit = unit 
        self.info = info 

        self.name = name 
        self.name_text:set_text(name)
        self.icon:set_normal_image(info['Art'] or '')

    end,


    tooltip = function (self)
        local name = self.name 
        if name == nil then 
            return 
        end 
        --回收掉已经在显示的tip
        class.ui_base.remove_tooltip()
        local panel = self.panel.tooltip_panel

        local x,y = self:get_real_position() 

        local width,height = panel.w,panel.h
        y = y - height / 2 + self.h / 2 

        x = x - width - 5


        x = math.min(math.max(10,x),1900)
        y = math.min(math.max(10,y),1080)

      
        panel:set_position(x,y)
        panel:set_name(name)
        panel:show()
        return panel
    end,


}

class.unit_list_box = extends(class.panel){
    create = function ()
        local width,height = 300,570
        local x,y = 1920 / 2 - width / 2, 1080 / 2 - height / 2
        local panel = class.panel.create('',x,y,width,height)
        panel.__index = class.unit_list_box

        panel:add_text('双击选择信使',0,0,width,50,15,'center')

        local button = panel:add_button('image\\操作栏\\select_black.tga',0,0,width,height)
        button:set_alpha(0.6)

        local scroll_bar = panel:add_panel('',0,50,width,height - 70,true)
        
        --设置y轴的滚动间隔
        scroll_bar.scroll_interval_y = 100

        panel.scroll_bar = scroll_bar

        panel.list = {}

        panel.tooltip_panel = class.unit_list_box_tooltip.create()

        return panel
    end,

    destroy = function (self)
        self:clear()
        self.tooltip_panel:destroy()
        class.panel.destroy(self)
    end,

    clear = function (self)
        for i=1,#self.list do 
            local unit = self.list[1]
            unit:destroy()
        end 
    end,

    set_unit_list = function (self,list)
        self:clear()
        for index,name in ipairs(list) do 
            self:add_unit(name)
        end 
    end,

    add_unit = function (self,name)
        local unit = self.scroll_bar:add_unit_list_box_unit(name,0,0,self.w - 30,90)
        unit.panel = self
        table.insert(self.list,unit)
        self:sort()
        return unit 
    end,

    sort = function (self)
        local x,y = 10,10
        for index,unit in ipairs(self.list) do 
            unit:set_position(x,y)
            y = y + 100
            unit.slot_id = index
        end 
    end,

    on_button_mouse_enter = function (self,button)
        if button.name then 
            button:tooltip()
        end 
    end,

    on_button_mouse_leave = function (self)
        self.tooltip_panel:hide()
    end,

    on_button_clicked = function (self,button)
        local name = button.name 
        if name == nil then 
            return 
        end 


        if self.last then 
            self.last:set_normal_image('image\\排行榜\\background.tga')
            if self.last == button then 
                local info = {
                    type = '信使',
                    func_name = 'select',
                    params = {
                        [1] = button.slot_id
                    }
                }
                ui.send_message(info)
                return 
            end
        end
        button:set_normal_image('image\\提示框\\cdshanshuo.tga')
        self.last = button

    end,
}


