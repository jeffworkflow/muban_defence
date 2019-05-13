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
]]


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

--返回通用型 返回的是字符串型
function player.__index:Map_GetServerValue(key)
    local handle = self.handle
    local value = japi.DzAPI_Map_GetServerValue(handle,key)
    
    if not value or value == '' or value == "" then
        value = 0
    else
        value = value
    end
    return value
end

--存档通用型 只能存入字符串型
function player.__index:Map_SaveServerValue(key,value)
    local handle = self.handle
    japi.DzAPI_Map_SaveServerValue(handle,tostring(key),tostring(value))
    
end

--获取全局存档 返回字符串型
function ac.Map_GetMapConfig(key)
    return japi.DzAPI_Map_GetMapConfig(key)
end

--获取玩家地图等级
function player.__index:Map_GetMapLevel()
    local handle = self.handle
    return japi.DzAPI_Map_GetMapLevel(handle)
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
function player.__index:Map_FlushStoredMission(Key,type)
    local handle = self.handle
    local key = type..Key
    japi.DzAPI_Map_SaveServerValue(handle,key,nil)
end

--判断玩家是否有商城道具
function player.__index:Map_HasMallItem(key)
    local handle = self.handle
    -- print(handle,key)
    return japi.DzAPI_Map_HasMallItem(handle,key)
    --测试时，默认都为空
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
