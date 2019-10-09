local jass = require 'jass.common'
local game = require 'types.game'

local move = {}

function move.update_speed(u, move_speed)
	if move_speed > 522 and not move.last[u] then
		move.add(u)
		if u:is_hero() then 
			return 
		end	
		print('插入速度表',u,u.handle,u:get_point(),u:is_alive(),#move.group)
		if not u.on_remove then 
			u.on_remove = function(self)
				if move.last[u] then 
					-- print('移除单位1',u,u.handle)
					move.remove(u)
				end	
			end
		end	
		-- if not u.move_trg then 
		-- 	print('插入速度表',u,u.handle,u:get_point(),u:is_alive())
		-- 	u.move_trg = u:event '单位-移除' (function(_,unit,killer)
		-- 		if move.last[u] then 
		-- 			-- print('移除单位1',u,u.handle)
		-- 			move.remove(u)
		-- 		end	
		-- 	end)
		-- end	
	elseif move_speed <= 519 and move.last[u] then
		move.remove(u)
	end	
end

function move.add(u)
	move.last[u] = u:get_point()
	table.insert(move.group, u)
end

function move.remove(u)
	move.last[u] = nil
	for i, uu in ipairs(move.group) do
		if u == uu then
			-- print(123)
			table.remove(move.group, i)
			if u.move_trg then
				u.move_trg:remove() 
				u.move_trg = nil 
			end	 
			break
		end
	end
end

function move.init()
	move.last = setmetatable({}, { __mode = 'k' })
	-- move.last = {}
	move.group = {}
end

local frame = game.FRAME
function move.update()
	for _, u in ipairs(move.group) do
		local last = move.last[u]
		local now = u:get_point()
		local speed = now * last / frame
		-- print(u:get_name(),speed,last,now)
		if speed > 519 and speed < 525 then
			--在魔兽速度520-525 之间，认为有超出520移动速度的可能性，做一次位置偏移，同时记录新的位置。
			local target = last - {last / now, u:get('移动速度') * frame}
			u:setPoint(target)
			move.last[u] = target
		else
			move.last[u] = now
		end
	end
end
-- 移动速度 1000 500 * 0.03 = 15
-- frame 0.03
-- 1000 * 0.03 = 330
-- ac.game:event '单位-死亡'(function(trg,unit,killer)
-- 	if unit:get('移动速度') > 522   then 
-- 		print('单位已经死亡了，而且速度超过522')
-- 		move.remove(unit)
-- 	end		
-- end)

return move
