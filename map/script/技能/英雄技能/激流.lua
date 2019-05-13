local mt = ac.skill['激流']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 20,
	--冷却时间
	cool = 15,
	--伤害
	damage = 5,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 400,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 召唤激流对范围300码的敌方单位攻击，造成敏捷力*5的法术伤害]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNCrushingWave.blp]],
	--特效
	effect = [[Abilities\Spells\Other\CrushingWave\CrushingWaveMissile.mdl]],
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
