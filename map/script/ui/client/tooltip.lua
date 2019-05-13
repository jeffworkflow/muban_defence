

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
        ui_base_class.remove_tooltip()

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
                local panel = panel_class.create(path,ox,y,width,max_height)
                panel:set_alpha(0.8)

                local text = panel:add_text(title,0,font_size,width,64,font_size,'top') 
                local icon_background = panel:add_texture(background,40,5,48,48)
                local icon = panel:add_texture(image,40,5,48,48)
                local y = 64
                --如果物品价格大于0 则显示金钱图标 + 物品价格
                if price > 0 then 
                    local gold_icon = panel:add_texture('image\\背包\\jinbi.tga',220,58,32,32)
                    local gold_text = panel:add_text(tostring(price),260,58,200,32,12,'left')
                end 
                local text2 = panel:add_text(tip,32,y,width,max_height,font_size,'left')
                text2:set_control_size(width-64,max_height)
                table.insert(ui_base_class.tooltip_list,panel)
            end
        end
    end,
}



setmetatable(ui_base_class,{__index = tool})