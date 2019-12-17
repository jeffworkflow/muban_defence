local mt = ac.skill['蝗虫群']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
	chance = function(self) return (self.level+5)*(1+self.owner:get('触发概率加成')/100) end,
   passive = true,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,无敌",
	--介绍
    tip = [[

|cffffff00【被动效果】被攻击（5+Lv%）几率召唤一群蝗虫攻击敌人

|cff00bdec【蝗虫攻击力】=英雄攻击力*50%*Lv，并继承英雄暴击几率/暴击加深/物理伤害加深/全伤加深

]],
	--技能图标
	art = [[huangchong.blp]],
	--伤害
	damage = function(self)
  return self.owner:get('攻击')*(0.5*self.level)
end,
	--特效
	effect = [[locust.mdx]],
	time = 15,--持续时间
    cool = 15,
}
local mvr_list = {}
--分2段位移，重复执行
function mt:damage_mover(start,angle,distance)
	local skill = self
	local hero=self.owner
	local p = hero:get_owner()
	local accel = angle and 50 or 0
	local angle = angle or math.random(1,360)

	local mvr = ac.mover.line
	{
		source = hero,
		start = start,
		distance = distance or 800,
		speed = 500,
		accel = accel,
		skill = skill,
		angle = angle,
		high = 110,
		model = skill.effect, 
		hit_area = 200,
		hit_type = ac.mover.HIT_TYPE_ENEMY,
		size = 1
	}
	if not mvr then
		return
	end
	table.insert(mvr_list,mvr)
	function mvr:on_move() 
		local sec_angle = math.random(-5,5)
		self.angle = self.angle- sec_angle
	end

	function mvr:on_finish() 
		-- table.remove(mvr_list)
		local x,y = self.mover:get_point():get()
		local target_angle = self.mover:get_point() / hero:get_point()
		local distance = self.mover:get_point() * hero:get_point()
		local random_angle = distance > 500 and target_angle or nil

		local target = ac.selector():in_range(hero,math.max(500,hero:get('攻击距离'))):is_enemy(hero):sort_nearest_hero(hero):get_first()
		if not target then 
			skill:damage_mover(ac.point(x,y,0),random_angle)
		else	
			--发起第二段位移
			local mvr = ac.mover.target
			{
				source = self.mover,
				start = ac.point(x,y,0),
				target = target,
				model = skill.effect,
				skill = skill,
				turn_speed = 720,
				speed = 500,
				accel = 80,
				high =120,
				on_finish = function(self)
					local x,y = self.mover:get_point():get()
					--技能伤害
					target:damage
					{
						source = hero,
						skill = skill,
						damage = skill.damage,
					}
					skill:damage_mover(ac.point(x,y,0),nil,300)
				end	
			}
			table.insert(mvr_list,mvr)

		end	
    end
end	

--分2段位移，重复执行
function mt:damage_mover_back(start,speed)
	local skill = self
	local hero=self.owner
	local p = hero:get_owner()
	
	local mvr = ac.mover.target
	{
		source = hero,
		start = start,
		target = hero,
		model = skill.effect,
		skill = skill,
		turn_speed = 720,
		speed = speed,
		accel = 100,
	}
end

function mt:on_add()
    local skill = self
    local hero = self.owner
    
	self.trg = hero:event '受到伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			hero:add_buff '蝗虫群'{
				time = skill.time,
				skill =skill
			}
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
end


local mt = ac.buff['蝗虫群']
mt.ref = 'origin' 
mt.cover_type = 0 --独占性，只有一个生效
-- mt.cover_max = 1
-- mt.cover_global = 1

function mt:on_add()
	local skill = self.skill
	local hero = self.target
	ac.timer(100,12,function()
		skill:damage_mover(hero:get_point())
	end)     
end

function mt:on_remove()
	for i,mvr in ipairs(mvr_list) do 
		--进行第三段回收运动
		if not mvr.removed then 
			self.skill:damage_mover_back(mvr.mover:get_point(),mvr.speed)
		end	
		mvr:remove()
		mvr = nil
	end	
	mvr_list = {}
end


