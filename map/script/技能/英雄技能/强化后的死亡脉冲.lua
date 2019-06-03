local mt = ac.skill['强化后的死亡脉冲']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 15*(1+self.owner:get('触发概率加成')/100) end,
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	title = "|cffdf19d0强化后的死亡脉冲|r",
	--冷却时间
	cool = 15,
    --伤害范围
   area = 800,
	--伤害
	damage = function(self)
  return (self.owner:get('全属性')*10+10000)* self.level
end,
	--属性加成
 ['每秒加全属性'] = {25,50,75,100,125},
 ['攻击加全属性'] = {25,50,75,100,125},
 ['杀怪加全属性'] = {25,50,75,100,125},
	--介绍
	tip = [[
		
|cffffff00【每秒加全属性】+25*Lv
【攻击加全属性】+25*Lv
【杀怪加全属性】+25*Lv|r

|cff00bdec【被动效果】攻击15%几率造成范围技能伤害
【伤害公式】(全属性*5+1w)*Lv|r

]],
    --特效
	effect = [[Abilities\Spells\Undead\DeathCoil\DeathCoilMissile.mdl]],
	art = [[qhswmc.blp]],
    damage_type = '法术',
    casting_cnt = 1
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local function start_damage()
		for i, u in ac.selector()
			: in_range(hero,self.area)
			: of_not_building()
			: ipairs()
		do
			local mvr = ac.mover.target
			{
				source = hero,
				target = u,
				model = skill.effect,
				speed = 600,
				height = 110,
				skill = skill,
			}
			if not mvr then
				return
			end
			function mvr:on_finish()
				if u:is_enemy(hero) then 
					u:damage
					{
						source = hero,
						damage = skill.damage ,
						skill = skill,
						damage_type =skill.damage_type
					}	
				end	
			end
		end
	end

	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
			--计算伤害
			start_damage()
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
