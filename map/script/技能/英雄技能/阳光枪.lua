local mt = ac.skill['阳光枪']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return (self.level+5)*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,敏捷",
	--被动
	passive = true,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*15+10000)* self.level
end,
	--属性加成
 ['杀怪加敏捷'] = {75,150,225,300,375},
	
	--技能图标
	art = [[icon\card1_28.blp]],

	tip = [[
		
|cffffff00【杀怪加敏捷】+75*Lv|r

|cff00bdec【被动效果】攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(敏捷*15+1w)*Lv|r
	
]],
	
	--范围
	hit_area = 150,
	distance = 900,

	cool = 1,
	--伤害类型
	damage_type = '法术',

	effect = [[[TX]ES_Q.mdl]]
}
mt.effect_data = {
	['chest'] = [[Abilities\Weapons\Bolt\BoltImpact.mdl]],
}

function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local mvr = ac.mover.line
	{
		source = hero,
		skill = skill,
		model = skill.effect,
		speed = 900,
		angle = hero:get_point()/target:get_point(),
		hit_area = skill.hit_area,
		distance = skill.distance,
		high = 50,
		size = 1,
	}
	if mvr then
		-- for key,value in sortpairs(skill.effect_data) do 
		-- 	mvr.mover:add_effect(key,value)
		-- end	
		function mvr:on_hit(u)
			u:damage
			{
				source = hero,
				target = u,
				skill = skill,
				--damage = 100,
				damage = skill.damage,
				damage_type = skill.damage_type,
			}
		end
	end
end

function mt:on_add()
	local hero = self.owner
	local skill = self
	
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		-- --添加效果
		-- for key,value in sortpairs(skill.effect_data) do 
		-- 	hero:add_effect(key,value):remove()
		-- end	
	
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
		local rand = math.random(1,100)
		if rand <= self.chance then 
			skill:atk_pas_shot(damage)
            --激活cd
            skill:active_cd()
		end

	end)
end

function mt:on_remove()
	if self.trg then
		self.trg:remove()
	end
end
