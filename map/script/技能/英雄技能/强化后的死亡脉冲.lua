local mt = ac.skill['强化后的死亡脉冲']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	title = "|cffdf19d0强化后的死亡脉冲|r",
	--冷却时间
	cool = 1,
	ignore_cool_save = true,
    --伤害范围
   area = 800,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*16+10000)* self.level
end,
	--属性加成
 ['每秒加全属性'] = {50,75,150,200,250},
 ['攻击加全属性'] = {50,75,150,200,250},
 ['杀怪加全属性'] = {50,75,150,200,250},
	--介绍
	tip = [[
		
|cffffff00【每秒加全属性】+50*Lv
【攻击加全属性】+50*Lv
【杀怪加全属性】+50*Lv|r

|cff00bdec【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】(全属性*16+1w)*Lv|r

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
            start_damage()
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
