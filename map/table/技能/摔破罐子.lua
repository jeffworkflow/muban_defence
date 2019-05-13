local mt = ac.skill['摔破罐子']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 200,
	--冷却时间
	cool = 90,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 500,
	--介绍
	tip = [[直接杀死一名敌人（BOSS不行），永久降低自身15%的智力，但50%获得一个物品掉落]],
	--技能图标
	art = [[jineng\jineng027.blp]],
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
