local mt = ac.skill['穿刺']
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
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法范围
	area = 400,
	--介绍
	tip = [[对一条直线上的敌人晕眩1S，并造成力量*6的法术伤害]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNImpale.blp]],
	--特效
	effect = [[ImpaleHitTarget.mdx
ImpaleMissTarget.mdx]],
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
