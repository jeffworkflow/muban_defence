local mt = ac.buff['时停']

mt.cover_type = 0
-- mt.cover_max = 1

-- mt.control = 10
mt.debuff = true
mt.model = [[]]

local function on_texttag(time,hero,xoffset,zoffset)
	local target = hero
	local x, y = target:get_point():get()
	local z = target:get_point():getZ()
	local tag = ac.texttag
	{
		string = tostring(time),
		size = 10,
		position = ac.point(x + (xoffset or 0) , y, z + (zoffset or 100)),
		speed = 250,
		angle = 90,
		red = 238,
		green = 31,
		blue = 39,
		crit_size = 0,
		life = 1,
		fade = 0.5,
		time = ac.clock(),
	}
	
	if tag then 
		local i = 0
		ac.timer(10, 25, function()
			i = i + 1
			if i < 10 then
				tag.crit_size = tag.crit_size + 1

			else if i < 20 then
					tag.crit_size = tag.crit_size	
				else 
					tag.crit_size = tag.crit_size - 1
				end
			end	
			tag:setText(nil, tag.size + tag.crit_size)
		end)
	end	
end
ac.on_texttag_time = on_texttag
function mt:on_add()
	if not self.eff and self.model then
		self.eff = self.target:add_effect('overhead', self.model)
	end
	self.target:add_restriction '时停'
	self.target:cast_stop()
	local time = self.time or 999999
	--移除特效
	-- self.wait1 = ac.wait(self.time * 1000,function()
	-- 	if self.eff then
	-- 		self.eff:remove()
	-- 		self.eff = nil
	-- 	end
	-- 	self.target:remove_restriction '时停'
	-- 	self:remove()
	-- end)
	-- 是否文字显示计时
	if self.show then
		on_texttag(time..(self.text or ''),self.target,self.xoffset,self.zoffset)
	end	
	if self.is_god then 
		self.target:add_restriction '无敌'
	end	
	self.timer1 = ac.timer(1*1000, math.ceil(time),function()
		time = time - 1
		if self.show then
			on_texttag(time..(self.text or ''),self.target,self.xoffset,self.zoffset)
		end	
		self:set_time(time)
		if self.on_timer then 
			self:on_timer(time)
		end	
		if time <=0 then 
			if self.on_finish then 
				self:on_finish()
			end	
					
			if self.eff then
				self.eff:remove()
				self.eff = nil
			end
			self.target:remove_restriction '时停'
			if self.target:has_restriction '无敌' then 
				self.target:remove_restriction '无敌'
			end	
			self:remove()
		end	
	end);
	-- function timer:on_timeout()
	-- 	self.target:remove_restriction '时停'
	-- end
   
end
-- 如果有时停buff,那么buff本身自己的计时也会被暂停，时间到了才移除。
function mt:on_remove()
	-- print('时停buff 被移除')
	if self.eff then
		self.eff:remove()
		self.eff = nil
	end
	if self.target and self.target:has_restriction('时停') then self.target:remove_restriction '时停' end
	if self.timer1 then self.timer1:remove()  end
	if self.wait1 then self.wait1:remove()  end
	
end	