local japi = require("jass.japi")
local mt = ac.skill['穆拉丁']
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
	effect = [[shanqiu.mdx]],
	--杀怪加力量
	kill_str = 30,
	--杀怪加护甲
	kill_defence = 1,
	--基础力量
	str = 500,
    --模型大小
    model_size = 1.6
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:add('力量',self.str)
    hero:add('杀怪加力量',self.kill_str)
    hero:add('杀怪加护甲',self.kill_defence)
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
    
    hero:add('力量',-self.str)
    hero:add('杀怪加力量',-self.kill_str)
    hero:add('杀怪加护甲',-self.kill_defence)
end
