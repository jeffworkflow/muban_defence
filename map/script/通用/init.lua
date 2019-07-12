require '通用.初始化'
require '通用.宠物相关'
require '通用.物品规则'
require '通用.对话框'
require '通用.常用函数'
require '通用.过场动画'

-- local unit = require("types.unit")

-- --根据类型取可用的handle  function player.__index:get_unit_handle(class)
-- function unit.get_unit_handle(class)
--     if not class then return end 
--     local handle
--     local u 
--     for hd,j_u in pairs(unit.all_units) do 
-- 		if j_u:get_class() == class and j_u.removed then 
--             handle = hd
--             u = j_u
-- 			break
-- 		end
--     end	 
--     return handle,u
-- end

-- ac.game:event '单位-创建前'(function(_,data,self,j_id, x, y,face)
--     local handle,u = unit.get_unit_handle(data.class)
--     if handle then 
--         u:set_position(ac.point(x,y)) --需要提前设置位置
--         unit.remove_handle_map[handle] = nil 
--         local u = unit.init_unit(handle, self) --重新初始化
--         u.removed = nil
--         return u
--     end    
-- end)


--[[
模拟死亡 set_class '模拟死亡'



handle,死亡单位id，单位数量,


]]