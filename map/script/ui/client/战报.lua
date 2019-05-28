local slk = require 'jass.slk'

local report


class.report_unit_list = extends(class.panel){
    new = function (parent,x,y)
        local panel = class.panel.new(parent,'',x,y,32,32)
        panel.__index = class.report_unit_list
        local list = {}
        local x,y = 0,0
        for i = 1, 10 do 
            local button = panel:add_button('x.blp',x,y,32,32)
            table.insert(list,button)
            x = x + 36 
            if i == 5 then 
                x = 0 
                y = y + 36
            end 
        end 
        panel.list = list 

        return panel
    end,

    set_icon = function (self,button,name,level)
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
        local chess = {
            name = name,
            base_id = unit.base_id,
            level = level,
            unit = unit,
            data = data,
            info = info,
        }
        button.chess = chess 
        button:set_normal_image(info['Art'] or '')
        button:show()
    end,

    set_value = function (self,list)
        for index,button in ipairs(self.list) do 
            local data = list[index] 
            button.chess = nil
            if data then 
                local name,level = data.name,data.level
                if name and level then 
                    self:set_icon(button,name,level)
                end
            else 
                button:hide()
            end 
        end 
    end,

    on_button_mouse_enter = function (self,button)
        local chess = button.chess 
        if chess then 
            button:chess_tooltip(chess)
        end
        return false
    end,
}


class.report_player_level = extends(class.panel){
    new = function (parent,x,y)
        local panel = class.panel.new(parent,'x.blp',x,y,32,32)
        panel.__index = class.report_player_level

        panel.text = panel:add_text('骑士一段',panel.w + 5,0,200,32,17,'left')

        return panel 
    end,

    set_value = function (self,level)
        local data = ac.table.item['棋子等级数据']
        local info = data[level] or data[1]
        self:set_normal_image(info.icon)
        self.text:set_text(info.name)
    end,
}

--战报
class.report = extends(class.panel){
    create = function()
        --创建底层面板
        local width,height = 1210,740
        local x,y = 1920/2 - width/2, 1080/2 - height/2
        local panel = class.panel.create('image\\提示框\\bj2.tga',x,y,width,height)
        
        panel.__index = class.report
        
        local title_text = panel:add_text('排行榜',0,0,panel.w,100,25,'center')
        title_text:set_color(243,246,4,1)


        local score_text = panel:add_text('本局累计获得积分：0',40,76,200,25,13,'left')
        score_text:set_color(120,120,120,1)
        panel.score_text = score_text

        local line = panel:add_texture('image\\提示框\\line.tga',45,100,width - 90,2)
        line:set_alpha(0xff*0.6)

        local data_panel = panel:add_panel('',0,110,panel.w,panel.h - 130)

        local names = {
            '排行','玩家','段位','棋子','回合','胜负','击杀','受击','游戏时长'
        }
        
        local test_str = {
            '1','WorldEdit','骑士一段','','30','20 - 10','300','100000','20:30'
        }

        local x,y = 20,0
        for index,name in ipairs(names) do 
            local w = 110
            if index == 3 then 
                w = 220
            elseif index == 4 then 
                w = 170
            end
            local text = data_panel:add_text(name,x,y,w,32,17,'center')
            text:set_color(120,120,120,1)
            x = x + text.w
        end

        local list = {}

        local x,y = 20,50
        for i = 1, 8 do 
            x = 20
            local bar = data_panel:add_panel('',x,y,data_panel.w - x,64)
            local item 
            bar.map = {}
            x = x - bar.x
            for index,name in ipairs(names) do 
                if index == 3 then 
                    item = bar:add(class.report_player_level,x + 30,0)
                    x = x + 220
                elseif index == 4 then 
                    item = bar:add(class.report_unit_list,x,- 16)
                    local data = {}
                    for i = 1, 10 do 
                        data[i] = { name = '卓尔游侠Lv3',level = 1}
                    end
                    item:set_value(data)
                    x = x + 175
                else 
                    item = bar:add_text(test_str[index],x,0,84,32,17,'center')
                    item.set_value = item.set_text
                    x = x + 110
                end
                bar.map[name] = item
            end
            y = y + 74
            list[i] = bar
        end
        panel.bar_list = list
        return panel
    end,

    set_slot_report = function (self,slot_id,data)
        local bar = self.bar_list[slot_id]
        if bar == nil then 
            return 
        end 

        for name,value in pairs(data) do 
            local control = bar.map[name]
            if control then 
                control:set_value(value)
            end 
        end 
    end,

    set_report = function (self,data_table)
        for index,bar in ipairs(self.bar_list) do 
            local data = data_table[index]
            if data then 
                bar:show()
                self:set_slot_report(index,data)
            else 
                bar:hide()
            end 
        end 
    end,
}

local function show_report(player,report_data_list)
    if player:is_self() then 
        if report then 
            report:destroy()
        end
        report = class.report.create()
        report:set_report(report_data_list)
    end
end 



ac.game:event '游戏结束' (function (_,is_winer)
    local report_data = get_report()
    local list = {}
    for index,info in ipairs(report_data) do 
        local data = {
            ['排行'] = index,
            ['玩家'] = info.player:get_name(),
            ['段位'] = 1,
            ['棋子'] = info.chess_list,
            ['回合'] = tostring(info.round),
            ['胜负'] = string.format("%d - %d",info.win,info.loss),
            ['击杀'] = info.kills,
            ['受击'] = info.hits,
            ['游戏时长'] = info.time,
        }
        list[index] = data
    end 

    ac.wait(1500,function ()
        show_report(ac.player.self,list)
    end)
end)