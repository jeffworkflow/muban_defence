local mt = ac.buff['攻击英雄']
mt.cover_type = 1 --共享
mt.cover_max = 1  --同时只能有一个生效
mt.pulse = 3


function mt:on_add()
	-- self.effect = self.target:add_effect(self.ref, self.model)
end
function mt:on_pulse()
	local unit = self.target
	ac.attack_hero(unit)
end	

function mt:on_remove()
	-- self.effect:remove()
end
local function attack_hero(unit)
	if not unit then 
		print('没有传递unit进来') 
		return 
	end

	local point = ac.map.rects['主城']:get_point()
	if unit:is_alive() then 
		if unit.last_point then 
			local distance =  unit.last_point * unit:get_point()
			local hero = ac.find_hero(unit)
			local hero_distance = 0
			if hero then 
				hero_distance = hero:get_point() * unit:get_point()
			end    
			if hero_distance <= 10 then
				--1500码内，优先攻击英雄，英雄死亡则攻向基地点
				unit:issue_order('attack',point)
			elseif hero_distance <= 1500  then
				unit:issue_order('attack',hero)
			else
				unit:issue_order('attack',point)
			end   
			local main_unit = ac.main_unit
			if main_unit then 
				local main_distance = ac.main_unit:get_point() * unit:get_point()
				if main_distance >= 2500 and unit:get('攻击距离')<2500 then  
					unit:issue_order('attack',ac.main_unit) 
				end	
			end	

		end  
		unit.last_point = unit:get_point()
	end   
end

ac.attack_hero = attack_hero
