local mt = ac.skill['刀刃旋风']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 敏捷",
	--耗蓝
	cost = {20,130,240,350,460},
	--冷却时间 15
	cool = 5,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 800,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 召唤刀刃对范围800码的敌方单位造成物理伤害
	伤害计算：|cffd10c44敏捷 * %int%|r+ |cffd10c44 %shanghai% |r
	伤害类型：|cff04be12物理伤害|r

	%strong_skill_tip%
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNFanOfKnives.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\FanOfKnives\FanOfKnivesMissile.mdl]],
	--伤害参数1
	int = {20,25,30,35,40},

	shanghai ={20000,200000,2000000,5000000,8000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('敏捷')*self.int+self.shanghai
		end
	end	,
	damage_type = '物理',
	strong_skill_tip ='（可食用|cffffff00恶魔果实|r进行强化）',
	casting_cnt = 1
}
function mt:strong_skill_func()
	local hero = self.owner 
	local player = hero:get_owner()
	-- 增强 卜算子 技能 1个变为多个 --商城 或是 技能进阶可得。
	if (hero.strong_skill and hero.strong_skill[self.name]) then 
		self:set('casting_cnt',5)
		self:set('strong_skill_tip','|cffffff00已强化：|r|cff00ff00额外触发4次刀刃旋风，造成等值伤害|r')
		-- print(2222222222222222222)
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
	local function start_damage()
		local angle_base = 0
		local num = 3
		for i = 1, num do
			local mvr = ac.mover.line
			{
				source = hero,
				skill = skill,
				start = hero:get_point(),
				model =  skill.effect,
				speed = 800,
				angle = angle_base + 360/num * i,
				distance = skill.area  ,
				size = 2,
				height = 120
			}
			if not mvr then
				return
			end
		end	

		for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
		do
			u:damage
			{
				source = hero,
				damage = skill.damage ,
				skill = skill,
				damage_type =skill.damage_type
			}	
		end 
	end	 
	--先释放一次，再释放4次
	start_damage()
	if self.casting_cnt >1 then 
		hero:timer(0.3*1000,self.casting_cnt-1,function(t)
			start_damage()
		end)
	end	
end	


function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
