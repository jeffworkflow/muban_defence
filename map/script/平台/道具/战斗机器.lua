local mt = ac.skill['战斗机器']
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
|cffffff00特权：|r基础攻击间隔-0.1，会心几率+10%，每秒全属性+8]],
    --是否激活状态
    active = function(self)
        local res = [[|cff00bdec需要：
 - 通过【官方商城】获得|r]]
        if self.level >=1 then 
            res = ''
        end    
        return res
    end, 
	--技能图标
	art = [[zdjq.blp]],
	--特效
	effect = [[]],
    --攻击间隔
    attack_gap = -0.1,
    --每秒全属性 + 8
    per_allattr = 8,
	--金币加成
    heart_rate = 10,
    
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:add('攻击间隔',self.attack_gap)
    hero:add('会心几率',self.heart_rate)
    hero:add('每秒全属性',self.per_allattr)
  
    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('攻击间隔',-self.attack_gap)
    hero:add('会心几率',-self.heart_rate)
    hero:add('每秒全属性',-self.per_allattr)
end
