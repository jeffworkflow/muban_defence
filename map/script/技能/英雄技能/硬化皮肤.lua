local mt = ac.skill['硬化皮肤']

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
		护甲加 %defence% %
		]],
	
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNResistantSkin.blp]],

	--护甲
	defence = {35,50,75,100,150},

}

mt.defence_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('护甲%', -self.defence_now)
	self.defence_now = self.defence
	hero:add('护甲%', self.defence)
end	


function mt:on_add()
	local skill = self
	local hero = self.owner 

end	

function mt:on_remove()

    local hero = self.owner 
	hero:add('护甲%',-self.defence)

	

end
