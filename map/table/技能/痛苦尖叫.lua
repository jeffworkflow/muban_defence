local mt = ac.skill['痛苦尖叫']
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
	damage = 5,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法范围
	area = 300,
	--介绍
	tip = [[发出锐利的尖叫，对范围300码的敌方单位造成法术伤害（智力*4）]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNPossession.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\Possession\PossessionMissile.mdl]],
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
