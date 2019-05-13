local mt = ac.skill['暴击']

mt{
	--必填
	is_skill = true,

	--技能类型
	skill_type = "被动",

	--是否被动
	passive = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		|cff00ccff被动|r:
		物爆几率+%physical_rate% % ，物爆伤害+%physical_damage% % 
		会心几率+%physical_rate% % ，会心伤害+%physical_damage% %
		法爆几率+%physical_rate% % ，法爆伤害+%physical_damage% %]],
	
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNCriticalStrike.blp]],

	--物爆
	physical_rate = {2,4,6,8,10},
	physical_damage = {100,200,300,400,500},
	--会爆
	heart_rate = {2,4,6,8,10},
	heart_damage = {100,200,300,400,500},
	--法爆
	magic_rate = {2,4,6,8,10},
	magic_damage = {100,200,300,400,500},


}
mt.physical_rate_now = 0
mt.physical_damage_now = 0
mt.heart_rate_now = 0
mt.heart_damage_now = 0
mt.magic_rate_now = 0
mt.magic_damage_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('物爆几率', -self.physical_rate_now)
	self.physical_rate_now = self.physical_rate
	hero:add('物爆几率', self.physical_rate)

	hero:add('物爆伤害', -self.physical_damage_now)
	self.physical_damage_now = self.physical_damage
	hero:add('物爆伤害', self.physical_damage)

	hero:add('会心几率', -self.heart_rate_now)
	self.heart_rate_now = self.heart_rate
	hero:add('会心几率', self.heart_rate)

	hero:add('会心伤害', -self.heart_damage_now)
	self.heart_damage_now = self.heart_damage
	hero:add('会心伤害', self.heart_damage)

	hero:add('法爆几率', -self.magic_rate_now)
	self.magic_rate_now = self.magic_rate
	hero:add('法爆几率', self.magic_rate)

	hero:add('法爆伤害', -self.magic_damage_now)
	self.magic_damage_now = self.magic_damage
	hero:add('法爆伤害', self.magic_damage)
end


function mt:on_add()
	local skill = self
	local hero = self.owner 

end	

function mt:on_remove()

    local hero = self.owner 
	
	hero:add('物爆几率',-self.physical_rate)
	hero:add('物爆伤害',-self.physical_damage)
	hero:add('会心几率',-self.heart_rate)
	hero:add('会心伤害',-self.heart_damage)
	hero:add('法爆几率',-self.magic_rate)
	hero:add('法爆伤害',-self.magic_damage)

end
