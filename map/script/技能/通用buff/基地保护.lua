local mt = ac.buff['基地保护']

mt.cover_type = 1
mt.cover_max = 1

mt.ref = 'origin'
mt.model = [[model\common\shield.mdx]]

function mt:on_add()
	-- self.effect = self.target:add_effect(self.ref, self.model)
	-- local x,y = self.target:get_point():get()
	-- local minx,miny,maxx,maxy = x-500,y-500,x+500,y+500
	-- local rect = ac.rect.create(minx,miny,maxx,maxy)
	-- local reg = ac.region.create(rect)
	-- -- print('添加基地保护',minx,miny,maxx,maxy)
	-- self.enter_reg = reg:event '区域-进入'(function(trg,unit,reg)
	-- 	if not unit:is_hero() then 
	-- 		return
	-- 	end
	-- 	print('区域进入')
	-- 	if self.target:find_buff('无敌') then 
	-- 		return
	-- 	end	
	-- 	self.target:add_buff '无敌'{
	-- 		model = self.model
	-- 	}
	-- end)
	
	-- self.leave_reg = reg:event '区域-离开'(function(trg,unit,reg)
	-- 	local hero_tab = ac.selector(): in_range(self.target,500): of_hero():get()
	-- 	print('区域离开')
	-- 	if hero_tab and #hero_tab >= 1 then 
	-- 		print('玩家英雄在区域内大于1个')
	-- 		return
	-- 	end
	-- 	if self.target:find_buff('无敌') then 
	-- 		self.target:remove_buff '无敌'	
	-- 	end	
	-- end)
	-- ac.game:event '单位-死亡'(function(trg,unit,killer)
	-- 	if not unit:is_hero() then 
	-- 		return 
	-- 	end
	-- 	ac.game:event_notify('区域-离开',unit,reg)
		
	-- end)
	-- ac.game:event '单位-复活'(function(trg,unit)
	-- 	if not unit:is_hero() then 
	-- 		return 
	-- 	end
	-- 	ac.game:event_notify('区域-进入',unit,reg)
	-- end)
end

mt.pulse = 0.1
function mt:on_pulse()
	local hero_tab = ac.selector(): in_range(self.target,500): of_hero():get()
	if hero_tab and #hero_tab >= 1 then 
		-- print('玩家英雄在区域内大于1个')
		if not self.target:find_buff('无敌') then 
			self.target:add_buff '无敌'{}	
		end	
	else
		if self.target:find_buff('无敌') then 
			self.target:remove_buff '无敌'	
		end		
	end
end	
function mt:on_remove()
    if self.trg then 
		self.trg:remove()
		self.trg = nil 
	end  
	if self.enter_reg  then
		self.enter_reg:remove()
		self.enter_reg = nil 
	end	
	if self.leave_reg  then
		self.leave_reg:remove()
		self.leave_reg = nil 
	end	
end
