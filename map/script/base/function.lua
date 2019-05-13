
function get_player_list()
    local list = {}
    for i=1,12 do 
        local player = ac.player(i)
        --判断 玩家控制者==用户 and 游戏状态==正在游戏
        if GetPlayerController(player.handle) == ConvertMapControl(0) and 
            GetPlayerSlotState(player.handle) == ConvertPlayerSlotState(1)
        then 
            table.insert(list,player)
        end 
    end 
    return list 
end 


--获取在线玩家数量
function get_player_count()
    local list = get_player_list()
    return #list
end 

function get_first_player()
    local list = get_player_list()
    return list[1] 
end 

function get_dead_count()
    local list = get_player_list()
    local count = 0
    for index,player in ipairs(list) do 
        local hero = player:get_hero()
        if hero and not hero:is_alive() then 
            count = count + 1
        end 
    end 
    return count 
end 