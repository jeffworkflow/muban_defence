local mt = ac.skill['连锁闪电']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 15,
	--冷却时间
	cool = 10,
	--伤害
	damage = 4,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 700,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 召唤连锁闪电对6个敌人进行攻击，第一个怪物造成智力*6的法术伤害，第二个造成智力*5的法术伤害，第三个造成智力*4的法术伤害，第四个造成智力*3的法术伤害，第五个造成智力*2的法术伤害，第六个造成智力*1的法术伤害]],
	--技能图标
	art = [[jineng\jineng016.blp]],
	--特效
	effect = [[Abilities\Weapons\Bolt\BoltImpact.mdl
闪电效果：闪电链]],
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
