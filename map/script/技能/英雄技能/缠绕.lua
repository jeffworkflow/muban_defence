local mt = ac.skill['缠绕']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 智力 控制",
	--耗蓝
	cost = {30,150,270,400,500},
	--冷却时间
	cool = 10,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
	--施法范围
	area = 300,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 用树藤缠住目标区域敌人的脚，造成敌人不能行动1S，并造成的法术伤害
	伤害计算：|cffd10c44攻击力 * %int% |r + |cffd10c44 %shanghai% |r
	伤害类型：|cff04be12法术伤害|r
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNEntanglingRoots.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
	--持续时间
	time = 1 ,
	int = {12.5,15,17.5,20,25},
	shanghai ={25000,250000,2500000,6250000,10000000},
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('攻击') * self.int+self.shanghai
		end
	end
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()
    local skill = self
    local hero = self.owner

	local target = self.target

	for i, u in ac.selector()
		: in_range(target,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:add_buff '定身'
		{
			time = self.time,
			skill = self,
			source = hero,
			model = self.effect,
		}
		u:damage
		{
			skill = self,
			source = hero,
			damage = self.damage,
			damage_type = '法术'
		}
	end	
	
end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
