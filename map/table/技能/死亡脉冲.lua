local mt = ac.skill['死亡脉冲']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 15,
	--冷却时间
	cool = 10,
	--伤害
	damage = 4,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法范围
	area = 400,
	--介绍
	tip = [[释放出死亡脉冲，对范围400码的敌方单位造成法术伤害（智力*4），对范围400码的友方单位有医疗效果（智力*4）]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDeathCoil.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\DeathCoil\DeathCoilMissile.mdl]],
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
