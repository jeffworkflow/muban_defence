

for key in pairs(ac.unit.attribute) do 
	for i=1,2 do 
		local tran_key = key
		if i == 2 then 
			tran_key = key..'%'
		end	 
		local mt = ac.buff['属性_'..tran_key]
		mt.control = 2
		mt.cover_type = 1
		mt.cover_max = 1
		mt.ref = 'origin'
		mt.model = [[]]
		mt.value = 0

		function mt:on_add()
			self.effect = self.target:add_effect(self.ref, self.model)
			self.target:add(tran_key,self.value)
		end

		function mt:on_remove()
			self.effect:remove()
			self.target:add(tran_key,-self.value)
		end

		function mt:on_cover(new)
			return new.value > self.value
		end
	end	
end

--测试 
-- ac.wait(20*1000,function()
-- 	ac.player(1).hero:add_buff '属性_攻击减甲' {
-- 		value = 100,
-- 		time =100
-- 	}
-- end)