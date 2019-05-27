local mt = ac.skill['强化后的蚀魂魔舞']
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
	skill_type = "被动,全伤加深",
	--被动
	passive = true,
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
	tip = [[|cff00bdec被动效果：攻击15%几率 增加【全伤加深】+25%，持续0.75秒|r]],
	--技能图标
	art = [[chmw.blp]],
    value = 25,
    time = 0.75,
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
			hero:add_buff('蚀魂魔舞')
            {
                value = self.value,
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
