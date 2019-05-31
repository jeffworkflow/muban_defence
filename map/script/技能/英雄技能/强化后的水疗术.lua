local mt = ac.skill['强化后的水疗术']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 15*(1+self.owner:get('触发概率')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "被动,肉",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的水疗术|r",
	--冷却时间
	cool = 20,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】攻击15%几率触发， 回复12%的生命值|r
    
]],
	--技能图标
	art = [[qhsls.blp]],
	--特效
    effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
    --补血量
    heal = 12
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
            --补血
            hero:heal
            {
                source = hero,
                skill = skill,
                -- string = '水疗术',
                size = 10,
                heal = hero:get('生命上限') * skill.heal/100,
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
