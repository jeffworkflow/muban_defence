local mt = ac.skill['强化后的疾步风']
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
	skill_type = "被动,隐身",
	--被动
    passive = true,
    
    title = "|cffdf19d0强化后的疾步风|r",

    art = [[qhjbf.blp]],

	--冷却时间
	cool = 20,
	--介绍
    tip = [[|cff00bdec被动效果：攻击15%几率让自己隐身,持续0.3S|r
    
]],
	--隐身时间
	stand_time = 0.3,
	--移动速度
	move_speed = 150
}
	
function mt:on_add()
	local hero = self.owner 
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
            self.buff = hero:add_buff '隐身' {
                time = self.stand_time,
                -- remove_when_attack = true,
                -- remove_when_spell = true,
                move_speed = self.move_speed
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
