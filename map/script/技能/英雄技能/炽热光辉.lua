local mt = ac.skill['炽热光辉']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 30,
	--冷却时间
	cool = 20,
	--伤害
	damage = 6,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法范围
	area = 400,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 召唤炽热光辉，持续对一条直线上的敌人造成魔法伤害，每0.5秒造成攻击力*0.5+智力*1点法术伤害，持续3秒]],
	--技能图标
	art = [[jineng\jineng024.blp]],
	--特效
	effect = [[Abilities\Spells\Other\SoulBurn\SoulBurnbuff.mdl]],
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
