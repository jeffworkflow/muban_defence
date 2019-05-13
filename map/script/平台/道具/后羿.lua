local japi = require("jass.japi")
local mt = ac.skill['后羿']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[移速+50，攻击间隔减少0.2]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNFlakCannons.blp]],
	--特效
	effect = [[Hero_WindRunner_N2.mdx]],
	--移动速度
	move_speed = 50,
	--攻击间隔
    attack_gap = 0.2,
	--会心几率
    heart_rate = 5,
    --模型大小
    model_size = 1.4
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:add('移动速度',self.move_speed)
    hero:add('攻击间隔',-self.attack_gap)
    hero:add('会心几率',self.heart_rate)
    --改变模型
    japi.SetUnitModel(hero.handle,self.effect)
    hero:set_size(self.model_size)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    hero:add('移动速度',-self.move_speed)
    hero:add('攻击间隔',self.attack_gap)
    hero:add('会心几率',-self.heart_rate)
end
