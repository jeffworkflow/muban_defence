local player = require("ac.player")
--保存排名数据
function player.__index:sp_set_rank(key,value,f)
    local player_name = self:get_name()
    local map_name = ac.server_config.map_name
    local url = ac.server_config.url2
    local value = value or 0
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_set_rank',
        para1 = map_name,
        para2 = player_name,
        para3 = key,
        para4 = value,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,f)
end
--读取排名数据
function player.__index:sp_get_rank(key,order_by,limit_cnt,f)
    local player_name = self:get_name()
    local map_name = ac.server_config.map_name
    local url = ac.server_config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_rank',
        para1 = map_name,
        para2 = key,
        para3 = order_by,
        para4 = limit_cnt,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval) 
        local tbl = json.decode(retval)
        if tbl.code == 0 then 
            f(tbl.data[1])
        else
            print(key,'获取排名失败')
        end        
    end)
end

--游戏结束
ac.game:event '游戏-结束'(function(_)
    local value = ac.creep['刷怪-无尽'].index or 0
    if value == 0 then 
        return 
    end    
    --不是圣人模式返回
    if ac.g_game_degree ~= 4 then 
        return 
    end    

    --保存自定义服务器的排名(每日)
    --每一把保存一次,提早退出 无排名
    for i=1,10 do
        local p = ac.player[i]
        if p.hero  then 
            --保存波束
            p:sp_set_rank('boshu_rank',value)
            p:GetServerValue('boshu_rank',function(data)
                if type(data) ~= 'table' then  
                    return
                end    
                if value >= (tonumber(data.value) or 0) then 
                    p:SetServerValue('boshu_rank',value)
                end   
            end)
            --保存金钱
            local gold = tonumber(p.gold_count)
            p:sp_set_rank('gold',gold)
            --如果当前游戏获得金钱>历史总金钱,保存到服务器里面去. 层数
            p:GetServerValue('gold',function(data)
                if type(data) ~= 'table' then  
                    return
                end    
                -- print_r(data)
                if gold >= (tonumber(data.value) or 0) then 
                    p:SetServerValue('gold',gold)
                end   
            end)
        end      
    end    

end);    

require("平台.自定义服务器.排行榜.巅峰排行榜")
require("平台.自定义服务器.排行榜.福布斯排行榜")

