attr_config = {
    { {{'基础攻击','白字攻击max'},'额外攻击'},       'image\\控制台\\attr1.tga'},
    { {'基础护甲','额外护甲'},       'image\\控制台\\attr2.tga'},
    { '魔抗',       'image\\控制台\\attr3.tga'},
    { '攻击速度',   'image\\控制台\\attr4.tga'},
    { '移动速度',   'image\\控制台\\attr5.tga'},
}



class.attr_panel = extends(class.panel){
    new = function (parent,x,y)
        local panel = class.panel.new(parent,'',x,y,150,150)
        panel.__index = class.attr_panel

        local attr_map = {}
        local list = {}
        for index,info in ipairs(attr_config) do 
            local button = panel:add_button('',0,(index - 1) * 28,panel.w,24)
            button.icon = button:add_texture(info[2],15,0,34,28)
            button.text = button:add_text('0',55,4,300,20,10,'left')
            button.info = info 
            button.num = index 

            if type(info[1]) == 'table' then 
                if type(info[1][1]) == 'table' then
                    for index,name in pairs(info[1]) do 
                        attr_map[name] = button
                        button.attr_type = 2
                    end
                else
                    for index,name in pairs(info[1]) do 
                        attr_map[name] = button
                        button.attr_type = 1
                    end
                end
            else 
                attr_map[info[1]] = button
                button.attr_type = 0
            end
            table.insert(list,button)
        end 

        panel.attr_map = attr_map 
        panel.button_list = list

        panel:hide()
        
        return panel
    end,

    --设置子控件排版的间距
    set_text_spacing = function (self,x,y)
        for index,button in ipairs(self.button_list) do   
            local text = button.text 
            text:set_position(text.x + x,text.y + y)
        end
    end,

  
    set_text_size = function (self,size)
        for index,button in ipairs(self.button_list) do   
            local text = button.text 
            text:set_size(size)
        end
    end,

    set_hero = function (self,hero)
        self.hero = hero
        if hero then 
            self:show()
        else
            self:hide()
            return
        end
        for index,button in ipairs(self.button_list) do     
            local info = button.info 
            if info then 
                if button.attr_type == 0 then 
                    local name = info[1] 
                    local value = hero:get(name) 
                    local str = string.format('%.0f',value or 0)
                    button.text:set_text(str)
                elseif button.attr_type == 1 then
                    local value1 = hero:get(info[1][1]) or 0
                    local value2 = hero:get(info[1][2]) or 0
                    local str 
                    if math.floor(value2) == 0 then 
                        str = string.format('%.0f',value1)
                    else
                        local flag = (value2 > 0) and '+' or '-' 
                        str = string.format('%.0f |cffffff00%s %.0f|r',value1,flag,math.abs(value2))
                    end
                    button.text:set_text(str)
                elseif button.attr_type == 2 then
                    local value1 = hero:get(info[1][1][1]) or 0
                    local value2 = hero:get(info[1][1][2]) or 0
                    local value3 = hero:get(info[1][2]) or 0
                    local str 
                    if math.floor(value3) == 0 then 
                        str = string.format('%.0f ~ %.0f',value1,value2)
                    else
                        if value3 > 0 then
                            str = string.format('%.0f ~ %.0f |cff00ff00+ %.0f|r',value1,value2,value3)
                        else
                            str = string.format('%.0f ~ %.0f |cffff0000- %.0f|r',value1,value2,math.abs(value3))
                        end
                    end
                    button.text:set_text(str)
                end 
            end
        end

    end,

    on_button_mouse_enter = function (self,button)
        local info = button.info 
        if info == nil then 
             return 
        end 
        local hero = self.hero
        if hero == nil then 
            return 
        end
        local s = {}

        --for index,button in ipairs(self.button_list) do     
        --    local info = button.info 
        --    if info then 
        --        if button.attr_type == 0 then 
        --            s[#s + 1] = info[1] .. ' : ' .. (hero:get(info[1]) or 0) .. '\n'
        --        else
        --            for i,n in ipairs(info[1]) do 
        --                s[#s + 1] = n .. ' : ' .. (hero:get(n) or 0) .. '\n'
        --            end
        --        end 
        --    end
        --end
        if button.attr_type == 0 then 
            s[#s + 1] = info[1] .. ' : ' .. (hero:get(info[1]) or 0) .. '\n'
        elseif button.attr_type == 1 then 
            for i,n in ipairs(info[1]) do 
                s[#s + 1] = n .. ' : ' .. (hero:get(n) or 0) .. '\n'
            end
        elseif button.attr_type == 2 then 
            s[#s + 1] = '基础攻击 : ' .. (hero:get('基础攻击') or 0) .. '\n'
            s[#s + 1] = '攻击浮动 : ' .. (hero:get('白字攻击max') or 0) .. '\n'
            s[#s + 1] = '额外攻击 : ' .. (hero:get('额外攻击') or 0) .. '\n'
        end
        self:tooltip({hero:get_name(),'center'},table.concat(s),2,200,64)
    end,
}

