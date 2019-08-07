local mt = ac.skill['强化后的X射线']

mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
	tip = [[
		主动：在英雄朝向每 %pulse_time% 秒，发射一波X射线，每条造成攻击力*2+智力*5的法术伤害 (%damage%) ；
		被动：睿智，智力 + %int% %
	]],
	--技能图标 3（40°扇形分三条，角度20%）+3+3+1+1，一共5波，
    art = [[jineng\jineng032.blp]],
	--技能类型
	skill_type = "被动,敏捷",
	--被动
	passive = true,
	--冷却时间
    cool = 20,
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--持续时间
	pulse_time = 0.4,
	--冷却时间
	cool = 1,
	--角度
	angle = 20,
	--每次最大数量
	count = 3,
	--伤害
	damage = function(self,hero)
		return hero:get('攻击')*2 + hero:get('智力')*5
	end,	
	--耗蓝
	cost = 100,
	effect = [[gx.mdx]],
	--X射线距离
	distance = 1600,
	--X射线速度
	speed = 1600,
	--碰撞范围
	hit_area = 100,
}
--X射线
--角度
local function damage_shot(skill,angle)
	local skill = skill
	local hero = skill.owner
	-- print('射线距离',skill.distance,skill.speed,angle)
	--X射线
	local mvr = ac.mover.line
	{
		source = hero,
		distance = skill.distance,
		speed = skill.speed,
		skill = skill,
		angle = angle,
		high = 110,
		model = skill.effect, 
		hit_area = skill.hit_area,
		hit_type = ac.mover.HIT_TYPE_ENEMY,
		size = 1
	}
	if not mvr then 
		return
	end
	function mvr:on_hit(dest)
		dest:damage
		{
			source = skill.owner,
			damage = skill.damage,
			skill = skill,
			missile = skill.mover,
			damage_type = '法术'
		}
	end	
end

mt.int_now = 0

function mt:on_upgrade()
	local hero = self.owner
end

function mt:on_add()
	local hero = self.owner 
    local skill = self

	
    --注册触发
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			--在目标区域创建特效
			self.trg1 = hero:timer(self.pulse_time * 1000,5,function(t)
				local angle = hero:get_facing()
				if t.cnt <=2 then 
					--然后发射3枚射线
					for i = 1,skill.count do
						--计算角度
						local angle = angle + (skill.count / 2 - skill.count - 0.5 + i) * skill.angle
						damage_shot(skill,angle)
					end	
				else
					damage_shot(skill,angle)
				end	
			end)
            --激活cd
            skill:active_cd()
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
