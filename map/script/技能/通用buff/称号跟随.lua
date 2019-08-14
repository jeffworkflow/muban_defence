local mt = ac.buff['称号跟随']
mt.cover_type = 1 --共享
mt.cover_max = 1  --同时只能有一个生效
mt.model = [[shendi.mdx]]


function mt:on_add()
	-- self.effect = self.target:add_effect(self.ref, self.model)
	if not self.follow then 
		self.follow = self.target:follow{
			source = self.target,
			model = self.model,
			angle_follow = true,
			-- face_follow = true,
			angle = -90,
			distance = 120,
			high = 0,
			skill = false,
		}
	end	
end

function mt:on_remove()
	-- self.effect:remove()
	if self.follow then 
		self.follow:remove()
		self.follow = nil
	end	
end
