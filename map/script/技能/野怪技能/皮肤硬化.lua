local mt = ac.skill['皮肤硬化']

mt.title = "皮肤硬化"
mt.tip = [[
    被动1：提升自己死亡掉落的经验50%，提升自己死亡掉落的金钱50%
    被动2：提升自己的三维10%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 10
mt.strong_value = 75


function mt:on_add()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('护甲%', self.strong_value)
    hero:add('魔抗%', self.strong_value)
    
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('魔抗%', -self.value)
    hero:add('攻击%', -self.value)
    

end


function mt:on_remove()
    
    local hero = self.owner 
    hero:add('护甲%', -self.strong_value)
    hero:add('魔抗%', -self.strong_value)

    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)


end

