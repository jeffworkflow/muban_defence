local mt = ac.skill['眩晕']

mt.title = "眩晕"
mt.tip = [[
    被动1：受到攻击时，有35%概率击晕攻击者，持续0.5秒
    被动2：降低自己的三维15%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 5

--概率
mt.rate = 35
--持续时间
mt.time = 0.5


function mt:on_add()

    local hero = self.owner 
    
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    self.trg = hero:event '受到伤害效果' (function (_,damage)
        
        if not damage:is_common_attack()  then 
            return 
        end 
        local rand = math.random(1,100)
        -- print(damage.source,damage.target)
        if rand <= self.rate then 
            --怪物受到伤害时，伤害来源为英雄。给伤害来源添加晕眩buff，来源为怪物本身
            local source = damage.source
            damage.source:add_buff '晕眩'
            {
                source = hero,
                time = self.time,
            }

        end
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

