local mt = ac.skill['静止陷阱']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 45,
	--冷却时间
	cool = 30,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法范围
	area = 300,
	--介绍
	tip = [[在一个地方放置一个静置陷阱，3S后晕眩范围300的所有人（包括友军），持续4S]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNStasisTrap.blp]],
	--特效
	effect = [[魔兽ID：otot
模型：units\orc\StasisTotem\StasisTotem.mdl]],
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
