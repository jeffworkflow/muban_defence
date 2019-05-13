local mt = ac.skill['黑暗契约']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 敏捷",
	--冷却时间
	cool = {40,35,30,25,20},

	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 500,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 损失50%当前生命值， 对指定敌人造成物理伤害，如果杀死敌人，英雄将永久提高 %addagi% %的敏捷
	伤害计算：|cffd10c44敏捷 * %int%|r+ |cffd10c44 %shanghai% |r
	伤害类型：|cff04be12物理伤害|r
]],	

	int = {25,30,35,40,50},

	shanghai ={25000,250000,2500000,6250000,10000000},
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDeathPact.blp]],
	--永久智力
	addagi = {1,2,3,4,5},
	--消耗生命
	cost_life = 50,
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('敏捷')*self.int+self.shanghai
		end
	end	,
	damage_type = '物理'
}
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	-- print(target,target.data.type)
	hero:add('生命',-hero:get('生命')*self.cost_life/100)

	local ln = ac.lightning('LN00',hero,target,50,50)
	ln:fade(-5)
	
	target:damage
	{
		source = hero,
		damage = self.damage,
		skill = self,
		damage_type =self.damage_type
	}

	if not target:is_alive() then 
		hero:add('敏捷%',self.addagi)
	end	
end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end


