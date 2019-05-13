local mt = ac.skill['法术强化']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "被动",
	--被动
	passive = true,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 法术伤害+%magic_damage% %
	]],
	--技能图标
	art = [[jineng\jineng018.blp]],
	--法术伤害
	magic_damage = {35,50,75,100,125},
}

mt.magic_damage_now = 0

function mt:on_upgrade()
	local hero = self.owner
	-- print(self.life_rate_now)
	hero:add('法术攻击', -self.magic_damage_now)
	self.magic_damage_now = self.magic_damage
	hero:add('法术攻击', self.magic_damage)
end	

function mt:on_add()
    local skill = self
    local hero = self.owner
   
end

function mt:on_remove()
    local hero = self.owner
    hero:add('法术攻击',-self.magic_damage)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
