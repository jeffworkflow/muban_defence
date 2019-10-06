local ui            = require 'ui.client.util'
local json = require 'util.json'
local player = require 'ac.player'

local config = {
    map_name = '赤灵传说',
    url = 'www.91mtp.com/api/maptest' , --类似官方对战平台的服务器存档
    url2 = 'www.91mtp.com/api/mapdb' --统一存储过程入口
}
ac.server_config = config

--读取 map_test 单个并同步
function player.__index:GetServerValue(KEY,f)
    -- if not ac.flag_map or ac.flag_map  < 1 then 
    --     return 
    -- end
    if not self:is_self() then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url

    local post = 'get=' .. json.encode({
        map_name = map_name,
        player_name = player_name,
        key = KEY,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval)  

        if not finds(retval,'http','https','') or not finds(retval,'error_code')then 
            local tbl = json.decode(retval)
            for k, v in ipairs(tbl) do
                -- --发起同步请求
                ac.wait(10,function()
                    local info = {
                        type = 'cus_server',
                        func_name = 'on_get',
                        params = {
                            [1] = KEY,
                            [2] = tonumber(v.value),
                        }
                    }
                    ui.send_message(info)
                end)   
            end
        else 
            f(false)
            print('数据读取失败')
            ac.wait(10,function()print(retval)end)
        end
    end)
end

--读取 map_test 多个个并同步
function player.__index:sp_get_map_test(f)
    -- if not ac.flag_map or ac.flag_map < 1 then 
    --     return 
    -- end
    if not self:is_self() then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = ac.server_config.map_name
    local url = ac.server_config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_map_test',
        para1 = map_name,
        para2 = player_name,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,function (retval) 
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local is_json = json.is_json(retval)
            if is_json then 
                local tbl = json.decode(retval)
                if tbl.code == 0 then 
                    local temp_tab = {}
                    -- print_r(tbl)
                    for i,data in ipairs(tbl.data[1]) do 
                        temp_tab[data.key] = data.value
                       
                        --处理排行榜数据
                        if finds(data.key ,'today_wjsyld','today_wjwxld','today_cntwl','today_wjwszj','today_wjdpcq','today_wjxlms','today_cntwb') then
                            local new_key = data.key..'rank'
                            local new_key_name = ac.server.key2name(data.key)..'排名'
                            temp_tab[new_key] = data.rank
                        end    

                    end    
                    local tab_str = ui.encode(temp_tab)
                    -- print('数据长度',#tab_str) 
                    ac.wait(10,function()
                        --发起同步请求
                        local info = {
                            type = 'cus_server',
                            func_name = 'read_key_from_server',
                            params = {
                                [1] = tab_str,
                            }
                        }
                        ui.send_message(info)
                        f(v)
                    end) 
                    -- f(tbl.data[1])
                else
                    print('读取数据失败')
                    print_r(tbl)
                end  
            end 
        else
            print('服务器返回数据异常:',post)
            if retval and #retval<1000 then 
                print(retval)
            end   
            if  finds(retval,'执行失败') then
            else    
                self.try_server_cnt = (self.try_server_cnt or 0 ) + 1
                if self.try_server_cnt <= 3 then 
                    ac.wait(10,function()
                        self:sendMsg('|cffff0000读取存档失败|r,5秒后尝试|cffff0000第'..self.try_server_cnt..'次|r重新读取。|r')
                    end)
                    ac.wait(5*1000,function(t)
                        self:sp_get_map_test()
                    end)
                end    
            end    
        end            
    end)
end    
local ui = require 'ui.server.util'
--处理同步请求
local event = {
    onoff = function (val)
        local player = ui.player 
        ac.flag_map = val
        -- print('同步后的数据',ac.flag_map)
    end,
    on_get = function (key,val)
        local player = ui.player 
        if not player.cus_server2 then 
            player.cus_server2 = {}
        end    
        local name = ac.server.key2name(key)
        player.cus_server2[name] = tonumber(val)
        -- print('自定义服务器读取完后同步的数据',key,name,val)
        if key =='jifen' then 
            player.jifen = tonumber(val)
        end    
    end,
    --从自定义服务器读取数据
    read_key_from_server = function (tab_str)
        local player = ui.player 
        if not player.cus_server2 then 
            player.cus_server2 = {}
        end    
        local data = ui.decode(tab_str) 
        for key,val in sortpairs(data) do 
            local name = ac.server.key2name(key)
            player.cus_server2[name] = tonumber(val)

            -- print('同步后的数据：',player:get_name(),name,player.cus_server2[name])
            if key =='jifen' then 
                player.jifen =  tonumber(val)
            end    
        end    
        -- player:event_notify('读取存档数据')

    end,
}
ui.register_event('cus_server',event)

--保存到 map_test 
-- 保存本局数据 p.cus_server[key] = value
function player.__index:SetServerValue(key,value,f)
    if not self:is_self() then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    local key_name,is_mall = ac.server.key2name(key)
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
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local is_json = json.is_json(retval)
            if is_json then 
                local tbl = json.decode(retval)
                if tbl and tbl.code == 0 then 
                    f(tbl)
                else
                    print(self:get_name(),post,'上传失败')
                end         
            else
                print('返回值非json格式:',post)
                -- print_r(retval)
            end    
        else
            print('服务器返回数据异常:',post)
            -- print_r(retval)
        end    
    end)

    --保存本局数据
    if not self.cus_server2 then 
        self.cus_server2 ={}
    end    
    local key_name = ac.server.key2name(key)
    self.cus_server2[key_name] = tonumber(value)
end

--增加数据到 map_test 
-- 保存本局数据 p.cus_server[key] = value
function player.__index:AddServerValue(key,value,f)
    if not self:is_self() then 
        return 
    end    
    if not self.cus_server2 then 
        self.cus_server2 ={}
    end    
    --保存
    local key_name = ac.server.key2name(key)
    -- print(key_name,self.cus_server2[key_name])
    self.cus_server2[key_name] = (self.cus_server2[key_name] or 0 ) + tonumber(value)
    self:SetServerValue(key,self.cus_server2[key_name])
end
--初始化自定义服务器的数据 暂时不用字段太多。
function player.__index:initCusServerValue()
    if not self:is_self() then 
        return 
    end    
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
            -- print(data)
            if not data then    
                post_message(url,post,f)
            end   
        end)


    end    
end  
local function init()
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            p:CopyAllServerValue()
            -- p:initCusServerValue()
        end    
    end    
    print('上传数据')
end  
ac.server.init = init  



--===============网易数据与自定义服务器数据交互===========================
--copy 网易数据 到 map_test 
function player.__index:CopyServerValue(key,f)
    if not self:is_self() then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    local value,key_name,is_mall = ac.get_server(self,key)
    
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
    -- print('上传数据：',key,value,key_name,is_mall)
    local f = f or function (retval)  end
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local tbl = json.decode(retval)
            -- print(type(tbl.code),tbl.code,tbl.code == '0',tbl.code == 0)
            if tbl and tbl.code == 0 then 
                f(tbl)
            else
                print(self:get_name(),post,'上传失败')
            end         
        else
            print('服务器返回数据异常:',retval,post)
            -- ac.wait(10,function()
            --     print(retval)
            -- end)
        end    
    end)
end
--copy 所有 map_test
function player.__index:CopyAllServerValue()
    for i,v in ipairs(ac.mall) do 
        local key = v[1] 
        ac.wait(1000*i,function()
            self:CopyServerValue(key);
        end)    
    end    
end   

--保存玩家名 记录审核人员
function player.__index:sp_save_player()
    if not self:is_self() then 
        return 
    end    
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_save_player',
        para1 = player_name,
    })
    -- print(url,post)
    local f = f or function (retval)  end
    post_message(url,post,f)
end

-- for i=1,10 do
--     local p = ac.player(i)
--     if p:is_player() then 
--         p:sp_save_player()
--     end
-- end      

--读取全局开关，是否读服务器存档
local ui = require 'ui.client.util'
function player.__index:sp_get_map_flag(f)
    local player_name = self:get_name()
    local map_name = config.map_name
    local url = config.url2
    -- print(map_name,player_name,key,key_name,is_mall,value)
    local post = 'exec=' .. json.encode({
        sp_name = 'sp_get_map_flag'
    })
    local f = f or function (retval)  end 
    post_message(url,post,function (retval)  
        if not finds(retval,'http','https','') or finds(retval,'成功')then 
            local tbl = json.decode(retval)
            -- print(type(tbl.code),tbl.code,tbl.code == '0',tbl.code == 0)
            if tbl and tbl.code == 0 then 
                local flag_map = tbl.data[1][1].flag
                ac.wait(10,function()
                    local info = {
                        type = 'cus_server',
                        func_name = 'onoff',
                        params = {
                            [1] = tonumber(flag_map),
                        }
                    }
                    ui.send_message(info)
                end)   
                f(tbl)
            else
                print(self:get_name(),post,'上传失败')
            end         
        else
            print('服务器返回数据异常:',retval,post)
            -- self:sendMsg('|cffff0000读取服务器数据失败，本次冲榜可能无效!|r',10)
            -- self:sendMsg('|cffff0000读取服务器数据失败，本次冲榜可能无效!|r',10)
        end    
    end)
end
-- ac.flag_map = 0
--读取配置
ac.player(1):sp_get_map_flag()



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






