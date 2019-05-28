


--[[
    用来显示在右上角的 场上所有棋子的技能列表
]]



class.skill_list_panel = extends(class.panel){
    create = function ()
        local panel = class.panel.create('',50,10,400,400)
        panel.__index = class.skill_list_panel

        local list = {}
        local x,y = 100,0
        for i=1,12 do 
            local image = 'image\\排行榜\\background.tga'
            local button = panel:add_button(image,x,y,100,42)
            button:set_alpha(0.5)
            button.icon = button:add_texture('',4,4,32,32)
            button.count_text = button:add_text('1 / 10',36,0,64,42,12,'center')
            button.count_text:set_color(0xffa0a0a0)
            button:hide()

            table.insert(list,button)
            if i % 4 == 0 then 
                x = x + 110
                y = 0
            else 
                y = y + 48
            end
        end
        panel.list = list
        return panel
    end,

    set_skill_list = function (self,list)
        for index,button in ipairs(self.list) do 
            local data = list[index]
            button.skill = nil
            button.level = nil
            if data then 
                local name,value,max_value,level = table.unpack(data)
                local skill = player_buff_name_to_skill(name)
                button.skill = skill
                button.level = level
                if skill then 
                    local str = string.format("%.0f / %.0f",value,max_value)
                    button:show()
                    button.icon:set_normal_image(skill:get_art())
                    button.count_text:set_text(str)
                else
                    button:hide()
                end
            else
                button:hide()
            end
        end
    end,

    on_button_mouse_enter = function (self,button)
        if button.skill then 
            button:skill_tooltip(button.skill,button.level,nil)
        end
    end,
}

local panel = class.skill_list_panel.create()


--参数是 哈希表 要转换成列表后再显示
ac.game:event '玩家BUFF刷新' (function (_,player,tbl)
    if player:is_self() then 
        local list = {}
        for name,info in pairs(tbl) do 
            table.insert(list,{
                name,info.num,info.num_next,level = info.level
            })
        end

        table.sort(list,function (a,b)
            return a[1] < b[1]
        end)
        panel:set_skill_list(list)
    end
end)