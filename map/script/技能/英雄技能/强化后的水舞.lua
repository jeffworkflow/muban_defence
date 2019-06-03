local mt = ac.skill['强化后的水舞']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 15*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 800,
	--技能类型
	skill_type = "被动,智力,晕眩",
    title = "|cffdf19d0强化后的水舞|r",
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*10+10000)*5
end,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】攻击15%几率造成范围技能伤害，并晕眩1S
【伤害公式】(智力*10+1w)*5|r

]],

    --特效
    effect = [[FrostNova.mdx]],
    art =[[qhsw.blp]],
    --伤害类型
    damage_type = '法术',
    time = 1,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			--创建特效
			ac.effect(damage.source:get_point(),skill.effect,0,1,'origin'):remove()
			--计算伤害
			for _,unit in ac.selector()
			: in_range(hero,self.damage_area)
			: is_enemy(hero)
			: ipairs()
			do 
				unit:damage
				{
					source = hero,
					damage = skill.damage,
					skill = skill,
					damage_type = skill.damage_type
				}
                unit:add_buff('晕眩')
                {
                    source = hero,
                    skll = skill,
                    time = self.time
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
