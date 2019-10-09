local player = require 'ac.player'
local japi = require 'jass.japi'
register_japi[[
	native DzAPI_Map_SaveServerValue        takes player whichPlayer, string key, string value returns boolean
    native DzAPI_Map_GetServerValue         takes player whichPlayer, string key returns string
    native DzAPI_Map_Ladder_SetStat         takes player whichPlayer, string key, string value returns nothing
    native DzAPI_Map_IsRPGLadder            takes nothing returns boolean
    native DzAPI_Map_GetGameStartTime       takes nothing returns integer
    native DzAPI_Map_Stat_SetStat           takes player whichPlayer, string key, string value returns nothing
    native DzAPI_Map_GetMatchType      		takes nothing returns integer
    native DzAPI_Map_Ladder_SetPlayerStat   takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetServerValueErrorCode takes player whichPlayer returns integer
    native DzAPI_Map_GetLadderLevel         takes player whichPlayer returns integer
	native DzAPI_Map_IsRedVIP               takes player whichPlayer returns boolean
	native DzAPI_Map_IsBlueVIP              takes player whichPlayer returns boolean
	native DzAPI_Map_GetLadderRank          takes player whichPlayer returns integer
	native DzAPI_Map_GetMapLevelRank        takes player whichPlayer returns integer
	native DzAPI_Map_GetGuildName           takes player whichPlayer returns string
	native DzAPI_Map_GetGuildRole           takes player whichPlayer returns integer
	native DzAPI_Map_GetMapLevel            takes player whichPlayer returns integer
	native DzAPI_Map_MissionComplete        takes player whichPlayer, string key, string value returns nothing
	native DzAPI_Map_GetActivityData        takes nothing returns string
	native DzAPI_Map_IsRPGLobby             takes nothing returns boolean
	native DzAPI_Map_GetMapConfig           takes string key returns string
    native DzAPI_Map_HasMallItem            takes player whichPlayer, string key returns boolean
    native RequestExtraBooleanData          takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns boolean
    native DzTriggerRegisterSyncData        takes trigger trig, string prefix, boolean server returns nothing
    native DzSyncData                       takes string prefix, string data returns nothing
    native DzGetTriggerSyncData             takes nothing returns string
    native DzGetTriggerSyncPlayer           takes nothing returns player
    native DzGetMouseTerrainX               takes nothing returns real
    native DzGetMouseTerrainY               takes nothing returns real
    native DzGetMouseTerrainZ               takes nothing returns real
    native RequestExtraIntegerData          takes integer dataType, player whichPlayer, string param1, string param2, boolean param3, integer param4, integer param5, integer param6 returns integer
]]
ac.flag_use_mall = true --默认使用商城数据

--获取玩家评论数
function player.__index:Map_CommentCount()
    local handle = self.handle
    if global_test then 
        return self.comment or 1
    else    
        return japi.RequestExtraIntegerData(46, handle, nil, nil, false, 0, 0, 0)
    end    
end

--获取地图总评论数
function player.__index:Map_CommentTotalCount()
    local handle = self.handle
    if global_test then 
        return self.total_comment or 170000
    else    
        return 170000
        --japi.RequestExtraIntegerData(51, nil, nil, nil, false, 0, 0, 0) 不准
    end 
end

--玩家 清空服务器数据 (自定义服务器)
function player.__index:clear_server(...)
    local player = self
    --没有传参，默认全部清除
    if not ... then 
        for i,v in ipairs(ac.cus_server_key) do 
            local key = v[1]
            -- player:SetServerValue(key,0) 自定义服务器
            
            -- player:Map_SaveServerValue(key,0) --网易服务器
            player:Map_FlushStoredMission(key) --网易服务器
        end    
    else
        for i,key in ipairs(...) do
            -- print(key,value)
            player:Map_FlushStoredMission(key[1]) --网易服务器
        end   
    end    
end    

--所有玩家 清空服务器档案
function ac.clear_all_server(...)
    for i = 1, 10 do
        local player = ac.player(i)
        if player:is_player() then 
            player:clear_server(...)
        end   
    end
end

-- for key, value in pairs(japi) do
--     print(key, value)
-- end
--获取游戏开始时间
function player.__index:Map_GetGameStartTime()
    local handle = self.handle
    return japi.DzAPI_Map_GetGameStartTime()
end
--获取玩家是否购买重置版
function player.__index:Map_IsMapReset()
    local handle = self.handle
    return japi.RequestExtraBooleanData(44,handle,nil,nil,false,0,0,0)
end

--返回通用型 返回的是数字类型
function player.__index:Map_GetServerValue(key)
    local handle = self.handle
    local value = japi.DzAPI_Map_GetServerValue(handle,key)
    
    if not value or value == '' or value == "" then
        value = 0
    else
        value = value
    end
    return tonumber(value)
end

-- --存档通用型 只能存入字符串型
-- function player.__index:Map_SaveServerValue(key,value)
--     local handle = self.handle
--     japi.DzAPI_Map_SaveServerValue(handle,tostring(key),tostring(value))
-- end

--存档通用型 只能存入字符串型
function player.__index:Map_SaveServerValue(key,value)
    local handle = self.handle
    japi.DzAPI_Map_SaveServerValue(handle,tostring(key),tostring(value))
    --保存本局数据
    if not self.cus_server then 
        self.cus_server ={}
    end    
    local key_name = ac.server.key2name(key)
    self.cus_server[key_name] = tonumber(value)
end


function player.__index:Map_AddServerValue(key,value,f)
    if not self.cus_server then 
        self.cus_server ={}
    end    
    --保存
    local key_name = ac.server.key2name(key)
    -- print(key_name,self.cus_server[key_name])
    self.cus_server[key_name] = (self.cus_server[key_name] or 0 ) + tonumber(value)
    self:Map_SaveServerValue(key,self.cus_server[key_name])
end

--获取全局存档 返回字符串型
function ac.Map_GetMapConfig(key)
    return japi.DzAPI_Map_GetMapConfig(key)
end

--获取玩家地图等级
if global_test then 
    function player.__index:Map_GetMapLevel()
        if ac.flag_use_mall then 
            return (self.map_level or 40) + (self['局内地图等级'] or 0)
        else     
            return 1
        end    
    end
else
    function player.__index:Map_GetMapLevel()
        local handle = self.handle
        local level = japi.DzAPI_Map_GetMapLevel(handle)
        if level == 0 then 
            level = 1
        end 
        level = level + (self['局内地图等级'] or 0)
        if not ac.flag_use_mall then 
            level = 1
        end       
        return level
    end
end    

--获取玩家地图排名
function player.__index:Map_GetMapLevelRank()
    local handle = self.handle
    return japi.DzAPI_Map_GetMapLevelRank(handle)
end

--设置玩家的房间显示
function player.__index:Map_Stat_SetStat(Key,value)
    local handle = self.handle
    value = tostring(value)
    japi.DzAPI_Map_Stat_SetStat(handle,Key,value)
end

--删除存档 清除掉后无法还原
    --type 大写的 I,S,R,B
function player.__index:Map_FlushStoredMission(key)
    local handle = self.handle
    japi.DzAPI_Map_SaveServerValue(handle,key,nil)
end

--判断玩家是否有商城道具
function player.__index:Map_HasMallItem(key)
    local handle = self.handle
    -- print(handle,key)
    return japi.DzAPI_Map_HasMallItem(handle,key)
    --测试时，默认都为空，商城开关
    -- return false
end

--判断玩家服务器存档是否读取成功
function player.__index:GetServerValueErrorCode()
    if japi.DzAPI_Map_GetServerValueErrorCode(self.handle) == 0 then
        return true
    else
        return false
    end
end

--同步数据
function player.__index:SyncData(msg,f)
    if self:is_self() then 
        local msg = ac.encode(msg)
        japi.DzSyncData("ac",msg)
        local trg = CreateTrigger()
        japi.DzTriggerRegisterSyncData(trg,"ac",false)
        
        function action()
            local message = japi.DzGetTriggerSyncData()
            local player = japi.DzGetTriggerSyncPlayer()
            player = ac.player(GetPlayerId(player) + 1)
            message = ac.decode(message)
            -- print(message,player)
            if f then f(player,message)end
        end   
        TriggerAddAction(trg,action)  
    end    
    
end

--===================================================
--                  下面的一般用不到
--  读取和保存都是字符串类型的，下面函数只是转换了一下类型
--===================================================



--获取整数存档
function player.__index:Map_GetStoredInteger(Key)
    local handle = self.handle
    local key = 'I'..Key
    local value = japi.DzAPI_Map_GetServerValue(handle,key)
    return tonumber(value)
end

--获取字符串存档
function player.__index:Map_GetStoredString(Key)
    local handle = self.handle
    local key = 'S'..Key
    local value = japi.DzAPI_Map_GetServerValue(handle,key)
    return value
end

--获取浮点型存档
function player.__index:Map_GetStoreReal(Key)
    local handle = self.handle
    local key = 'R'..Key
    local value = japi.DzAPI_Map_GetServerValue(handle,key)
    return tonumber(value)
end

--获取布尔型存档
function player.__index:Map_GetStoreBoolean(Key)
    local handle = self.handle
    local key = 'B'..Key
    local value = japi.DzAPI_Map_GetServerValue(handle,key)
    value = tonumber(value)

    if value == 1 then
        return true
    elseif value == 0 then
        return false
    end
end


--存档 保存整数
function player.__index:Map_StoreInteger(Key,value)
    local handle = self.handle
    local key = 'I'..Key  --需要在Key前面补个I
    japi.DzAPI_Map_SaveServerValue(handle,key,tostring(value))
end


--存档 布尔
function player.__index:Map_StoreBoolean(Key,value)
    local handle = self.handle
    local key = 'B'..Key  --需要在Key前面补个B
    if value then
        japi.DzAPI_Map_SaveServerValue(handle,key,'1')
    else
        japi.DzAPI_Map_SaveServerValue(handle,key,'0')
    end
end

--存档 保存浮点型
function player.__index:Map_StoreReal(Key,value)
    local handle = self.handle
    local key = 'R'..Key  --需要在Key前面补个R
    japi.DzAPI_Map_SaveServerValue(handle,key,tostring(value))
end

--存档 保存字符串
function player.__index:Map_StoreString(Key,value)
    local handle = self.handle
    local key = 'S'..Key  --需要在Key前面补个S
    japi.DzAPI_Map_SaveServerValue(handle,key,value)
end
