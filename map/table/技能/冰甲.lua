local mt = ac.skill['冰甲']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 10,
	--冷却时间
	cool = 7,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[增加指定队友30%的护甲，受攻击时可以减慢敌人行动4秒（移动力减少50%和攻击速度减少25%），持续15S]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNFrostArmor.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\FrostArmor\FrostArmorTarget.mdl]],
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
