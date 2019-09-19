local mt = ac.skill['火力支援']

mt{
	--必填
	is_skill = true,
	--初始等级
	level = 1,
	max_level = 5,
	damage = function(self)
		return (self.owner:get('敏捷')*15+10000)* self.level*5
	  end,
	  ['每秒加敏捷'] = {50,100,150,200,250},
	  ['攻击加敏捷'] = {50,100,150,200,250},
	  ['杀怪加敏捷'] = {50,100,150,200,250},
	tip = [[

|cffffff00【每秒加敏捷】+50*Lv
【攻击加敏捷】+50*Lv
【杀怪加敏捷】+50*Lv|r

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(敏捷*15+1w)*Lv*5|r

	]],
    art = [[kzzy.blp]],
	--技能类型
	skill_type = "主动,敏捷",
	--冷却时间
    cool = 15,
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--特效模型
	effect1 = [[Abilities\Weapons\Mortar\MortarMissile.mdl]],
	damage_type = '法术',
	range = 1000,
	--施法范围
	area = 600,
	--持续时间
	time = 5,
	--每多少秒
	pulse = 1,
}

local function start_damage(self,target)
	local skill = self
	local hero = self.owner
	-- hero:add_effect('origin',self.effect)
	local target = target or self.target
	local target_point = target:get_point()
	local speed = hero:get_point() * target_point  / self.time

	--预警圈处理
	local mvr = ac.mover.line
	{
		source = hero,
		target = target_point,
		speed = speed,
		skill = skill,
		high = 20,
		model = [[mr.war3_ring.mdx]], --一个预警圈大概是200码
		size = self.area/200 --一个预警圈大概是200码
	}

	self.yjq_dummy = mvr.mover

	--选中目标区域的单位，落下导弹
	self.trg1 = hero:timer(self.pulse * 1000, self.time/self.pulse, function()
		-- print('打印预警圈单位位置：',self.yjq_dummy:get_point())
		for i,u in ac.selector()
		: in_range(self.yjq_dummy,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
		do
			-- local angle = math.random(1, 360) --self.area
			local angle =  hero:get_point()/ u:get_point() 
			local s = u:get_point() - {angle + math.random(-90,90) , math.random(300, self.area)}
			local mover = hero:create_dummy('nabc',s, 0)
			--落下导弹
			local mvr = ac.mover.target
			{
				source = hero,
				start = s,
				target = u,
				mover = mover,
				-- angle = angle,
				speed = 600,
				turn_speed =720,
				high = 1500,
				-- height = 1500, --子弹头才会转向
				skill = skill,
				model = skill.effect1,
				size = 1.3
			}
			if mvr then
				function mvr:on_move()
					if self.high <= self.target:get_high() then
						-- self.mover:get_point():add_effect(skill.boom_model):remove()
						self.mover:remove()
						self:remove()
					end
				end 
				function mvr:on_finish()
					-- print('导弹撞到人了',self.high,self.target:get_high())
					self.target:damage
					{
						source = hero,
						damage = skill.damage,
						skill = skill,
						missile = self.mover
					}
				end	
			end    

		end	
	end)


end	

function mt:on_cast_shot()
	start_damage(self)
end

function mt:on_remove()
    local hero = self.owner 
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
    end    

end
