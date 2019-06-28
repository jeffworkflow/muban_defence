local ui            = require 'ui.client.util'
local json = require 'util.json'
local player = require 'ac.player'

local config = {
    map_name = '第三张防守图',
    url = 'www.91mtp.com/api/maptest' , --类似官方对战平台的服务器存档
    url2 = 'www.91mtp.com/api/mapdb' --统一存储过程入口
}
ac.server_config = config

--读取 map_test 单个并同步
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
                --发起同步请求
                local info = {
                    type = 'cus_server',
                    func_name = 'on_get',
                    params = {
                        [1] = KEY,
                        [2] = v,
                    }
                }
                ui.send_message(info)
                ac.wait(500,function()
                    f(v)
                end)   
            end
        else 
            f(false)
            print('数据读取失败')
        end
    end)
end

--读取 map_test 多个个并同步
function player.__index:sp_get_map_test(f)
    
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
            self.flag_get_map_test = true 
            local is_json = json.is_json(retval)
            if is_json then 
                local tbl = json.decode(retval)
                if tbl.code == 0 then 
                    local temp_tab = {}
                    -- print_r(tbl)
                    for i,data in ipairs(tbl.data[1]) do 
                        temp_tab[data.key] = data.value
                        --预设没有的值，从服务器读取并动态插入预设的key
                        local name = ac.server.key2name(data.key)
                        if not name then 
                            table.insert(ac.cus_server_key,{data.key,data.key_name})
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
                self.flag_get_map_test = true 
            else    
                self.try_server_cnt = (self.try_server_cnt or 0 ) + 1
                if self.try_server_cnt <= 3 then 
                    ac.wait(10,function()
                        self:sendMsg('|cffff0000读取存档失败|r,5秒后尝试|cffff0000第'..self.try_server_cnt..'次|r重新读取。|r')
                    end)
                    ac.wait(5*1000,function(t)
                        self:sp_get_map_test()
                    end)
                else
                    ac.wait(10,function()
                        self:sendMsg('|cffff0000读取存档失败,建议重开,以免覆盖存档数据。输入jixu可继续玩|r')
                        self:sendMsg('|cffff0000读取存档失败,建议重开,以免覆盖存档数据。输入jixu可继续玩|r')
                        self:sendMsg('|cffff0000读取存档失败,建议重开,以免覆盖存档数据。输入jixu可继续玩|r')
                    end)
                end    
            end    
        end            
    end)
end    
local ui = require 'ui.server.util'
--处理同步请求
local event = {
    on_get = function (key,val)
        local player = ui.player 
        if not player.cus_server then 
            player.cus_server = {}
        end    
        local name = ac.server.key2name(key)
        player.cus_server[name] = tonumber(val)
        if key =='jifen' then 
            player.jifen = tonumber(val)
        end    
    end,
    --从自定义服务器读取数据
    read_key_from_server = function (tab_str)
        local player = ui.player 
        if not player.cus_server then 
            player.cus_server = {}
        end    
        local data = ui.decode(tab_str) 
        for key,val in sortpairs(data) do 
            local name = ac.server.key2name(key)
            player.cus_server[name] = tonumber(val)

            print('同步后的数据：',player:get_name(),name,player.cus_server[name])
            if key =='jifen' then 
                player.jifen =  tonumber(val)
            end    
        end    
        player:event_notify('读取存档数据')

    end,
}
ui.register_event('cus_server',event)

--保存到 map_test 
-- 保存本局数据 p.cus_server[key] = value
function player.__index:SetServerValue(key,value,f)
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
                print_r(retval)
            end    
        else
            print('服务器返回数据异常:',post)
            print_r(retval)
        end    
    end)

    --保存本局数据
    if not self.cus_server then 
        self.cus_server ={}
    end    
    local key_name = ac.server.key2name(key)
    self.cus_server[key_name] = tonumber(value)
end

--增加数据到 map_test 
-- 保存本局数据 p.cus_server[key] = value
function player.__index:AddServerValue(key,value,f)
    if not self.cus_server then 
        self.cus_server ={}
    end    
    --保存
    local key_name = ac.server.key2name(key)
    -- print(key_name,self.cus_server[key_name])
    self.cus_server[key_name] = (self.cus_server[key_name] or 0 ) + tonumber(value)
    self:SetServerValue(key,self.cus_server[key_name])
end
--初始化自定义服务器的数据 暂时不用字段太多。
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


--玩家 清空服务器数据 (自定义服务器)
function player.__index:clear_server()
    local player = self
    for i,v in ipairs(ac.cus_server_key) do 
        local key = v[1]
        player:SetServerValue(key,0)
    end    
end    

--所有玩家 清空服务器档案
function ac.clear_all_server()
	for i = 1, 10 do
        local player = ac.player(i)
        if player:is_player() then 
            player:clear_server()
        end   
	end
end

--===============网易数据与自定义服务器数据交互===========================
--copy 网易数据 到 map_test 
function player.__index:CopyServerValue(key,f)
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






