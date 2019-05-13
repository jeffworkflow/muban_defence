local mt = ac.skill['信仰']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "光环",
	--被动
	passive = True,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[所有友军护甲增加15%]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNDevotion.blp]],
	--特效
	effect = [[Abilities\Spells\Human\DevotionAura\DevotionAura.mdl]],
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
