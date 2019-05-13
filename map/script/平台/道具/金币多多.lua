local mt = ac.skill['金币多多']
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
|cffffff00特权：|r开局金币+1000， 每秒金币+6， 金币获取率+20%]],
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
	art = [[jbdd.blp]],
	--特效
	effect = [[]],
    --开局金币
    add_gold = 1000,
    --每秒金币
    per_gold = 6,
	--金币加成
    gold_rate = 20,
    
	
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    hero:addGold(self.add_gold)
    hero:add('每秒金币',self.per_gold)
    hero:add('金币加成',self.gold_rate)
  
    
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    
    hero:add('每秒金币',-self.per_gold)
    hero:add('金币加成',-self.gold_rate)
end
