local mt = ac.skill['闪现']
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
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 1000,
	--介绍
	tip = [[瞬间移动，最长距离1000]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNBlink.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\Blink\BlinkCaster.mdl]],
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
