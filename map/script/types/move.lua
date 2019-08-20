local jass = require 'jass.common'
local game = require 'types.game'

local move = {}

function move.update_speed(u, move_speed)
	if move_speed > 522 and not move.last[u] then
		move.add(u)
		if not u.move_trg then 
			u.move_trg = u:event '单位-死亡' (function(_,unit,killer)
				move.remove(u)
			end)
		end	
	elseif move_speed <= 520 and move.last[u] then
		move.remove(u)
	end
	--单位死亡时，要移除group table
	-- if not u:is_alive() and move.last[u] then
	-- 	move.remove(u)
	-- end	
end

function move.add(u)
	move.last[u] = u:get_point()
	table.insert(move.group, u)
end

function move.remove(u)
	move.last[u] = nil
	for i, uu in ipairs(move.group) do
		if u == uu then
			table.remove(move.group, i)
			break
		end
	end
end

function move.init()
	move.last = setmetatable({}, { __mode = 'k' })
	move.group = {}
end

local frame = game.FRAME
function move.update()
	for _, u in ipairs(move.group) do
		local last = move.last[u]
		local now = u:get_point()
		local speed = now * last / frame
		if speed > 520 and speed < 525 then
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


return move
