

function get_str_line(str,count)
    local a = 1
    local b = 1
    local c = 0
    local line = 0
    count = count - 3
    str = str:gsub('|c%w%w%w%w%w%w%w%w','')
    str = str:gsub('|r','')
     while (a <= str:len()) do
        local s = str:sub(a,a)
        if s:byte() > 127 then
            c = c+1
            if c == 3 then
                c = 0
            end
        else
            c = 0
        end
        if (b > count and c == 0) or s == '\n' or a == str:len() then
            if s == '\n' then
                s = str:sub(a - b + 1,a - 1)
            else
                s = str:sub(a - b + 1,a)
            end
            line = line + 1
            b = 0
        end
        a = a+1
        b = b+1
    end
    return line
end

local tool = {
    item_tooltip = function (self,...)
        local arg = {...}
        if #arg == 0 then 
            return 
        end
        local path = 'image\\提示框\\Item_Prompt.tga'
        local x,y,width,height,font_size = 0,0,360,80,15
        class.ui_base.remove_tooltip()

        offset = offset or 1
        local ox,oy
        if self ~= nil then 
            ox,oy = self:get_real_position()
            ox = ox + self.w / 2
        else
            ox,oy = game.get_mouse_pos()
        end
       
        x = ox + x - width / 2 

 
        local offset = -1
        local tbl = {}
        if type(arg[#arg]) == 'number' then 
            offset = arg[#arg]
        end 
        for i=1,#arg do
            local item          = arg[i]
            if type(item) == 'table' then 
                local title         = item:get_title() or ''
                local tip           = item:get_tip() or ''
                local background    = item:get_type_icon() or ''
                local image          = item:get_icon() or ''
                local price         = item:get_sell_price() or 0

                local line = get_str_line(tip,13*3-1)
                local max_height = (line + 3) * 27
                local ox = x + (i - 1) * (width + 50 ) * offset
                local y = oy + y - max_height
                if y < 0 then 
                    max_height = max_height + math.abs(y)
                end
                local panel = class.panel.create(path,ox,y,width,max_height)
                panel:set_alpha(0.8)

                local text = panel:add_text(title,0,font_size,width,64,font_size,'top') 
                local icon_background = panel:add_texture(background,40,5,48,48)
                local icon = panel:add_texture(image,40,5,48,48)
                local y = 64
                --如果物品价格大于0 则显示金钱图标 + 物品价格
                if price > 0 then 
                    local gold_icon = panel:add_texture('image\\背包\\jinbi.tga',220,58,32,32)
                    local gold_text = panel:add_text(tostring(price),260,58,200,32,12,'auto_newline')
                end 
                local text2 = panel:add_text(tip,32,y,width,max_height,font_size,'auto_newline')
                text2:set_control_size(width-64,max_height)
                table.insert(class.ui_base.tooltip_list,panel)
            end
        end
    end,


    skill_tooltip = function (self,skill,level,pos)
        local art = skill:get_art()

        local title = skill:get_name()
        local item = skill.item 

        local type 
        local keyboard = ''
        if item then 
            type = '物品'
        else 
            type = '技能'
            
            if skill:get_spell_type() == '主动' and skill.owner:get_owner() == ac.player.self then 
                if skill.owner.handle == japi.GetRealSelectUnit() then 
                    keyboard = skill:get_hotkey_tip()
                end 
            end
        end 

        --回收掉已经在显示的tip
        --class.ui_base.remove_tooltip()

        local x,y = 0,0 --self:get_real_position()
        local width,height = 350 ,400
        
        local panel = class.panel.create('image\\提示框\\bj2.tga',x,y,width,height)
        local panel_texture = panel:add_texture('image\\提示框\\BJ.tga',5,5,panel.w-10,panel.h-10)
        --标题面板
        local title_panel = panel:add_panel('image\\提示框\\BT.tga',5,5,width-10,70)
        --图标
        local title_art = title_panel:add_texture(art,10,10,50,50)

        --标题
        local title_text = title_panel:add_text('|cffdde7f1'..title..'|r ' .. keyboard,title_art.w + title_art.x + 20,13,150,15,12,0)

        local is_h = title_panel.y + title_panel.h + 10


        if item then 
            local gold = item:get_sell_price()
            local gold_texture = panel:add_texture('image\\提示框\\glod.tga',title_art.w + title_art.x + 20,42,25,25)
            local txt = panel:add_text('|cffd58b2c'..gold..'|r',gold_texture.x + 35,gold_texture.y + ((gold_texture.h-10)/2),200,10,10,'auto_newline')

            local attr = skill.data.attr 
            if attr then 
                local list = {}
                for name,value in pairs(attr) do 
                    table.insert(list,{name = name,value = value})
                end 
                table.sort(list,function (a,b) return a.name < b.name end)
                local s = {}
                for index,value in ipairs(list) do 
                    s[#s + 1] =  '|cffa0a0a0+ |r' .. value.value .. ' |cffa0a0a0' .. value.name .. '|r\n'
                end 

                local state = panel:add_text(table.concat(s),20,is_h,200,#s * 20,10,'auto_newline')
                is_h = is_h + state.h
            end 
            
   

            is_h = is_h + 10
        else 
            local level_str = '等级 : ' .. (level or skill:get_level())
            local level_text = panel:add_text(level_str,10,20,panel.w-30,10,10,'right')
            local s = {
                
                skill:get_target_type_tip() .. '\n',
                skill.target_tip or '影响：敌方单位',
                '\n'
            }
            local type_tip = '|cffa0a0a0' .. table.concat(s) .. '|r'
            local type_text = panel:add_text(type_tip,10,is_h,200,#s * 20,10,'auto_newline')
            is_h = is_h + type_text.h

        end 



        local art_bj = 'image\\提示框\\lsBJ.tga'
        local art_bt = 'image\\提示框\\lsBT.tga'
        local color_ti='|cff69ae64'
        local color_text= '|cff59636d'
        local target_type = skill:get_spell_type()
        if target_type == '被动' then
            art_bj = 'image\\提示框\\hsBJ.tga'
            art_bt = 'image\\提示框\\hsBT.tga'
            color_ti='|cffa0abbb'
            color_text= '|cff59636d'
        end

        local tip_str = skill:get_tip() 
        if type == '物品' then 
            tip_str = tip_str .. '\n' ..  get_item_compound_str(item:get_name())
        end 

        local skl_height = get_str_line(tip_str,13*3-1) * 12 + 10
        --背景
        local skl_panel = panel:add_panel(art_bj,10,is_h,width-20,skl_height + 50)
        --标题
        local skl_ti_panel = skl_panel:add_panel(art_bt,0,0,skl_panel.w,33)
        local skl_title = skl_ti_panel:add_text(color_ti..target_type..'：'..(skill.title or skill:get_name())..'|r',5,6,150,33,11,'auto_newline')
        --耗蓝
        if skill.cost > 0 then
            local cost_tex = skl_ti_panel:add_texture('image\\提示框\\cost.tga',skl_ti_panel.w - 150,6.5,20,20)
            local cost_text= skl_ti_panel:add_text(color_text..skill.cost..'|r',skl_ti_panel.w-125,10,25,skl_ti_panel.h,8,'auto_newline')
        end

        --cd
        if skill.cool > 0 then
            local cost_tex = skl_ti_panel:add_texture('image\\提示框\\cool.tga',skl_ti_panel.w - 50,6.5,20,20)
            local cost_text= skl_ti_panel:add_text(color_text..skill.cool..'|r',skl_ti_panel.w-25,10,25,skl_ti_panel.h,8,'auto_newline')
        end  

        local tip = '|cffa0a0a0' .. tip_str:gsub('|[rR]','|cffa0a0a0') ..'|r'

       
        --内容
        local skl_tip = skl_panel:add_text(tip,10,40,skl_panel.w - 10,skl_panel.h - 40,9,'auto_newline')
        skl_tip:set_control_size(skl_tip.w - 10,skl_tip.h)

        is_h = skl_panel.y + skl_panel.h

        panel:set_control_size(panel.w,is_h + 10)
        panel_texture:set_control_size(panel.w-10,panel.h - 10)

        local x,oy = self:get_real_position()
        local width,max_height = 400,400


        y = oy - panel.h / 2 + self.h / 2 

        if pos == nil or pos == 0 then 
            x = x + self.w + 5 
        elseif pos == 1 or pos == -1 then 
            x = x - panel.w - 5 
        elseif pos == 2 then 
            x = x - panel.w / 2  + self.w / 2
            y = oy - panel.h
        end 
        x = math.min(math.max(10,x),1900 - panel.w)
        y = math.min(math.max(10,y),1080 - panel.h)

        panel:set_position(x,y)

        --local title_type = title_panel:add_text('|cff9ea8a7类型：'..type..'|r',title_art.w + title_art.x + 20,42,150,15,9,3)

        table.insert(class.ui_base.tooltip_list,panel)
        return panel
    end,


    tooltip = function (self,title,tip,pos,pWidth,pHeight,font_size)

        --回收掉已经在显示的tip
        class.ui_base.remove_tooltip()

        local width,height = pWidth or 350 ,pHeight or 200
        local x,oy = self:get_real_position() 

        local max_height = get_str_line(tip,13*3-1) * 24 + 32
        if max_height < height then 
            max_height = height
        end 
        y = oy - max_height / 2 + self.h / 2 

        if pos == nil or pos == 0 then 
            x = x + self.w + 5 
        elseif pos == 1 or pos == -1 then 
            x = x - width - 5 
        elseif pos == 2 then 
            x = x - width / 2  + self.w / 2
            y = oy - max_height
        end 

        x = math.min(math.max(10,x),1900)
        y = math.min(math.max(10,y),1080)

        local title_str = title
        local title_align = 'auto_newline'
        if type(title) == 'table' then 
            title_str = title[1] 
            title_align = title[2]
        end 

        local panel = class.panel.create('image\\提示框\\bj2.tga',x,y,width,max_height)


        local texture = panel:add_texture('image\\提示框\\BJ.tga',5,5,panel.w-10,panel.h-10)
        local texture = panel:add_panel('image\\提示框\\BT.tga',5,5,panel.w-10,panel.h-10)
        local th = 0
        if title_str then 
            local title_text = texture:add_text(title_str,0,0,texture.w,32,font_size or 12,title_align)
            title_text:set_color(0xffe0e0e0)
            th = 30
        end    

        local tip_text = texture:add_text(tip,0,th,texture.w-20,texture.h,font_size or 12,'auto_newline')
        tip_text:set_color(0xffa0a0a0)
        tip_text:set_control_size(texture.w - 20,texture.h)

       


        table.insert(class.ui_base.tooltip_list,panel)
        return panel
    end,




    chess_tooltip = function (self,chess)
         --回收掉已经在显示的tip
         class.ui_base.remove_tooltip()

         local name = chess.name
 
         local x,y = self:get_real_position() 
 
         local width,height = 250,420
         y = y - height / 2 + self.h / 2 
 
         x = x - width - 5
 
 
         x = math.min(math.max(10,x),1920 - width)
         y = math.min(math.max(10,y),1080 - height)

        local panel = class.panel.create('image\\提示框\\bj2.tga',x,y,width,height)

        local texture = panel:add_panel('image\\提示框\\BT.tga',5,5,width - 10,height-10)

        local actor = panel:add_actor(name,width / 2, height / 2 - 20)
        actor:set_size(0.8)

        width = width - 10
        
        local text = texture:add_text(actor:get_title(),0,0,width,50,16,'center')
        text:set_color(0xffa0a0a0)


        local icon = texture:add_texture('image\\操作栏\\icon_gold.blp',25,48,24,24)

        local gold = texture:add_text(actor:get_gold_tip(),55,48,200,30,12,'auto_newline')

        local type_list = actor:get_type_list()

        local ax,ay = 32,230
        for index,name in ipairs(type_list) do 
            local skill = ac.table.skill[name]
            if skill then 
                texture:add_texture(skill.art or '',ax,ay,32,32)
                ax = ax + 40
            end
        end

        local attr_panel = panel:add(class.attr_panel,20,270)
        attr_panel:set_hero(actor)
        attr_panel:set_text_size(1.3)

        table.insert(class.ui_base.tooltip_list,panel)
        return panel
    end,
}



setmetatable(class.ui_base,{__index = tool})