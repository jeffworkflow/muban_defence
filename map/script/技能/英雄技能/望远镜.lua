local mt = ac.skill['望远镜']

mt{
	 --必填
	 is_skill = true,
	 --初始等级
	 level = 1,
	 --最大等级
	max_level = 5,
	 --触发几率
	chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
	 --伤害范围
	damage_area = 500,
	 --技能类型
	 skill_type = "被动,攻击距离",
	 --被动
	 passive = true,
	 --属性加成
 ['攻击距离%'] = {20,40,60,80,100},
 ['减少周围护甲'] = {200,400,600,800,1000},
	 --介绍
	 tip = [[
		 
|cffffff00【攻击距离】+20%*Lv|r
|cffffff00【减少周围护甲】+200*Lv|r
	 
]],
	--技能图标
	art = [[jineng\jineng015.blp]],

}

mt.attack_range_now = 0

function mt:on_add()
	local skill = self
	local hero = self.owner 

end	

function mt:on_remove()
	
end
