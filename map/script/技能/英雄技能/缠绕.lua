local mt = ac.skill['缠绕']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "主动,全属性,晕眩",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*7+10000)* self.level*5
end,
	--介绍
	tip = [[
		
|cff00bdec【主动施放】对周围敌人造成范围技能伤害，并晕眩1S
【伤害公式】(全属性*7+1w)*Lv*5|r

]],
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
	--施法范围
	area = 500,
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNEntanglingRoots.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\EntanglingRoots\EntanglingRootsTarget.mdl]],
	--持续时间
	time = 1 ,
	damage_type = '法术'
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_shot()
    local skill = self
    local hero = self.owner

	local target = self.target

	for i, u in ac.selector()
		: in_range(target,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		u:add_buff '晕眩'
		{
			time = self.time,
			skill = self,
			source = hero,
			ref ='origin',
			model = self.effect,
		}
		u:damage
		{
			skill = self,
			source = hero,
			damage = self.damage,
			damage_type = '法术'
		}
	end	
	
end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
