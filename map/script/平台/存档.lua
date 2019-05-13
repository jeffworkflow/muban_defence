local player = require 'ac.player'

--返回通用型 返回的是字符串型
function player.__index:Map_GetServerValue(key)
    local handle = self.handle
    return mtp_dzapi.DzAPI_Map_GetServerValue(handle,key)
end

--存档通用型 只能存入字符串型
function player.__index:Map_SaveServerValue(key,value)
    local handle = self.handle
    mtp_dzapi.DzAPI_Map_SaveServerValue(handle,tostring(key),tostring(value))
    
end

--获取全局存档 返回字符串型
function ac.Map_GetMapConfig(key)
    return mtp_dzapi.DzAPI_Map_GetMapConfig(key)
end

--获取玩家地图等级
function player.__index:Map_GetMapLevel()
    local handle = self.handle
    return mtp_dzapi.DzAPI_Map_GetMapLevel(handle)
end

--获取玩家地图排名
function player.__index:Map_GetMapLevelRank()
    local handle = self.handle
    return mtp_dzapi.DzAPI_Map_GetMapLevelRank(handle)
end

--设置玩家的房间显示
function player.__index:Map_Stat_SetStat(Key,value)
    local handle = self.handle
    value = tostring(value)
    mtp_dzapi.DzAPI_Map_Stat_SetStat(handle,Key,value)
end

--删除存档 清除掉后无法还原
    --type 大写的 I,S,R,B
function player.__index:Map_FlushStoredMission(Key,type)
    local handle = self.handle
    local key = type..Key
    mtp_dzapi.DzAPI_Map_SaveServerValue(handle,key,nil)
end

--判断玩家是否有商城道具
function player.__index:Map_HasMallItem(key)
    local handle = self.handle
    return mtp_dzapi.DzAPI_Map_HasMallItem(handle,key)
end

--判断玩家服务器存档是否读取成功
function player.__index:GetServerValueErrorCode()
    if mtp_dzapi.DzAPI_Map_GetServerValueErrorCode(self.handle) == 0 then
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
    local value = mtp_dzapi.DzAPI_Map_GetServerValue(handle,key)
    return tonumber(value)
end

--获取字符串存档
function player.__index:Map_GetStoredString(Key)
    local handle = self.handle
    local key = 'S'..Key
    local value = mtp_dzapi.DzAPI_Map_GetServerValue(handle,key)
    return value
end

--获取浮点型存档
function player.__index:Map_GetStoreReal(Key)
    local handle = self.handle
    local key = 'R'..Key
    local value = mtp_dzapi.DzAPI_Map_GetServerValue(handle,key)
    return tonumber(value)
end

--获取布尔型存档
function player.__index:Map_GetStoreBoolean(Key)
    local handle = self.handle
    local key = 'B'..Key
    local value = mtp_dzapi.DzAPI_Map_GetServerValue(handle,key)
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
    mtp_dzapi.DzAPI_Map_SaveServerValue(handle,key,tostring(value))
end


--存档 布尔
function player.__index:Map_StoreBoolean(Key,value)
    local handle = self.handle
    local key = 'B'..Key  --需要在Key前面补个B
    if value then
        mtp_dzapi.DzAPI_Map_SaveServerValue(handle,key,'1')
    else
        mtp_dzapi.DzAPI_Map_SaveServerValue(handle,key,'0')
    end
end

--存档 保存浮点型
function player.__index:Map_StoreReal(Key,value)
    local handle = self.handle
    local key = 'R'..Key  --需要在Key前面补个R
    mtp_dzapi.DzAPI_Map_SaveServerValue(handle,key,tostring(value))
end

--存档 保存字符串
function player.__index:Map_StoreString(Key,value)
    local handle = self.handle
    local key = 'S'..Key  --需要在Key前面补个S
    mtp_dzapi.DzAPI_Map_SaveServerValue(handle,key,value)
end
