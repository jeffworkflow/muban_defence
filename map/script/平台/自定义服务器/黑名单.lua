local player = require("ac.player")
--是否黑名单
function player.__index:sp_is_black(f)
    local player_name = self:get_name()
    local map_name = ac.server_config.map_name
    local url = ac.server_config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_is_black',
        para1 = map_name,
        para2 = player_name
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval) 
        local tbl = json.decode(retval)
        if tbl.code == 0 then 
            if not next(tbl.data[1]) then 
                f(false)
            else
                f(true)
            end
        else
            f(false) --不是黑名单数据
            -- print(key,'获取黑名单失败')
        end        
    end)
end
local function punish_black()
    for i = 1, 6 do 
        local player = ac.player(i)
        if player:is_player() then 
            --先同步服务器数据
            player:CopyServerValue('jifen')
            --判断是否黑名单
            player:sp_is_black(function(flag)
                -- true 在黑名单内
                ac.wait(10,function()
                    -- print(player:get_name(),'是否黑名单',flag)
                    if flag then 
                        -- EndGame(true) 处理掉线,会由寄存器报错问题
                        player:clear_server()
                        -- 清空网易服务器存档数据
                        player:sendMsg('【系统消息】 检测到可能作弊，清空数据')
                    end    
                end)

            end)
        end    
    end
end    

ac.punish_black = punish_black

--处理黑名单数据 每5分钟执行一次判断
local time = 5*60
if global_test == true then 
    time = 10
end    
ac.loop(time*1000,function()
    --执行黑名单惩罚
    ac.punish_black();
end);


