local mt = ac.skill['死吻']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,

	-- 被动1：周围 %passive_area% 码有敌人死亡，刷新所有技能的冷却时间

	tip = [[
		主动：召唤%casting_cnt%次刀刃对范围800码的敌方单位攻击，造成的物理伤害
		被动：攻击对敌人造成护甲 -%reduce_defence% %
		伤害计算：|cffd10c44敏捷 * %int% |r + |cffd10c44 %shanghai% |r
		伤害类型：|cff04be12物理伤害|r
		]],

	
	--技能图标
	art = [[jineng\jineng005.blp]],

	--伤害参数1
	int = {25,30,35,40,50},

	shanghai ={25000,250000,2500000,6250000,10000000},

	--伤害
	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('敏捷')*self.int+self.shanghai
		end
	end	,
	damage_type = '物理',

	--施法引导时间 （闪烁过去）
	-- cast_channel_time = 0.2,

	--技能目标类型 单位目标
	target_type = ac.skill.TARGET_TYPE_NONE,

	--攻击
	-- attack_mul = {3,4,5,6,7},

	--cd 25
	cool = 10,

	--耗蓝
	cost = {10,25,50,100,200},

	--护甲持续时间
	reduce_defence_time = 5,

	--特效模型
	effect = [[Abilities\Spells\Orc\Bloodlust\BloodlustTarget.mdl]],
	--特效2
	effect1 = [[Abilities\Spells\NightElf\FanOfKnives\FanOfKnivesMissile.mdl]],
	--施法范围
	area = 800,

	-- 周围范围
	passive_area = 600,
	-- 攻击减护甲
	reduce_defence = 20,
	-- 主动技能施法次数
	casting_cnt = 1,
	--施法距离
	-- range = 1200,
}

function mt:strong_skill_func()
	local hero = self.owner 
	local player = hero:get_owner()
	-- 增强 卜算子 技能 1个变为多个 --商城 或是 技能进阶可得。
	if (hero.strong_skill and hero.strong_skill[self.name]) then 
		self:set('casting_cnt',5)
		-- print(2222222222222222222)
	end	
end	

function mt:on_upgrade()
    local skill = self
	local hero = self.owner 
end	
function mt:on_add()
    local skill = self
	local hero = self.owner 

	self:strong_skill_func()

	self.trg1 = hero:add_buff '死吻-被动1' 
	{
		source = hero,
		skill = self,
		passive_area = self.passive_area,
		pulse = 0.02, --立即生效
		real_pulse = 0.1  --实际每几秒检测一次
	}

	self.trg2 = hero:event '造成伤害效果' (function(trg, damage)
		local target = damage.target
		target:add_buff '死吻-被动2' 
		{
			source = hero,
			skill = self,
			reduce_defence = self.reduce_defence,
			time = self.reduce_defence_time,
		}
	end)
	
end	
-- function mt:on_cast_channel()
-- 	local hero = self.owner
-- 	local target = self.target
-- 	self.eff = self.target:add_effect('chest',self.effect)
-- 	hero:add('攻击%',self.attack_mul*100)
-- 	hero:blink(target:get_point())
	

-- end	
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
				model =  skill.effect1,
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


	-- for i=1,self.casting_cnt do
	-- 	--每0.3秒释放一次
	-- end	


	-- hero:add_effect('origin',self.effect)
	-- self.eff = self.target:add_effect('chest',self.effect)


	-- self.trg = hero:add_buff '死吻' 
	-- {
	-- 	source = hero,
	-- 	skill = self,
	-- 	attack_mul = self.attack_mul,
	-- 	time = self.time
	-- }

	
end

function mt:on_remove()

    local hero = self.owner 
	
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end   
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
    end    
    if self.trg2 then
        self.trg2:remove()
        self.trg2 = nil
    end    
    if self.eff then
        self.eff:remove()
        self.eff = nil
    end     
  

end

-- local mt = ac.buff['死吻']
-- mt.cover_type = 1
-- mt.cover_max = 1

-- function mt:on_add()
--     self.eff = self.target:add_effect('chest',self.effect)
-- 	self.target:add('攻击%', self.attack_mul*100)
-- end

-- function mt:on_remove()
--     if self.eff then 
--         self.eff:remove()
--         self.eff = nil
--     end    
-- 	self.target:add('攻击%', - self.attack_mul*100)
    
-- end

-- function mt:on_cover(new)
-- 	if new.time > self:get_remaining() then
-- 		self:set_remaining(new.time)
-- 	end
-- 	return false
-- end




local mt = ac.buff['死吻-被动1']

mt.cover_type = 1
mt.keep = true

function mt:on_add()
	local hero = self.target
	self.unit_mark = {}
end

function mt:on_pulse()
	local hero = self.target
	self.pulse = self.real_pulse
	self.cnt = 0

	for i, u in ac.selector()
		: in_range(hero,self.passive_area)
		: of_not_building()
		: is_enemy(hero)
		: allow_dead()
		: ipairs()
	do
		if not u:is_alive() and not self.unit_mark[u] then 
			self.unit_mark[u] = true
			self.cnt = self.cnt + 1
		end
	end	
	if self.cnt > 0  then 
		--刷新技能
		-- for skl in hero:each_skill() do
		-- 	local skl_name = skl:get_name()
		-- 	if skl:get_type() == '英雄' and skl_name ~= '妙手空空' and skl_name ~= '摔破罐子' then
		-- 		-- print('即将刷新技能',skl:get_name())
		-- 		skl:set_cd(0)
		-- 		-- skl:fresh()
		-- 	end	
		-- end	

	end
	-- print('周围单位个数：'..self.skill.cnt,hero:get('攻击%'))
end

function mt:on_remove()
    
end


local mt = ac.buff['死吻-被动2']
mt.cover_type = 1
mt.cover_max = 1

function mt:on_add()
	-- self.eff = self.target:add_effect('origin',self.effect)
	-- print('减护甲',self.target)
	self.target:add('护甲%', - self.reduce_defence)
end

function mt:on_remove()
    -- if self.eff then 
    --     self.eff:remove()
    --     self.eff = nil
    -- end    
	self.target:add('护甲%',  self.reduce_defence)
    
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
