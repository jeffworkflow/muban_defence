local player = require("ac.player")
--保存排名数据
function player.__index:sp_set_rank(key,value,f)
    -- if not ac.flag_map then 
    --     return 
    -- end
    if not self:is_self() then 
        return 
    end
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
    if not ac.flag_map or ac.flag_map  < 1 then 
        return 
    end
    if not self:is_self() then 
        return 
    end
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
        local is_json = json.is_json(retval)
        if is_json then 
            local tbl = json.decode(retval)
            if tbl.code == 0 then 
                f(tbl.data[1])
            else
                print(key,'获取排名失败')
                print_r(tbl)
            end  
        else
            print('服务器请求失败',post,retval)
        end    
    end)
end

--读取s0排行榜奖励
local ui = require 'ui.client.util'
function player.__index:sp_get_rank_season1(f)
    if not self:is_self() then 
        return 
    end
    local player_name = self:get_name()
    local map_name = ac.server_config.map_name
    local url = ac.server_config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_rank_season1',
        para1 = map_name,
        para2 = player_name,
    })
    local f = f or function (retval)  end 
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local tbl = json.decode(retval)
            -- print(type(tbl.code),tbl.code,tbl.code == '0',tbl.code == 0)
            if tbl and tbl.code == 0 then 
                local temp_tab = {}
                -- print_r(tbl)
                for i,data in ipairs(tbl.data[1]) do 
                    temp_tab[data.season] = true
                end    
                local tab_str = ui.encode(temp_tab)
                ac.wait(10,function()
                    local info = {
                        type = 'rank_season',
                        func_name = 'season',
                        params = {
                            [1] = tab_str,
                        }
                    }
                    ui.send_message(info)
                end)   
            else
                print(self:get_name(),post,'上传失败')
            end         
        else
            print('服务器返回数据异常:',retval,post)
        end    
    end)
end

local ui = require 'ui.server.util'
--处理同步请求
local event = {
    --从自定义服务器读取数据
    season = function (tab_str)
        local player = ui.player  
        if not player.cus_server2 then 
            player.cus_server2 = {}
        end   
        -- player.cus_server2['S0赛季王者'] = 1

        local data = ui.decode(tab_str) 
        for key,val in sortpairs(data) do 
            player.cus_server2[key..'王者'] = 1
            player['局内地图等级'] = (player['局内地图等级'] or 0) +1
            -- print('同步后的数据：',player:get_name(),name,player.cus_server2[name])
        end    
    end,
}
ui.register_event('rank_season',event)

for i=1,10 do 
    local p = ac.player(i)
    if p:is_player() then 
        p:sp_get_rank_season1()  
    end    
end    

require("平台.自定义服务器.排行榜.排行榜")
require("平台.自定义服务器.排行榜.无尽榜")
-- require("平台.自定义服务器.排行榜.无尽排行榜1")
-- require("平台.自定义服务器.排行榜.无尽排行榜2")
-- require("平台.自定义服务器.排行榜.无尽排行榜3")
-- require("平台.自定义服务器.排行榜.无尽排行榜4")

