local item = {}
setmetatable(item, item)

--结构
local mt = {}
item.__index = mt

--类型
mt.type = 'item'

--tid 物品类型ID
mt.tid = 0

--所属单位
mt.unit = nil

--物品名
mt.name = nil

--物品数量
mt.count = nil

--获取物品名
function mt:get_name()
    return self.name
end

--获取类型
function mt:get_type()
    local data = ac.table.ItemData[self:get_name()]
    return data.ItemType
end


--获取贴图
function mt:get_art()
    local s = self:get_type()
    local data = ac.table.ItemData[self:get_name()]
    local art = 'image\\图标\\'..s..'\\'..data.IconName
    return art
end



--创建一个物品
function c_ui.create_item(name,unit,count)
    local u = setmetatable({}, item)
    u.unit = unit
    u.name = name
    u.count = count or 0

    return u
end
