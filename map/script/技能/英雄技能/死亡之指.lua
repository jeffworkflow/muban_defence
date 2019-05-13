local mt = ac.skill['死亡之指']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 智力",
	--耗蓝
	cost = {10,100,200,400,500},
	--冷却时间
	cool = 10,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 对指定敌人造成法术伤害，该技能如果杀死敌人，将刷新冷却
	伤害计算：|cffd10c44 智力 * %int% + |cffd10c44 %shanghai% |r
	伤害类型：|cff04be12法术伤害|r

	%strong_skill_tip%
	]],
	--技能图标
	art = [[jineng\jineng003.blp]],

	int = {25,30,35,40,50},

	shanghai ={25000,250000,2500000,6250000,10000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('智力')*self.int+self.shanghai
		end	
	end,
	--伤害类型
	damage_type = '法术',
	strong_skill_tip ='（可食用|cffffff00恶魔果实|r进行强化）',

}
function mt:strong_skill_func()
	local hero = self.owner 
	local player = hero:get_owner()
	-- 增强  技能 1个变为多个 
	if (hero.strong_skill and hero.strong_skill[self.name]) then 
		self:set('target_type',ac.skill.TARGET_TYPE_POINT)
		self:set('area',400)
		self:set('range',1100)
		self:set('strong_skill_tip','|cffffff00已强化：|r|cff00ff00400可同时对指定区域内的敌人造成伤害|r')
		
	end	
end	
function mt:on_add()
    local skill = self
    local hero = self.owner
	self:strong_skill_func()
end
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target

	local function start_damage(target)
		local ln = ac.lightning('TWLN',hero,target,50,50)
		ln:fade(-5)
		
		target:damage
		{
			source = hero,
			damage = self.damage,
			skill = self,
			damage_type =self.damage_type
		}
		if not target:is_alive() then 
			self:set_cd(0)
			-- self:fresh()
		end	
	end	

	if target.type == 'point' then 
		for _, u in ac.selector()
		: in_range(target, self.area)
		: is_enemy(hero)
		: ipairs()
		do
			start_damage(u)
		end
		
	else	
		start_damage(target)
	end	
end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
