local mt = ac.buff['预警圈']

mt.cover_type = 1
mt.cover_max = 1

mt.ref = 'origin'
mt.model = [[mr.war3_ring.mdx]]

function mt:on_add()
	self.effect = self.target:add_effect(self.ref, self.model)
end

function mt:on_pulse()
    
    -- if not self.is_not_danhua and self:get_remaining() < 1 then 
    --     self.effect:add_buff '淡化'{
    --         time = 1,
    --     }
    --     self.is_not_danhua = true
    -- end    
end    
function mt:on_remove()
    if self.effect then 
        self.effect:remove()
    end     
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end