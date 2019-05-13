local mt = ac.skill['钱多多']

mt.title = "钱多多"
mt.tip = [[
    被动1：提升自己死亡掉落的金钱100%
    被动2：降低自己死亡掉落的经验100%
]]

--经验
mt.exp = 100
--金钱
mt.gold = 200


function mt:on_add()

    local hero = self.owner 
    
    self.exp_base = 0
    self.gold_vase = 0
    -- 提升经验、金钱
    if hero.exp then 
        self.exp_base= hero.exp
        hero.exp = hero.exp * (1 - self.exp/100)
    end    
    if hero.gold then 
        self.gold_vase= hero.gold
        hero.gold = hero.gold * (1 + self.gold/100)
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

end

