local mt = ac.skill['强化后的招架之力']
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
	title = "|cffdf19d0强化后的招架之力|r",
	--冷却时间
	cool = 20,
	--介绍
    tip = [[|cff00bdec被动效果：攻击15%几率 增加【免伤几率】+30%，持续0.4秒|r
    
]],
	--技能图标
    art = [[qhzjzl.blp]],
    
    value = 30,
    time = 0.4
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    --注册触发
    self.trg = hero:event '造成伤害效果' (function(_,damage)
        if not damage:is_common_attack()  then 
            return 
        end 
        --触发时修改攻击方式
        if math.random(100) <= self.chance then

            skill.buff = hero:add_buff('招架之力')
            {
                value = skill.value,
                source = hero,
                time = skill.time,
                skill = skill,
                effect = skill.effect,
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
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end
