local mt = ac.skill['光明契约']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 智力",
	--耗蓝
	cost = function(self,hero)
		return hero:get('魔法')
	end	,
	--冷却时间
	cool = 20,
	--伤害
	int_mul = {25,30,35,40,50},

	shanghai ={25000,250000,2500000,6250000,10000000},

	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 500,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 耗尽魔法，对敌人造成法术伤害，如果杀死敌人，将永久提高 %addint% %智力
伤害计算：|cffd10c44智力 * %int_mul%|r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12法术伤害|r]],
	--技能图标 LNXQ
	art = [[jineng\jineng026.blp]],
	--永久智力
	addint = {1,2,3,4,5},
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('智力')*self.int_mul+self.shanghai
		end	
	end	,
	damage_type = '法术'
}
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	-- print(target,target.data.type)

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
		-- hero:add('智力',math.ceil(hero:get('智力')*self.addint/100))
		hero:add('智力%',self.addint)
	end	
end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end

