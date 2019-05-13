local mt = ac.skill['群体治疗']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 40,
	--冷却时间
	cool = 25,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[回复全体队友25%的血]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNScrollOfTownPortal.blp]],
	--特效
	effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
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
