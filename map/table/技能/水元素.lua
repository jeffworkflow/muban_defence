local mt = ac.skill['水元素']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 60,
	--冷却时间
	cool = 40,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[召唤1只水元素帮助英雄作战（当前波属性的一半）；持续时间30S；CD40S]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNSummonWaterElemental.blp]],
	--特效
	effect = [[units\human\WaterElemental\WaterElemental.mdl]],
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
