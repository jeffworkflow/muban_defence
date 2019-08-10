local mt = ac.skill['刺猬'] 

mt{
    level = 1,
    title = "刺猬",
    tip = [[
        被动1：受到攻击时，有50%概率降低攻击者2%的生命
        被动2：降低自己的三维20%
    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 10,

    -- 生命上限比
    life_rate = 10,

    -- 概率
    rate = 75,
    -- 特效
    effect = [[Abilities\Spells\NightElf\ThornsAura\ThornsAura.mdl]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    hero:add_effect('origin',self.effect)

    self.trg = hero:event '受到伤害效果' (function (_,damage)
        
        if not damage:is_common_attack()  then 
            return 
        end 
        local rand = math.random(1,100)
        local damage1 = damage.source:get('生命上限')* self.life_rate /100

        if rand <= self.rate then 
            --怪物受到伤害时，伤害来源为英雄。给伤害来源添加晕眩buff，来源为怪物本身
            local source = damage.source
            damage.source:damage 
            {
                source = hero,
                skill = self,
                damage = damage1,
                real_damage = true  --真伤
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

