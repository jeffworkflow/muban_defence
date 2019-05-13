local list = {}
local text_timer 
function ui_print(...)
    local args={...}
    local s = ''
    for index = 1 , #args do 
        s=s..tostring(args[index])..' '
    end

    table.insert(list,s)
    if text_timer then 
        text_timer:remove()
    end 
    text_timer = game.loop(400,function (timer)
        if #list == 0 then 
            timer:remove()
            text_timer = nil
            return 
        end

        local value = list[1]
      
        table.remove(list,1)
        local i = 1 
        while i < #list do 
            if list[i] == value then 
                table.remove(list,i)
            else 
                i = i + 1
            end 
        end 

        local text = text_class.create(value,900,820,500,500,12)
        text:set_color(255,255,128,1)
 
        local num = 0
        game.loop(33,function ()
            num = num + 1
            if num >= 120 then 
                text:set_text('')
            else 
                text:set_position(text.x + 1,text.y - 2)
                text:set_alpha(text.color.a - 0.02)
            end
        end)
        
    end)
end