local mt = ac.skill['治疗守卫']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 45,
	--冷却时间
	cool = 30,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
	--施法范围
	area = 200,
	--介绍
	tip = [[释放一个治疗守卫，持续回复范围200内的队友的血每秒3%，持续10S]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNHealingWard.blp]],
	--特效
	effect = [[魔兽ID：ohwd
模型：units\orc\HealingWard\HealingWard.mdl]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    hero:add('攻击速度',self.attack_speed)
end
function mt:on_remove()
    local hero = self.owner
    hero:add('攻击速度',-self.attack_speed)
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
