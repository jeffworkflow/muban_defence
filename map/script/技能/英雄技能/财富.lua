local mt = ac.skill['财富']
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
	skill_type = "被动,收益",
	--被动
	passive = true,
	--属性加成
 ['金币加成'] = {20,40,60,80,100},
['木头加成'] = {20,40,60,80,100},
['全属性'] = {200000,400000,600000,800000,1000000},
	--介绍
	tip = [[

|cffffff00【全属性】+20W*Lv
|cffffff00【金币加成】+20%*Lv
【木头加成】+20%*Lv|r

]],
	--技能图标
	art = [[jineng\jineng019.blp]],
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
