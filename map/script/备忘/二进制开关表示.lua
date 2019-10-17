--2 进制 开关 
local function has_flag(flag, bit)
	return flag % (bit * 2) - flag % bit == bit
end
print(has_flag(1,8))
print(has_flag(2,8))
print(has_flag(8,8))
-- 可获得的预设存档 
local target = {1,2,4,8} 
--  假设获得 4 次，存档代码 为 1,2,4,8
local player_value = 1+2+4+8
--   循环  遍历 看有是否 有值 
for i,val in ipairs(target) do 
    print(player_value,val,has_flag(player_value,val))
end 