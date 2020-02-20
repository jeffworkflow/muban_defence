local mt = ac.skill['强化后的疾步风']
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
	skill_type = "被动,隐身",
	--被动
    passive = true,
    
    title = "|cffdf19d0强化后的疾步风|r",

    art = [[qhjbf.blp]],

	--冷却时间
	cool = 1,
	ignore_cool_save = true,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】攻击10%几率让自己隐身，并提高150移动速度，持续0.5S|r
    
]],
	--隐身时间
	stand_time = 0.5,
	--移动速度
	move_speed = 150
}
	
function mt:on_add()
	local hero = self.owner 
	local skill = self 
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
            self.buff = hero:add_buff '疾步风' {
                time = self.stand_time,
                move_speed = self.move_speed
            }
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
