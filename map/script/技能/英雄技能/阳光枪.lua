local mt = ac.skill['阳光枪']
mt{
	--初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "被动 敏捷",
	--技能图标
	art = [[icon\card1_28.blp]],
	--技能说明
	title = '阳光枪',
	tip = [[
|cff11ccff%skill_type%:|r 攻击有 %chance% % 的概率对 %hit_area% 范围造成伤害 (%damage%)
伤害计算：|cffd10c44敏捷 * %int% |r+ |cffd10c44 %shanghai% |r
伤害类型：|cff04be12物理伤害|r
]],
	--范围
	hit_area = 150,
	distance = 900,
	--概率%
	chance = 15,
	cool = 1,
	int = {5,6,7,8,10},
	shanghai ={5000,50000,500000,125000,2000000},

	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
		return self.owner:get('敏捷')*self.int+self.shanghai
		end
	end	,
	--是否被动
	passive = true,
	--伤害类型
	damage_type = '物理',
	--必填
	is_skill = true,


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
		model = [[[TX]ES_Q.mdl]],
		speed = 900,
		angle = hero:get_point()/target:get_point(),
		hit_area = skill.hit_area,
		distance = skill.distance,
		high = 50,
		size = 1,
	}
	if mvr then
		for key,value in sortpairs(skill.effect_data) do 
			mvr.mover:add_effect(key,value)
		end	
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
		--添加效果
		for key,value in sortpairs(skill.effect_data) do 
			hero:add_effect(key,value):remove()
		end	
	
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
