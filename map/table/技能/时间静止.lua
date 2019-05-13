local mt = ac.skill['时间静止']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 50,
	--冷却时间
	cool = 35,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 500,
	--施法范围
	area = 400,
	--介绍
	tip = [[对指定区域范围400码敌人晕眩3S]],
	--技能图标
	art = [[jineng\jineng020.blp]],
	--特效
	effect = [[shijianjingzhi.mdx]],
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
