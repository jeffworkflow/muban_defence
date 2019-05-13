
local function init()
end

ac.game:event '单位-死亡' (function (_,unit,killer)
	local data = killer:get_owner().count_data
	if not data then
		return
	end

	local type_d = unit.unit_type
	if unit.is_boss or type_d == '领主'  then 
		type_d = 'BOSS'
	end 
	if not data.kill_count[type_d] then
		data.kill_count[type_d] = 0
	end
	data.kill_count[type_d] = data.kill_count[type_d] + 1

	--多面板
	if type_d == '野怪' then
		if killer:get_owner().id <= 4 then
			ac.game.multiboard.player_kill_count(killer:get_owner(),data.kill_count[type_d])
		end
		ac.game.multiboard.creep_count(-1)
	end
end)


-- ac.game:event '玩家-注册英雄' (function(_, player, hero)
-- 	print('注册英雄5')
-- 	player.count_data = {
-- 		--记录杀害的单位数量
-- 		kill_count = {},
-- 		--伤害统计
-- 		damage_data = {
-- 			--造成伤害
-- 			damage = 0,
-- 			--吸收伤害
-- 			get = 0,
-- 		},
-- 	}
-- 	local data = player.count_data
-- 	ac.game.multiboard.damage_init(player)
-- 	--数据统计
-- 	hero:event '造成伤害结束' (function(_,damage)
-- 		data.damage_data.damage = data.damage_data.damage + damage.current_damage
-- 	end)
-- end)



init()