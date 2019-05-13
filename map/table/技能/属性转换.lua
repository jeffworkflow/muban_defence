local mt = ac.skill['属性转换']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[力量和敏捷互相转换，转化3%/秒的属性点。点击可切换，力量转敏捷，敏捷转力量]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNReplenishManaOn.blp]],
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
