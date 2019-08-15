local mt = ac.skill['凌波微步']
--还是有问题，阻断器还是冲的过去。
mt{
    --等级
    level = 1,
	tip = [[
按D向鼠标方向飘逸500码距离，消耗100蓝，内置CD1S，不可穿越障碍物
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNBlink.blp]],
	cool = 1,
	cost = 1,

	target_type = ac.skill.TARGET_TYPE_POINT,

	--施法动作
    cast_animation = '',
    cast_animation_speed = 1.5,

    --施法前摇后摇
    cast_start_time = 0.0,
	cast_finish_time = 0.0,
	--忽略技能冷却
    ignore_cool_save = true, 

	--施法距离
	range = 99999,
	--移动距离
	blink_range = 500,
	--新目标点
	new_point =nil,
	is_skill = true,
	--是否开启智能施法 0关闭 1开启 2开启并显示施法指示圈
	-- smart_type = 1,
	effect = [[]],

	--技能id
	ability_id = 'AX21',
    --目标数据
	cus_target_data = '按键',
	--图标是否可见 0可见 1隐藏
    -- hide_count = 1,
}


function mt:on_add()
	self:hide()
	local hero = self.owner
	local skill = self
	local i = self.slotid
	if not hero.smart_cast_type then
		hero.smart_cast_type = {}
	end
	hero.smart_cast_type[i] = self.smart_type
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
	if self.new_point:is_block()  then
		return false
	end	
	return true
	
	
end

function mt:on_cast_start()
    local hero = self.owner
	local target = self.target
	local new_point = self.new_point

end

function mt:on_cast_shot()
    local hero = self.owner
	local target = self.target
	local new_point = self.new_point
	local skill = self
	local source_point = hero:get_point()
	--开始跳跃
	local mvr = ac.mover.target
	{
		source = hero,
		target = new_point,
		mover = hero,
		model = skill.effect,
		speed = 2000,
		min_speed = 522,
		skill = skill,
		block = true,
		do_reset_high = true, --还原高度
		--高度
		height = 25,
	}
	if not mvr then
		return
	end
	function mvr:on_move()
		if not hero:has_restriction '缴械' then 
			hero:add_restriction '缴械'
		end	
		if not hero:has_restriction '定身' then 
			hero:add_restriction '定身'
		end	
		local total_distance = new_point *source_point

		-- if  self.moved >= total_distance*0.8 then 
		-- 	-- print(self.speed)
		-- 	self.speed = self.speed /1.5
		-- end	
		-- self.accel 0.03 * 1500  45 500/45 运动11次。 
	end	
	function mvr:on_block()
		if  hero:has_restriction '缴械' then 
			hero:remove_restriction '缴械'
		end	
		if  hero:has_restriction '定身' then 
			hero:remove_restriction '定身'
		end	
		return true
	end	
	function mvr:on_finish()
		if  hero:has_restriction '缴械' then 
			hero:remove_restriction '缴械'
		end	
		if  hero:has_restriction '定身' then 
			hero:remove_restriction '定身'
		end	
	end	
                    
   
end
function mt:on_cast_finish()
	local hero = self.owner
	-- hero:remove_restriction '缴械'
	hero:issue_order('stop')
	
end	


function mt:on_cast_break()


end	


function mt:on_remove()

end






