local ui = require 'ui.server.util'

local bar = {}

bar.event = {

    on_random = function ()
        local player = ac.player(GetPlayerId(ui.player) + 1)
        local hero = player:get_hero()
        if hero == nil then 
            return 
        end 

        local skill = hero:find_skill('刷新商店','英雄')
        
        if not skill then 
            return 
        end
        if not skill:can_cast() then
            player:sendMsg('刷新商店技能不能释放')
            return
        end
        skill:cast()
      
    end,

    on_lock = function (is_enable)
        local player = ac.player(GetPlayerId(ui.player) + 1)
        player.lock = is_enable 
        player:event_notify('玩家-界面锁定变动', player,is_enable)
        print('玩家-界面锁定变动',player,is_enable)
    end,

    on_buy = function (index,hash)
        local player = ac.player(GetPlayerId(ui.player) + 1)
        local name = ui.get_str(hash)
        if name == nil then 
            print('哈希值没有对应的字符串',hash)
            return 
        end 
        if player.shop_list == nil then 
            print('没有商店列表,购买失败')
            return 
        end 
        if player.shop_list[index] ~= name then 
            print('购买英雄名字不匹配，购买失败',player.shop_list[index],name)
            return 
        end 

        if player:event_dispatch('玩家-界面购买英雄',  player,name) then 
            return 
        end 
        local hero,suc,res = player:want_buy_hero(name .. 'Lv1')

        if suc then 
            if player:is_self() then 
                player.select_panel.actors[index]:hide()
            end
            player.shop_list[index] = nil
            print('玩家-界面购买英雄成功',player,name)
        end 
    end,

}


function random_store_hero(player)

    local panel = ac.player.self.select_panel
    
    --先把上一次 商店里剩余的棋子放回棋盘
    local shop_list = player.shop_list
    if shop_list then 
        local list = {}
        for k,v in pairs(shop_list) do 
            table.insert(list,v)
        end 
        table.sort(list,function (a,b)
            return a < b 
        end)
        for index,name in ipairs(list) do 
            push_chess_to_chess_pool(name)
        end 
    end 

    local chess_map = {}

    local chess_list = player:get_all_unit()
    for index,chess in ipairs(chess_list) do 
        if chess.is_chess and chess.card_level and chess.card_level == 3 then 
            chess_map[chess.base_id or ''] = true 
        end 
    end 

    local shop_list = {}
    --然后再从棋盘里 随机抽取5个棋子出来 放到商店里
    for i=1,5 do 
        local name 

        for a = 1, 100 do 
            local temp = pop_chess_to_chess_pool(player.hero:get_level())
            if chess_map[temp] == nil then 
                name = temp 
                break 
            end 
            push_chess_to_chess_pool(temp)
        end 
        if name then 
            table.insert(shop_list,name)
            if player:is_self() then 
               panel.actors[i]:set_actor(name)
            end 
        end 
    end 
    player.shop_list = shop_list
    if player:is_self() then 
        panel:show()
    end 
    
end 

bar.update_store = function ()
    local list = get_player_list()
    for _,player in ipairs(list) do 
        if player.lock then
        else
            random_store_hero(player) 
        end
    end 
end 

--ac.loop(2000,function ()
--    bar.update_store()
--end)

ac.game:event '玩家-刷新商店' (function ()
    bar.update_store()
    --ac.player.self.select_panel:show()
end)
--
--ac.game:event '游戏开始' (function ()
--    bar.update_store()
--end)

ui.register_event('bar',bar.event)