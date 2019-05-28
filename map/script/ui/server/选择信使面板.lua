local ui = require 'ui.server.util'
local select = {}


select.event = {
    select = function (index)
        local player = ac.player(GetPlayerId(ui.player) + 1)
        local hero = player.hero 
        if hero then 
            print('玩家已经有英雄了，选择失败')
        end 
        if player.select_hero_list == nil then 
            print('没有选择列表,选择失败')
            return 
        end 
        local name = player.select_hero_list[index]
        if name == nil then 
            print('没有名字，选择失败',index)
            return 
        end 
        print('选择',name)
        select.clear_select(player)

        ac.game:event_notify('玩家-选择英雄',player,name)

        
    end,

}

select.start_select = function (player)


    if player:is_self() and ac.select_hero_box == nil then 
        ac.select_hero_box = class.unit_list_box.create()
    end 
    --local list = {'小鸡','谜团','冥界亚龙','全能骑士','卓尔游侠','全能骑士','卓尔游侠','小小'}
    local list = {'小鸡','绵羊','企鹅'}


    if player.has_item and player:has_item('92435') then
        table.insert(list,'向日葵')
    end
    select.set_select_list(player,list)
end



select.set_select_list = function (player,list)
    player.select_hero_list = list 

    if player:is_self() and ac.select_hero_box then 
        ac.select_hero_box:set_unit_list(list)
    end 
end


select.clear_select = function (player)
    player.select_hero_list = nil 

    if player:is_self() and ac.select_hero_box then 
        ac.select_hero_box:destroy()
        ac.select_hero_box = nil 
    end 
end


ac.game:event '玩家-准备选择英雄' (function(_,player)
    select.start_select(player)
end)


ac.game:event '游戏开始' (function()
    for i=1,8 do 
        select.clear_select(ac.player(i),list)
    end 
end)



ui.register_event('信使',select.event)