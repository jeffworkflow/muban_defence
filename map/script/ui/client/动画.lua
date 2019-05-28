

local resource = {
    ['胜利'] = {'test\\UI_effect_vectory.mdx','textures\\TD_UI_victory.blp'},
    ['失败'] = {'test\\UI_effect_defeat.mdx','textures\\TD_UI_defeat.blp'},
    ['平局'] = {'test\\UI_effect_peace.mdx','textures\\TD_UI_peace.blp'},
    ['大吉大利,今晚吃鸡'] = {'test\\UI_effect_vectory.mdx','textures\\TD_UI_win2.blp',2},
    ['再接再厉'] = {'test\\UI_effect_loss.mdx','textures\\TD_UI_loss.blp',2},
}

function play_screen_animation(player,name)
    if not player:is_self() then 
        return 
    end 

    local info = resource[name]
    if not info then 
        return 
    end 
    local mode = info[3]

    local path1,path2 = table.unpack(info)
    local w,h = 400,300
    local x,y = 760,300
    local list = {}
    local count = 5 
    local size = 0.001
    if mode then 
        count = 10
        size = 0.002
    end 
    for i=1,count do 
        local model = class.model.create(path1,x,y,w,h)
        model:set_model_offset(w/2,-h/2)
        model:set_size(size)
        model:set_time(2)
        model:set_alpha(0.8)
        model:set_speed(0.5)
        list[i] = model 
    end

    local texture = class.texture.create(path2,x,y,w,h)
    
   
    ac.wait(1000,function ()
        local i = 1
        ac.timer(33,33,function ()
            i = i - 0.03 
            texture:set_alpha(i)
        end)
        texture:set_time(1)
    end)
   
   


    local num = 0
    ac.timer(16,count,function ()
        num = num + 1 
        local model = list[num]
        model:set_animation(0,true)
    end)

end 


ac.game:event '玩家-战局结束' (function(_,player,win,data)
    if win == nil then 
        play_screen_animation(player,'平局')
    elseif win == true then 
        play_screen_animation(player,'胜利')
    elseif win == false then 
        play_screen_animation(player,'失败')
    end
end)

ac.game:event '游戏结束' (function (_,is_winer)
    if is_winer == ac.player.self then 
        play_screen_animation(ac.player.self,'大吉大利,今晚吃鸡')
    else 
        play_screen_animation(ac.player.self, '再接再厉')
    end 
end)


