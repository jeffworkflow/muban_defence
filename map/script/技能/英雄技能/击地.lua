local mt = ac.skill['击地']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,

	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = {30,140,250,360,470},
	--冷却时间 20 
	cool = 10,
	--伤害
	attack_mul = {12.5,15,17.5,20,25},

	shanghai ={25000,250000,2500000,6250000,10000000},

	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 600,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 对范围600码的敌人造成移动力减少 50% 和攻击速度减少 25% ，持续3秒，并造成伤害
伤害计算：|cffd10c44攻击力 * %attack_mul%|r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r

%strong_skill_tip%]],
	--技能图标
	art = [[jineng\jineng008.blp]],
	--特效
	effect = [[Abilities\Spells\Human\ThunderClap\ThunderclapCaster.mdx]],
	--特效1
	effect1 = [[Abilities\Spells\Human\ThunderClap\ThunderclapTarget.mdx]],
	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('攻击') * self.attack_mul+self.shanghai
		end
	end,

	--移动速度
	move_speed = 50 ,
	--攻击速度
	attack_speed = 25 ,
	--持续时间
	time = 3 ,
	strong_skill_tip ='（可食用|cffffff00恶魔果实|r进行强化）',
	casting_cnt = 1

}
function mt:strong_skill_func()
	local hero = self.owner 
	local player = hero:get_owner()
	-- 增强 卜算子 技能 1个变为多个 --商城 或是 技能进阶可得。
	if (hero.strong_skill and hero.strong_skill[self.name]) then 
		self:set('casting_cnt',5)
		self:set('strong_skill_tip','|cffffff00已强化：|r|cff00ff00额外触发4次击地，造成等值伤害|r')
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

	local function start_damage()
		local point = hero:get_point()
		local effect = ac.effect(point,self.effect,0,2,'origin'):remove()
		for i, u in ac.selector()
			: in_range(hero,self.area)
			: is_enemy(hero)
			: of_not_building()
			: ipairs()
		do
			u:add_buff '击地'
			{
				time = self.time,
				skill = self,
				source = hero,
				model = self.effect1,
				attack_speed = self.attack_speed,
				move_speed = self.move_speed,
			}
			u:damage
			{
				skill = self,
				source = hero,
				damage = self.damage,
				damage_type = '物理'
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

local mt = ac.buff['击地']

mt.cover_type = 1

mt.model = nil
mt.ref = 'overhead'
mt.debuff = true

function mt:on_add()
	
	local hero = self.target
	hero:add('移动速度%',-self.move_speed)
	hero:add('攻击速度',-self.attack_speed)
	if self.model then
		self.eff = self.target:add_effect(self.ref, self.model)
	end
end

function mt:on_remove()
	
	local hero = self.target
	hero:add('移动速度%',self.move_speed)
	hero:add('攻击速度',self.attack_speed)

	if self.eff then
		self.eff:remove()
	end
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end


