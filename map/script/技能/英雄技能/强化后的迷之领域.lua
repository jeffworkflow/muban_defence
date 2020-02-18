local mt = ac.skill['强化后的迷之领域']
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
   title = "|cffdf19d0强化后的迷之领域|r",
	--技能类型
    skill_type = "被动,降低护甲",
    cool = 1,
	ignore_cool_save = true,
	--被动
	passive = true,
	--介绍
    tip = [[
        
|cffffff00【被动效果】攻击10%几率触发， 让周围敌人攻击有35%几率丢失，持续1秒|r
    
]],
	--技能图标
	art = [[qhmzly.blp]],
    time = 1,
    value =35
}
function mt:on_add()
    local skill = self
    local hero = self.owner

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
			--计算伤害
			for _,unit in ac.selector()
			: in_range(damage.target,skill.damage_area)
			: is_enemy(hero)
			: ipairs()
			do 
                unit:add_buff('迷之领域')
                {
                    value = self.value,
                    source = hero,
                    time = self.time,
                    skill = self,
                }
			end 
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

