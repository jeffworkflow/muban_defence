local mt = ac.skill['吸血鬼']
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
	skill_type = "被动,吸血",
	--被动
	passive = true,
	--属性加成
['吸血'] = {10,20,30,40,50},
['攻击减甲'] = {15,30,45,60,75},
	--介绍
    tip = [[
        
|cffffff00【吸血】+10%*Lv|r
|cffffff00【攻击减甲】+15*Lv|r
    
]],
	--技能图标
	art = [[xxg.blp]],
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
