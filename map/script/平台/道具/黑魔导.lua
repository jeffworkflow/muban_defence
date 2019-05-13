local japi = require("jass.japi")
local mt = ac.skill['黑魔导']
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
	effect = [[HeroElfDarkEnchanter.mdx]],
    --模型大小
    model_size = 1.3
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
  
    --改变模型
    japi.SetUnitModel(hero.handle,self.effect)
    hero:set_size(self.model_size)
    hero.wabao_auto = true
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    hero.wabao_auto = false
    
end
