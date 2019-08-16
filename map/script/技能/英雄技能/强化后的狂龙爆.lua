local mt = ac.skill['强化后的狂龙爆']
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
	skill_type = "被动,暴击",
	--被动
	passive = true,
    title = "|cffdf19d0强化后的狂龙爆|r",
	--冷却时间
	cool = 1,
	ignore_cool_save = true,
	--介绍
    tip = [[
        
|cff00bdec【被动效果】攻击10%几率触发 |cffffff00暴击几率+50% 暴击加深+500%|r |cff00bdec持续0.75秒|r
    
]],
	--技能图标
	art = [[qhklb.blp]],
    time = 0.75,
    crit_rate = 50,
    crit_damage = 500
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
			hero:add_buff('狂龙爆')
            {
                value = self.crit_rate,
                crit_rate = self.crit_rate,
                crit_damage = self.crit_damage,
                source = hero,
                time = self.time,
                skill = self,
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
