local mt = ac.skill['风暴锤子']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 30,
	--冷却时间
	cool = 20,
	--伤害
	damage = 12,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 900,
	--介绍
	tip = [[对单一敌人造成晕眩3S，并造成攻击力*3的法术伤害]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNStormBolt.blp]],
	--特效
	effect = [[StormBoltMissile.mdx
StormBoltTarget.mdx]],
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
