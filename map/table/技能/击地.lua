local mt = ac.skill['击地']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 30,
	--冷却时间
	cool = 20,
	--伤害
	damage = 6,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 300,
	--介绍
	tip = [[对范围300码的敌人造成移动力减少50%和命中率减少25%，并造成攻击力*1.5的法术伤害]],
	--技能图标
	art = [[jineng\jineng008.blp]],
	--特效
	effect = [[ThunderclapCaster.mdx
ThunderclapTarget.mdx]],
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
