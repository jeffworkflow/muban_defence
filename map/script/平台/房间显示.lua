   

local function set_fj_data(player) 
    local temp = {}
    -- local yxj = {
    --     '最强王者','王者','星耀','钻石','铂金','黄金','白银','青铜',
    -- }
    local yxj =  ac.g_game_degree_list
    for key,value in pairs(player.cus_server) do
        for i,name in ipairs(yxj) do
            if key == name then
                if value > 0 then 
                    table.insert(temp,{key = key,value = value,key_yxj = i})
                end    
            end    
        end    
    end    
    --根据星数排序
    table.sort(temp,function (a,b)
        local flag 
        -- if a.value > b.value then 
        --     flag = true 
        -- --根据段位优先级
        -- elseif a.value == b.value then 
        --     if a.key_yxj < b.key_yxj then 
        --         flag = true 
        --     end
        -- else
        --     flag = false
        -- end    
        if a.key_yxj < b.key_yxj then 
            flag = true 
        end                  

		return flag
	end) 
    -- print(temp[1].key..temp[1].value..'星')
    -- for index,data in ipairs(temp) do 
    --     print(index,data.key,data.value,key_yxj)
    -- end    

    player:Map_Stat_SetStat('DW',temp[1].key..temp[1].value..'星')

end    

--设置房间显示数据
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end    
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --设置房间数据
            set_fj_data(player)
        end
    end
end) 

--设置房间显示数据
ac.game:event '游戏-无尽开始'(function(trg) 
    for i=1,10 do
        local player = ac.player[i]
        if player:is_player() then
            --设置房间数据
            set_fj_data(player)
        end
    end
end)    
