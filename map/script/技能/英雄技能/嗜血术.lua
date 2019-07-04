local mt = ac.skill['嗜血术']
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
	skill_type = "被动,攻速",
	--被动
	passive = true,
	--属性加成
['攻击速度'] = {25,50,75,100,125},
['攻击间隔'] = {-0.05,-0.1,-0.15,-0.2,-0.25},
	--介绍
	tip = [[
        
|cffffff00【攻击速度】+25%*Lv|r
|cffffff00【攻击间隔】-0.05*Lv|r

]],
	--技能图标
	art = [[sxs.blp]],
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
