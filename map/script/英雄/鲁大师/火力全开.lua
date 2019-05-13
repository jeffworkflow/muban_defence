local mt = ac.skill['火力全开']

mt{
	--必填
	is_skill = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		主动：每 %pulse% 秒对指定区域范围内的敌人投掷炸弹，造成攻击力*1.5+敏捷*1.5的物理伤害( %damage% )，持续时间 %time% 秒
		被动：每次第 %attack_stack% 次普通攻击时，会触发一次扫射，扫射会对范围内的敌人发射导弹，造成 %attack_mul% 倍攻击力的范围伤害( %beidong_damage% )
	]],
	
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNFragmentationBombs.blp]],

	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_POINT,

	--施法范围
	area = 600,

	--持续时间
	time = {5,6,7,8,9},
	--每多少秒
	pulse = 1,

	--被动，第几次攻击触发特殊攻击
	attack_stack = 5,
	-- current_attack_cnt =0,
	--被动，攻击倍数
	attack_mul = {2.5,2.75,3,3.25,3.5},
	--被动，距离1600
	distance = 1600,
	--被动，撞击范围
	hit_area = 250,

	--伤害
	damage = function(self,hero)
		return hero:get('攻击')*1.5 + hero:get('敏捷')*1.5
	end,
	--被动伤害
	beidong_damage = function(self,hero)
		return hero:get('攻击')*self.attack_mul
	end,	

	--cd 40
	cool = 20,

	--耗蓝 60
	cost = {60,200,350,525,750},

	--特效模型
	effect1 = [[Abilities\Weapons\Mortar\MortarMissile.mdl]],
	effect2 = [[E_MissileCluster.mdx]],

	-- effect = [[Hero_Juggernaut_N4S_F_Source.mdx]],

	--施法距离
	range = 1000

	
}
local function on_texttag(self,hero)
	local target = hero
	local x, y = target:get_point():get()
	local z = target:get_point():getZ()
	local tag = ac.texttag
	{
		string = self:get_stack(),
		size = 10,
		position = ac.point(x , y, z + 100),
		speed = 250,
		angle = 90,
		red = 238,
		green = 31,
		blue = 39,
		crit_size = 0,
		life = 1,
		fade = 0.5,
		time = ac.clock(),
	}
	
	if tag then 
		local i = 0
		ac.timer(10, 25, function()
			i = i + 1
			if i < 10 then
				tag.crit_size = tag.crit_size + 1

			else if i < 20 then
					tag.crit_size = tag.crit_size	
				else 
					tag.crit_size = tag.crit_size - 1
				end
			end	
			tag:setText(nil, tag.size + tag.crit_size)
		end)
	end	
end
-- 攻击第5下发射的导弹
local function beidong_damage(self,damage_target)
	local skill = self
	local hero = self.onwer
	-- print(hero,self.owner)
	local mvr = ac.mover.line
	{
		source = self.owner,
		model = self.effect2,
		speed = 1200,
		angle = self.owner:get_point()/damage_target:get_point(),
		distance = self.distance,
		high = 100,
		skill = self,
		size = 3,
		hit_area = self.hit_area,
		hit_type = ac.mover.HIT_TYPE_ENEMY,
		per_moved = 0
	}
	
	if not mvr then
		return
	end
	function mvr:on_hit(dest)
                    
		dest:damage
		{
			source = skill.owner,
			damage = skill.beidong_damage,
			skill = skill,
			missile = skill.mover
		}
		
	end	

end	
function mt:on_add()
	local hero = self.owner 
	local skill = self
	hero.weapon['弹道速度'] = 3500

	self.trg = hero:event '单位-发动攻击'  (function(trg, damage)

		local damage_target = damage.target

		self:add_stack(1)
		on_texttag(self,hero)

		if self:get_stack() >= self.attack_stack then 
			self:set_stack(0)
			beidong_damage(self,damage_target)
		end		
	end)	

end	
function mt:on_cast_shot()
	local skill = self
	local hero = self.owner
	-- hero:add_effect('origin',self.effect)
	local target = self.target
	local target_point = target:get_point()
	local speed = hero:get_point() * target_point  / self.time

	self:set_stack(self.attack_stack - 1 )
	on_texttag(self,hero)

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


end
