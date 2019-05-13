local mt = ac.skill['死亡一指']
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
	cool = 8,
	--伤害
	damage = 12,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 800,
	--介绍
	tip = [[对指定敌人造成智力*12的法术伤害，该技能如果杀死敌人，将刷新冷却]],
	--技能图标
	art = [[jineng\jineng003.blp]],
	--特效
	effect = [[闪电效果：死亡一指]],
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
