local mt = ac.skill['闪烁']

mt{
    --等级
    level = 1,
	tip = [[
闪烁,cd%cool%s.
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNBlink.blp]],
	cool = 5,

	target_type = ac.skill.TARGET_TYPE_POINT,

	--施法动作
    cast_animation = 'spell',
    cast_animation_speed = 1.5,

    --施法前摇后摇
    cast_start_time = 0.15,
    cast_finish_time = 0.15,

	--施法距离
	range = 99999,
	--移动距离
	blink_range = 1000,
	--新目标点
	new_point =nil,
	is_skill = true

}


function mt:on_add()
	
	local hero = self.owner
	local skill = self
	print('添加闪烁技能')
end

function mt:on_can_cast()
    local hero = self.owner:get_point()
	local target = self.target:get_point()
	           
	local angle = hero/target  --计算两点之间角度
	-- print(angle)
	
	local distance = target*hero  --计算两点之间的距离
	-- print(distance)
	self.new_point = target
	if distance >= self.blink_range then
		local data = {}
		data[1]=angle
		data[2]=self.blink_range
		self.new_point = hero - data  --计算新点
	end	
	-- print(new_point,target) 
	self.new_point =  self.new_point:findMoveablePoint(300,angle) or self.new_point --附近寻找一个可通行的点。
	-- print(self.new_point,self.new_point:is_block())
	if ac.map.rects['刷怪']  < self.new_point  then
		return true
	else
		return false
	end
	
end

function mt:on_cast_start()
    local hero = self.owner
	local target = self.target
	local new_point = self.new_point

	self.eff = ac.effect(hero:get_point(),[[AZ_SSCrow_D.mdx]],0,1,'overhead'):remove();
	self.eff1 = ac.effect(new_point,[[AZ_SSCrow_D.mdx]],0,1,'overhead'):remove(); 

	hero:add_buff '淡化*改'
	{
		source_alpha = 100,
		target_alpha = 0,
		time = self.cast_start_time,
		remove_when_hit = false,
		
	}
end

function mt:on_cast_shot()
    local hero = self.owner
	local target = self.target
	local new_point = self.new_point
	hero:blink(new_point)
   
end
function mt:on_cast_finish()
	local hero = self.owner
	hero:add_buff '淡化*改'
	{
		source_alpha = 0,
		target_alpha = 100,
		time = self.cast_finish_time,
		remove_when_hit = false,
	}
end	


function mt:on_cast_break()
	local hero = self.owner
	hero:add_buff '淡化*改'
	{
		source_alpha = 0,
		target_alpha = 100,
		time = self.cast_finish_time,
		remove_when_hit = false,
	}

end	


function mt:on_remove()

end






