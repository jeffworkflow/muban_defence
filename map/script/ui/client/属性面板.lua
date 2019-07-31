attr_config = {
    --属性, 图标，x,y,w,h  65 47 ,攻击模块，宽度都是216
    { '生命',nil,0,92,225,16},
    { '魔法',nil,0,116,225,16},
    { '攻击','image\\控制台\\BTN UI 004.blp',266,0,65,49},
    { '护甲','image\\控制台\\BTN UI 024.blp',266,57,65,49},
    { '三围','image\\控制台\\BTN UI 028.blp',491,25,65,49},
}



class.attr_panel = extends(class.panel){
    new = function (parent,x,y)
        local panel = class.panel.new(parent,'',x,y,711,138)
        panel.__index = class.attr_panel

        panel.attr_list = {}
        panel.main_box = panel:add_button('image\\提示框\\bj2.tga',249,0,458,145)
        panel:add_text('状态:',343,116,300,12,8,'left') --状态


        for i,data in ipairs(attr_config) do 
            local name,icon,x,y,w,h = table.unpack(data)
            --处理魔法上限相关
            if finds(name,'生命','魔法') then 
                -- panel:add_texture('image\\提示框\\bj2.tga',x,y,w,24) --黑色背景
                -- local temp = {}
                -- temp.name = name
                -- temp.value = panel:add_text('1/1',x,y,w,24,12,'center')
                -- table.insert(panel.attr_list,temp)  
            elseif finds(name , '攻击','护甲') then 
                local temp = {}
                temp.icon = panel:add_texture(icon,x,y,w,h)
                temp.title = panel:add_text('|cffffff00'..name..'|r',x+10+w,y+8,216-w,12,8,'left')
                temp.name = name
                temp.value = panel:add_text('0',x+10+w+5,y+32,216-w-5,12,8,'left')
                table.insert(panel.attr_list,temp)
            elseif name == '三围' then 
                local temp = {}
                temp.name = '三围'
                temp.icon = panel:add_texture(icon,x,y,w,h)
                table.insert(panel.attr_list,temp)  

                local temp = {}
                temp.title = panel:add_text('|cffffff00力量|r',x+10+w,8,216-w,10,8,'left')
                temp.title:set_color(0xffffff00)
                temp.name = '力量'
                temp.value = panel:add_text('0',x+10+w+5,26,216-w-5,12,8,'left')
                table.insert(panel.attr_list,temp)  

                local temp = {}
                temp.title = panel:add_text('|cffffff00敏捷|r',x+10+w,49,216-w,10,8,'left')
                temp.title:set_color(0xffffff00)
                temp.name = '敏捷'
                temp.value = panel:add_text('0',x+10+w+5,63,216-w-5,12,8,'left')
                table.insert(panel.attr_list,temp)     
                
                local temp = {}
                temp.title = panel:add_text('|cffffff00智力|r',x+10+w,85,216-w,10,8,'left')
                temp.title:set_color(0xffffff00)
                temp.name = '智力'
                temp.value = panel:add_text('0',x+10+w+5,101,216-w-5,12,8,'left')
                table.insert(panel.attr_list,temp)     
            end    
        end        


        panel:hide()
        
        return panel
    end,


    set_hero = function (self,hero)
        self.hero = hero
        if hero then 
            self:show()
        else
            self:hide()
            return
        end
        for index,data in ipairs(self.attr_list) do  
            -- print(data.name) 
            if finds(data.name,'生命','魔法') then 
                local str = bignum2string(hero:get(data.name)) ..' / '.. bignum2string(hero:get(data.name..'上限'))
                data.value:set_text(str)
            elseif finds(data.name,'三围','力量','敏捷','智力') then 
                if not hero:is_hero() then  
                    if data.icon then 
                        data.icon:set_normal_image('')
                    end  
                    if data.title then 
                        data.title:set_text('')
                    end  
                    if data.value then 
                        data.value:set_text('')
                    end    
                else
                    if finds(data.name,'力量','敏捷','智力') then 
                        if data.title then 
                            data.title:set_text(data.name)
                        end 
                        -- str = bignum2string(hero:get(data.name)) 
                        str = string.format('%.f',hero:get(data.name))
                        data.value:set_text(str)
                    end   
                    if data.icon then 
                        data.icon:set_normal_image('image\\控制台\\BTN UI 028.blp')
                    end   
                end   
            elseif data.name =='护甲' then 
                if hero:has_restriction '无敌' then
                    data.value:set_text('|cffff0000无敌|r')
                else
                    -- str = bignum2string(hero:get(data.name)) 
                    str = string.format('%.f',hero:get(data.name))
                    data.value:set_text(str) 
                end
            else  
                -- str = bignum2string(hero:get(data.name)) 
                str = string.format('%.f',hero:get(data.name))
                data.value:set_text(str)      
            end    
        end

    end,

}

