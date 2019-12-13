local mt = ac.skill['反甲']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 5*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,无敌",
	--被动
	passive = true,
	--介绍
    tip = [[
        
|cff00bdec
护甲+1000/2000/3000/4000/5000；
被攻击时5%几率对敌人造成额外伤害
伤害公式：敌人攻击*5/6/7/8/10%

|r

]],
	--技能图标
    art = [[xwsy.blp]],
    ['护甲'] ={1000,5000},
    damage_rate = {5,10},
	--特效
    effect = [[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]],
    -- cool = 1,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
  
    self.trg = hero:event '受到伤害效果' (function(trg, damage)
		if not damage:is_common_attack()  then 
			return 
		end 
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            damage.source:damage
            {
                source = damage.source,
                damage = damage.source:get('攻击')*skill.damage_rate/100,
                -- damage = damage.source:get('攻击'),
                skill = skill
            }
            -- print(damage.source,damage.source:get('攻击'))
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

