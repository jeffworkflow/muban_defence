local mt = ac.skill['张全蛋']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能类型
	skill_type = "主动",
	--耗蓝
	cost = 70,
	--冷却时间
	cool = 45,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[召唤1只张全蛋帮助英雄作战（当前波属性*1，攻击时有概率获得额外物品（概率=10%*2.5%*怪物占用人口，物品品质=不同品质物品掉落概率））；持续时间20S；CD45S]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNPocketFactory.blp]],
	--特效
	effect = [[units\orc\HeroShadowHunter\HeroShadowHunter.mdl]],
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
