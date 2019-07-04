local mt = ac.skill['暴击']

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
	skill_type = "被动,暴击",
	--被动
	passive = true,
	--属性加成
	['暴击几率'] = {5,10,15,20,25},
	['暴击加深'] = {50,100,150,200,250},
	--介绍
	tip = [[
		
|cffffff00【暴击几率】+5%*Lv
【暴击加深】+50%*Lv|r
	
]],
	--技能图标
	art = [[baoji.blp]],

}

function mt:on_add()
	local skill = self
	local hero = self.owner 

end	
function mt:on_remove()


end
