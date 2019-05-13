local mt = ac.skill['强壮']

mt.title = "强壮"
mt.tip = [[
    被动1：提升自己死亡掉落的经验50%，提升自己死亡掉落的金钱50%
    被动2：提升自己的三维20%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 20

--经验
mt.exp = 50
--金钱
mt.gold = 50


function mt:on_add()

    local hero = self.owner 
    
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)
    self.exp_base = 0
    self.gold_vase = 0
    -- 提升经验、金钱
    if hero.exp then 
        self.exp_base= hero.exp
        hero.exp = hero.exp * (1 + self.exp/100)
    end    
    if hero.gold then 
        self.gold_vase= hero.gold
        hero.gold = hero.gold * (1 + self.gold/100)
    end    
    

end


function mt:on_remove()
    
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    -- 降低经验、金钱
    if hero.exp then 
        hero.exp = self.exp_base
    end    
    if hero.gold then 
        hero.gold = self.gold_vase
    end    

end

