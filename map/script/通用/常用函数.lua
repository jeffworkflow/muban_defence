--获取区域内随机单位
ac.get_random_unit = function(loc,unit,range)
	local target
	local group = {}
	for _,u in ac.selector()
		: in_range(loc,range)
		: is_enemy(unit)
		: ipairs()
	do
		table.insert(group,u)
	end
	if #group > 0 then
		target = group[math.random(1,#group)]
	end

	return target
end

--创建通用警示圈
local ring_model = [[F2_model\warming_ring_red.mdl]]
local rect_model = [[F2_model\warming_rect.mdl]]
ac.warning_effect_ring = function(data)
	local point = data.point
	local size = data.area/200
	local time = data.time
	-- print(size)
	--角度
	if data.angle then
		local rotate = {0,0,data.angle} or nil
	end
	local effect = ac.effect_ex
	{
		rotate = rotate,
		point = point,
		model = ring_model,
		size = size,
		speed = 1/time,
	}

	if time then
		ac.timer(time*1000,1,function()
			if effect then
				effect:remove()
			end
		end)
	end

	return effect
end

ac.warning_lightning = function(data)
	local hero = data.hero
	local target = data.target
	local time = data.time
	local lt = ac.lightning('FFAA',hero,target,50,50)
	lt:setColor(100,0,0)
	
	if time then
		hero:wait(time* 1000,function()
			if lt then
				lt.speed = -10
				lt:remove()
			end
		end)
	end
	return lt
end