
local mt = ac.skill['巨浪']
mt{
	--初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "被动",
	--技能图标
	art = [[icon\3.blp]],
	--技能说明
	title = '巨浪 力量',
	tip = [[
|cff11ccff%skill_type%:|r 攻击有 %chance% % 的概率对 %distance% 范围造成物理伤害
		伤害计算：|cffd10c44力量 * %damage_int%|r+ |cffd10c44 %shanghai% |r
		伤害类型：|cff04be12物理伤害|r]],
	--范围
	distance = 1500,
	hit_area = 125,
	--概率%
	chance = 15,
	cool = 1,

	damage = function(self,hero)
		if self and self.owner and self.owner:is_hero() then 
			return self.owner:get('力量')*self.damage_int+self.shanghai
		end	
	end	,
	--参数智力
	damage_int = {5,6,7,8,10},

	shanghai ={5000,50000,500000,125000,2000000},

	--是否被动
	passive = true,
	--弹道数量
	num = 1,
	
	--必填
	is_skill = true,

}

mt.model = [[Abilities\Spells\Undead\FreezingBreath\FreezingBreathMissile.mdl]]
mt.effect_data = {
	['chest'] = [[Abilities\Spells\Other\CrushingWave\CrushingWaveDamage.mdl]],
}
function mt:atk_pas_shot(damage)
	local hero = self.owner
	local skill =self
	local target = damage.target
	local timer
	
	local num = skill.num

	for i = 1, num do
		local mvr = ac.mover.line
		{
			source = hero,
			skill = skill,
			model =  skill.model,
			speed = 600,
			angle = hero:get_point()/target:get_point() + 360/num * i,
			hit_area = skill.hit_area,
			distance = skill.distance,
			high = 120,
			size = 3,
		}
		if mvr then
			--timer = ac.loop(0.3*1000,function()
			--	ac.effect( mvr.mover:get_point(), skill.model, mvr.mover:get_facing(), 2 ):remove()
			--end)
			function mvr:on_hit(u)
				u:damage
				{
					source = hero,
					skill = skill,
					target = u,
					damage = skill.damage,
					damage_type = skill.damage_type,
				}
				--添加效果
				for key,value in sortpairs(skill.effect_data) do 
					u:add_effect(key,value):remove()
				end	
			end

			function mvr:on_remove()
				if timer then
					timer:remove()
				end
			end
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
