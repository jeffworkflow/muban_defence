local mt = ac.skill['绝对领域']
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
	skill_type = "被动,肉",
	--属性加成
 ['免伤'] = {3,6,9,12,15},
	--介绍
    tip = [[
        
|cffffff00【免伤】+3*Lv|r
    
]],
	--技能图标
	art = [[jdly.blp]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
