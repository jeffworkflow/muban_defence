local mt = ac.skill['献祭']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 200,
	--介绍
	tip = [[造成周围伤害（每秒损失2%的魔法值，对范围200码的造成2%的生命损失）]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNImmolationOn.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl]],
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
