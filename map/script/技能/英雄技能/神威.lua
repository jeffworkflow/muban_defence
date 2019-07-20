local mt = ac.skill['神威']
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
   area = 500,
	--技能类型
	skill_type = "主动,力量",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 15,
	art = [[jineng\jineng006.blp]],
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*15+10000)* self.level*5
end,
	--属性加成
 ['每秒加力量'] = {50,100,150,200,250},
 ['攻击加力量'] = {50,100,150,200,250},
 ['杀怪加力量'] = {50,100,150,200,250},
	--介绍
	tip = [[
		
|cffffff00【每秒加力量】+50*Lv
【攻击加力量】+50*Lv
【杀怪加力量】+50*Lv|r

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(力量*15+1w)*Lv*5|r

]],
	--特效
    effect = [[GoblinTech_R.mdx]],
    damage_type = '法术',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner

	self.eff = ac.effect(hero:get_point(), self.effect, 270, 1.25,'origin'):remove()
	-- 
	for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		-- u:add_buff '晕眩'
		-- {
		-- 	source = hero,
		-- 	time = self.time,
		-- }
		u:damage
		{
			source = hero,
			damage = self.damage,
            skill = self,
            damage_type = self.damage_type
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
