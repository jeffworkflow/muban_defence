local mt = ac.skill['群星陨落']
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

|cff00bdec【被动效果】被攻击(5+Lv)%几率造成范围技能伤害
【伤害公式】(全属性*2+1w)*Lv

]],
	--技能图标
	art = [[xingluo.blp]],
	--伤害
	damage = function(self)
		return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*2+10000)* self.level
	  end,
	
	--特效
	-- effect = [[Abilities\Spells\NightElf\Starfall.mdl]],
	effect = [[Abilities\Spells\NightElf\Starfall\StarfallTarget.mdl]],
	
    cool = 0.5,
}

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
			for i, u in ac.selector()
				: in_range(hero,self.damage_area)
				: is_enemy(hero)
				: ipairs()
			do
				u:add_effect('origin',skill.effect):remove()
				-- ac.effect_ex{
				-- 	model = skill.effect,
				-- 	point = u:get_point(),
				-- }:remove()
				ac.wait(900,function()
					u:damage
					{
						source = hero,
						skill = skill,
						damage = skill.damage,
					}
				end)
			end	
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


