local mt = ac.skill['望远镜']

mt{
	--必填
	is_skill = true,

	--是否被动
	passive = true,
	--技能类型
	skill_type = "被动",
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		|cff00ccff被动|r:
		攻击距离加 %attack_range% %
		]],
	attack_range = {20,40,60,80,100},
	--技能图标
	art = [[item\jineng015.blp]],

}

mt.attack_range_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('攻击距离%', -self.attack_range_now)
	self.attack_range_now = self.attack_range
	hero:add('攻击距离%', self.attack_range)
end	

function mt:on_add()
	local skill = self
	local hero = self.owner 

end	

function mt:on_remove()

    local hero = self.owner 
	hero:add('攻击距离%',-self.attack_range)

	

end
