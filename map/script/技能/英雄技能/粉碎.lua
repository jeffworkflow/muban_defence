local mt = ac.skill['粉碎']

mt{
	--必填
	is_skill = true,

	--是否被动
	passive = true,
	
	--初始等级
	level = 1,
	max_level = 5,
	
	tip = [[
		|cff00ccff被动|r:
		攻击时 %chance% % 触发，对范围 %area% 码的敌人造成 %life_rate% % 的最大生命值， 近战有效
		]],
	
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNSmash.blp]],

	--概率
	chance = 15,

	--范围
	area = 300,
	--最大生命值率
	life_rate = {5,7.5,10,12.5,15},
	--技能类型
	skill_type = "被动",

	--特效模型
	effect = [[Hero_DeathProphet_N1_Missile.mdx]],


}


function mt:on_add()
	local skill = self
	local hero = self.owner 
	self.trg = hero:event '造成伤害效果' (function(trg, damage)
		local target = damage.target
		--普攻触发 and 近战
		if damage:is_common_attack() and damage.source:isMelee()  then
            --几率触发
			if math.random(1,100) > self.chance then
				return
			end
			--创建特效
			-- target:add_effect('chest',self.effect):remove()
			ac.effect(target:get_point(),self.effect,0,2,'chest'):remove()
	 	    for i, u in ac.selector()
				: in_range(target,self.area)
				: is_enemy(hero)
				: of_not_building()
				: ipairs()
			do
				u:damage
				{
					skill = self,
					source = hero,
					damage = u:get('生命上限')*self.life_rate/100,
					real_damage = true
				}
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

end
