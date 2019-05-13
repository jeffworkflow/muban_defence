local japi = require("jass.japi")
local mt = ac.skill['齐天大圣']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNFlakCannons.blp]],
	--特效
	effect = [[qtds.mdx]],
	--物爆几率
	physical_rate = 10,
	--物爆伤害
	physical_damage = 500,
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:add('物爆几率',self.physical_rate)
    hero:add('物爆伤害',self.physical_damage)
    --改变模型
    japi.SetUnitModel(hero.handle,self.effect)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('物爆几率',-self.physical_rate)
    hero:add('物爆伤害',-self.physical_damage)
end
