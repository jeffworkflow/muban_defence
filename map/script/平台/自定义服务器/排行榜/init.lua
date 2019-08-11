local player = require("ac.player")
--保存排名数据
function player.__index:sp_set_rank(key,value,f)
    -- if not ac.flag_map then 
    --     return 
    -- end
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
  

require("平台.自定义服务器.排行榜.排行榜")
require("平台.自定义服务器.排行榜.无尽排行榜1")
require("平台.自定义服务器.排行榜.无尽排行榜2")
require("平台.自定义服务器.排行榜.无尽排行榜3")
require("平台.自定义服务器.排行榜.无尽排行榜4")

