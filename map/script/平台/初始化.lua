

--读取网易服务器积分和无尽波数
for i=1,8 do
    local player = ac.player[i]
    if player:is_player() then
        --读取积分
        local jifen  = tonumber(ac.GetServerValue(player,'jifen'))
        --读取波数
        local value = player:Map_GetServerValue('boshu')
        if not value or value == '' or value == "" then
            player.boshu = 0
        else
            player.boshu = tonumber(value)
        end
        --保存服务端积分
        player.jifen = ZZBase64.encode(jifen)
        --修复积分为负数的，并奖励10000积分
        if jifen < 0 then 
            local value = -jifen + 10000
            print(jifen,value)
            ac.jiami(player,'jifen',value)
            player:sendMsg('【系统消息】 已修复积分为0，并发放 积分10000 作为补偿',tonumber(ac.GetServerValue(player,'jifen')))
        end    
    else
        player.jifen = 0
        player.boshu = 0
    end
end

--copy 网易数据到自己的服务器去 
--并初始化自定义服务器存档
ac.server_init()  





