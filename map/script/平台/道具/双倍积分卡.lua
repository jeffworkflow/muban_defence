local japi = require("jass.japi")
local mt = ac.skill['双倍积分卡']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 0,
    --魔法书
    is_order = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[%active%
|cffffff00特权：|r获得双倍积分、双倍熟练度]],
	--技能图标
	art = [[xbjfk.blp]],
	--特效
    effect = [[]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end,    
    --获得积分额外倍数
    jifen_mul = 1,
    --获得熟练度额外倍数 
    skilled_mul = 1
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:add('积分加成',self.jifen_mul)
    hero:add('熟练度加成',self.skilled_mul)
    --添加称号
    -- self.trg = hero:add_effect('chest',self.effect)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('积分加成',-self.jifen_mul)
    hero:add('熟练度加成',-self.skilled_mul)
end
