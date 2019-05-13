local mt = ac.skill['物品多多']

mt.title = "物品多多"
mt.tip = [[
    被动1：降低自己死亡掉落的金钱00%
    被动2：提升自己死亡的物品掉落率200%
]]

--经验
mt.exp = 0
--金钱
mt.gold = 0

--物品掉落率
mt.fall_rate = 300


function mt:on_add()

    local hero = self.owner 
    
    self.exp_base = 0
    self.gold_vase = 0
    self.fall_rate_base = 0
    -- 提升经验、金钱
    if hero.exp then 
        self.exp_base= hero.exp
        hero.exp = hero.exp * (1 + self.exp/100)
    end   

    if hero.gold then 
        self.gold_vase= hero.gold
        hero.gold = hero.gold * (1 - self.gold/100)
    end   

    if hero.fall_rate then 
        self.fall_rate_base= hero.fall_rate
        hero.fall_rate = hero.fall_rate * (1 + self.fall_rate/100)
    end    
    

end


function mt:on_remove()
    
    local hero = self.owner 
  
    -- 降低经验、金钱
    if hero.exp then 
        hero.exp = self.exp_base
    end    
    if hero.gold then 
        hero.gold = self.gold_vase
    end  
    if hero.fall_rate then 
        hero.fall_rate = self.fall_rate_base
    end    

end

