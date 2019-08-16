local mt = ac.skill['强化后的神圣护甲']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,无敌",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的神圣护甲|r",
	--冷却时间
	cool = 1,
	ignore_cool_save = true,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】攻击10%几率让自己无敌，持续0.4S|r
    
]],
	--技能图标
	art = [[qhsshj.blp]],
	--特效
	effect = [[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]],
	--无敌时间
	stand_time = {0.4}
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
            self.buff = hero:add_buff '无敌' {
                time = self.stand_time
            }
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
