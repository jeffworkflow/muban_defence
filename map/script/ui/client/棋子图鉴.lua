local slk = require 'jass.slk'

class.chess_map_unit = extends(class.panel,class.actor){
    new = function (parent,x,y)
        local panel = class.panel.new(parent,'',x,y,150,32)

        panel.__index = class.chess_map_unit

        panel.icon = panel:add_texture('',0,0,32,32)
        panel.icon_button = panel:add_button('',0,0,150,32)

        panel.text = panel:add_text('骑士一段',37,0,150,32,16,'auto_newline')

        --种族
        panel.race_button = panel:add_button('',200,0,64,32)
        panel.race = panel.race_button:add_text('种族',0,0,76,32,16,'center')
        
        --职业
        panel.job_button = panel:add_button('',276,0,64,32)
        panel.job = panel.job_button:add_text('职业',0,0,76,32,16,'center')

        panel.abil = panel:add_button('x.blp',372,0,32,32)

        panel.gold_icon = panel:add_texture('image\\操作栏\\icon_gold.blp',428,0,32,32)

        panel.gold = panel:add_text('x 1',465,0,76,32,16,'left')

        panel:hide()
        return panel 
    end,

    set_name = function (self,name)
        local unit = ac.table.unit[name]
        if unit == nil then
            print('缺少单位数据',name)
            return 
        end 
        local data = ac.table.model[unit.base_id or ''] 
        local info = slk.unit[unit.id or '']
        if data == nil or info == nil then
             print('缺少数据',name)
            return 
        end 
        self.unit = unit 
        self.data = data 
        self.info = info 
        self.name = name 
        self.base_id = unit.base_id

        self.icon:set_normal_image(info['Art'] or '')
        self.text:set_text(self:get_title())

        self.race_button.skill_list = unit.race
        self.race:set_text(self:get_race() or '')
        
        self.job_button.skill_list = unit.job
        self.job:set_text(self:get_job() or '')

        local path = ''
        self.abil.skill = nil
        if unit.skill and unit.skill[1] then 
            local skill = unit.skill[1]
            local skill_data = ac.table.skill[skill]
            if skill_data then 
                path = skill_data.art or ''
            end 
            self.abil.skill = player_buff_name_to_skill(skill)
        end 
        
        self.abil:set_normal_image(path)
        self.gold:set_text(self:get_gold_tip())

        self:show()
    end,

    on_button_mouse_enter = function (self,button)
        if self.unit == nil then 
            return 
        end 

        if button == self.icon_button then 
            button:chess_tooltip(self)
        elseif button == self.abil and button.skill then 
            button:skill_tooltip(button.skill)
        end 

        local skill_list = button.skill_list
        if skill_list then 
            for index,name in ipairs(skill_list) do 
                local skill = player_buff_name_to_skill(name)
                if skill then 
                    local panel = button:skill_tooltip(skill)
                    panel:set_position(panel.x + (index - 1) * panel.w,panel.y)
                end 
            end 
        end 

        return false 
    end,
}


class.chess_map_panel = extends(class.panel){
    create = function ()
        local panel = class.panel.create('image\\提示框\\BJ.tga',100,50,1700,980)
        panel.__index = class.chess_map_panel 

        panel:add_button('',0,0,panel.w,panel.h)
        local title_text = panel:add_text('棋子图鉴',0,0,panel.w,100,25,'center')
        title_text:set_color(243,246,4,1)

        local line = panel:add_texture('image\\提示框\\line.tga',45,90,panel.w - 90,2)
        line:set_alpha(0xff*0.6)

        panel.close_button = panel:add_button('image\\操作栏\\cross.blp',panel.w - 32-5,5,32,32,true)


        local titles = {
            '棋子','种族','职业','技能','价格'
        }

        local x,y = 50,100
        for i = 1, 3 do 
            for index,name in ipairs(titles) do 
                local w = 76
                if index == 1 then 
                    w = 200
                end 
                local text = panel:add_text(name,x,y,w,32,17,'center')
                text:set_color(0xFFA0A0A0)
                x = x + w
            end 
            x = x + 48
        end 

        local list = {}
        local x,y = 50,150
        for i = 1,60 do 
            local unit = panel:add(class.chess_map_unit,x,y)
            table.insert(list,unit)
            y = y + 40
            if i % 20 == 0 then 
                x = x + 554
                y = 150
            end 
        end 
        panel.list = list
        panel:hide()

        return panel
    end,

    

    set_chess_list = function (self,list)
        for index,unit in ipairs(self.list) do 
            local name = list[index]
            if name then 
                unit:set_name(name)
            else 
                unit:hide()
            end 
        end 
    end,


    on_button_clicked = function (self,button)
        if button == self.close_button then 
            self:hide()
        end 
    end,

    on_button_mouse_enter = function (self,button)
        if button == self.close_button then 
            button:tooltip("关闭","暂时关闭棋子图鉴,按F3可以再次打开",-1,nil,64)
        end 
    end,
    
}

local panel

ac.wait(1000,function ()
    panel = class.chess_map_panel.get_instance()

    local list = {}
    for cost,v in ipairs(g_chess_level_list) do
        for _,chess in ipairs(v) do
            table.insert(list,chess)
        end 
    end 
    panel:set_chess_list(list)
end)




local game_event = {}
game_event.on_key_down = function (code)

    if code == KEY.F3 then 
        if panel == nil then return end 
        if panel.is_show then 
            panel:hide()
        else 
            panel:show()
        end 
    elseif code == KEY.ESC then 
        panel:hide()
    end 
end 

game.register_event(game_event)