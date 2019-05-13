local mt = ac.skill['黑暗契约']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = all,
	--冷却时间
	cool = 25,
	--伤害
	damage = 2,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 500,
	--介绍
	tip = [[与黑暗签下契约，损失90%当前生命值，对指定敌人进行一次吸魂，造成敏捷*2的法术伤害，该技能如果杀死敌人，英雄将永久提高0.5%的敏捷]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDeathPact.blp]],
	--特效
	effect = [[闪电效果：死亡一指]],
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
