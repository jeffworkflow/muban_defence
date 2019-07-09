local mt = ac.skill['剑空破']
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
	skill_type = "被动,攻击",
	--被动
	passive = true,
	--属性加成
['杀怪加攻击'] = {500,1000,1500,2000,2500},
['每秒加攻击'] = {1000,2000,3000,4000,5000},
['攻击减甲'] = {50,50,50,50,50},
	--介绍
    tip = [[
        
|cffffff00【杀怪加攻击】+500*Lv|r
|cffffff00【每秒加攻击】+1000*Lv|r
|cffffff00【攻击减甲】+50|r
    
]],
	--技能图标
	art = [[jkp.blp]],
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
