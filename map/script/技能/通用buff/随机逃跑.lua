local mt = ac.buff['随机逃跑']

mt.cover_type = 0

mt.ref = 'origin'
mt.model = [[model\common\shield.mdx]]

function mt:on_add()
	self:on_pulse()
end

mt.pulse = 2
function mt:on_pulse()
	if not ac.find_hero then 
		print('没有寻找最近英雄函数，随机逃跑终止')
		return
	end	
	local unit = self.target
    --逃跑路线
    local hero = ac.find_hero(unit)
    local angle
    if hero then  
        angle= hero:get_point()/unit:get_point()
    else 
        angle =math.random(0,360)
    end    
    --优化钥匙怪跑路角度
    angle = angle - math.random(0,360)
    local target_point = unit:get_point() - {angle,800}
    unit:issue_order('move',target_point)
end	
function mt:on_remove()
end
