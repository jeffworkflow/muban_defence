
local player_hero_tm_list = {}
--免费复活次数
local tm = 3

ac.game:event '玩家-注册英雄' (function(_, player, hero)
	if not player_hero_tm_list[player] then
		player_hero_tm_list[player] = tm
	end
	--多面板
	ac.game.multiboard.player_init(player,hero)

	hero:event '单位-死亡' (function()
	
		--复活时间
		local time = 1
		ac.timer_ex
		{
			time = time,
			title = '英雄复活: ',
			player = hero:get_owner(),
		}
		ac.timer(time*1000,1,function()
			hero:revive(ac.point(-740,-1100))
		end)
	end)

	
	hero:event '单位-英雄升级' (function(_,hero)
		
		local data = ac.table.UnitData[hero:get_name()]
		if data == nil then 
			return 
		end 
		if data.upgrade == nil then 
			return 
		end 

		--添加属性
		for k, v in pairs(data.upgrade) do

			if finds(k,'力量','敏捷','智力')then

				local base_formula
				local lv_formula
				local regular_formula
				local index =1 
				for name in v:gmatch '%S+' do
					if index == 2 then  
						base_formula = name 
					end	
					if index == 3 then  
						lv_formula = name 
					end	
					if index == 4 then  
						regular_formula = name 
					end	
					index =index +1
				end	
				
				--(上一级力量基础值+0)*1.08+0
				--base 0 1.08 0
				-- 每级增加的三围属性和上一级有关
				
				local function get_attr_by_lv (attr,lv)
					
					if lv > 1 then 
						return ( get_attr_by_lv(attr,lv-1) + base_formula ) * lv_formula + regular_formula
					else 
						return data.attribute[attr]	 
					end	 
				end	
				
				local lv = hero.level 
				local value = get_attr_by_lv(k,lv) - get_attr_by_lv(k,lv-1)
				-- print('打印人物升级增加的属性',lv,k,value)
				hero:add(k,value)
			end	
		end
		
		--hero:add('冷却缩减', 1.5)

		

	end)
end)

