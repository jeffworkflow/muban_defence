local mt = ac.skill['致命一击']

mt{
	--必填
	is_skill = true,

	--是否被动
	passive = true,
	
	--初始等级
	level = 1,
	
	tip = [[
		|cff00ccff被动|r:
		攻击时有 %physical_rate% % 几率 造成物理暴击，额外%physical_damage% % 暴击加深
	]],
	
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNCriticalStrike.blp]],

	--物爆
	physical_rate = 10,
	physical_damage = 500,


}


function mt:on_add()
	local skill = self
	local hero = self.owner 

	hero:add('暴击几率',self.physical_rate)
	hero:add('暴击加深',self.physical_damage)

end	

function mt:on_remove()

    local hero = self.owner 
	
	hero:add('暴击几率',-self.physical_rate)
	hero:add('暴击加深',-self.physical_damage)

end
