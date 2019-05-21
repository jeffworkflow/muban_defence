local ui            = require 'ui.client.util'
local game          = require 'ui.base.game'
local json = require 'util.json'
local player = require 'ac.player'

local config = {
    map_name = '第三张防守图',
    url = 'www.91mtp.com/api/maptest' , --类似官方对战平台的服务器存档
    url2 = 'www.91mtp.com/api/mapdb' --统一存储过程入口
}
ac.server_config = config

--读取 map_test 
function player.__index:GetServerValue(KEY,f)
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url

    local post = 'get=' .. json.encode({
        map_name = map_name,
        player_name = player_name,
        key = KEY,
    })

    post_message(url,post,function (retval)  
        local value = string.find(retval, 'error_code')
        if value == nil then
            local tbl = json.decode(retval)
            for k, v in ipairs(tbl) do
                f(v)
            end
        else 
            f(false)
        end
        -- self:event_notify('玩家-读取数据', tbl) 没用
    end)
end
--保存到 map_test 
function player.__index:SetServerValue(key,value,f)
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    local key_name,is_mall = ac.get_keyname_by_key(key)
    local value = tostring(value) 

    local post = 'exec=' .. json.encode({
        sp_name = 'sp_save_map_test',
        para1 = map_name,
        para2 = player_name,
        para3 = key,
        para4 = key_name,
        para5 = value,
        para6 = is_mall,
    })
    local f = f or function (retval)  end
    -- print(url,post)
    post_message(url,post,function (retval)  
        local tbl = json.decode(retval)
        if tbl.code == 0 then 
            f(tbl)
        else
            print(self:get_name(),post,'上传失败')
        end         
    end)

end
--copy servervalue 到 map_test 
function player.__index:CopyServerValue(key,f)
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    local value,key_name,is_mall = ac.get_server(self,key)
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_save_map_test',
        para1 = map_name,
        para2 = player_name,
        para3 = key,
        para4 = key_name,
        para5 = value,
        para6 = is_mall,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,f)
end
--copy 所有servervalue
function player.__index:CopyAllServerValue()
    for i,v in ipairs(ac.server_key) do 
        local key = v[1] 
        ac.wait(1000*i,function()
            self:CopyServerValue(key,function (retval)  
                local tbl = json.decode(retval)
                -- print(tbl.code)
                if tbl.code == 0 then 
                    -- print(self:get_name(),'上传成功')
                else
                    print(self:get_name(),key,'上传失败')
                end        
                -- end    
            end);
        end)    
    end    
end   
--初始化自定义服务器的数据
function player.__index:initCusServerValue()
    for i,v in ipairs(ac.cus_server_key) do 
        local key = v[1]
        local player_name = self:get_name()
        local map_name = config.map_name
        local url = config.url2
        local value = 0
        local key_name = v[2]
        -- print(map_name,player_name,key,key_name,is_mall,value)
        local post = 'exec=' .. json.encode({
            sp_name = 'sp_save_map_test',
            para1 = map_name,
            para2 = player_name,
            para3 = key,
            para4 = key_name,
            para5 = value,
            para6 = 0,
        })
        -- print(url,post)
        local f = f or function (retval)  end
        --如果当前数据>0 则不进行初始化
        self:GetServerValue(key,function(data)
            --没有返回,才进行初始化
            print(data)
            if not data then    
                post_message(url,post,f)
            end   
        end)


    end    
end  
local function init()
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            p:CopyAllServerValue()
            p:initCusServerValue()
        end    
    end    
    print('上传数据')
end  
ac.server_init = init  

--===========业务函数==============================

--[[
===========自定义服务器 基本功能 ===================
1.进游戏时，往 map_player 插入玩家数据 ，存在更新时间，不存在插入
2.copy 一份服务器存档的数据到 map_test 里面，一样时存在即更新，不存在插入
3.copy 一份商城道具也再服务器存档里面，
4.读取业务端数据 例如排行榜，显示。
5.保存业务端数据到服务器。

=========== 黑名单 map_black_list ===================
目标： war3客户端 读取 黑名单数据，封掉游戏（使游戏结束）
过程：
1.黑名单表
2.插入到黑名单表的条件。 sp_black_list
   a.触发器 一次性积分增加50W,视为作弊. 更改加密保存服务器积分函数,
   b.关键字管理。 
3.游戏内，每5分钟查询一次,查到作弊时,清空所有 网易服务器存档 数据,使掉线.
4.是否考虑地图等级因素,需要考虑,但在客户端执行比较合适,地图等级3级才能参与或是保存服务器的一些数据.
5.每5分钟操作:
  a.同步一次网易服务器积分 到 自定义服务器 触发器可以自动插入到黑名单表
  b.检查黑名单表,如果在表内,使其掉线.
]]






