local mt = ac.skill['远程攻击'] 

mt{
    level = 1,
    title = "远程攻击",
    tip = [[
        被动1：自己的攻击范围调整为800，
        被动2：三维降低5%
    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 5,
   
    -- 攻击距离
    attack_distance = 1000,

    --弹道模型
    -- weapon_model = [[Abilities\Weapons\WaterElementalMissile\WaterElementalMissile.mdl]],
    weapon_model =[[]]
    -- 特效
    -- effect = [[Abilities\Spells\Orc\Purge\PurgeBuffTarget.mdl]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    hero:add('攻击距离', self.attack_distance)

    if not hero.weapon then 
        hero.weapon = {}
    end    
    hero.weapon['弹道模型'] = self.weapon_model
    hero.weapon['弹道速度'] = 1000
    
end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    hero:add('攻击距离', -self.attack_distance)
    
    if not hero.weapon then 
        hero.weapon = {}
    end    
    hero.weapon['弹道模型'] = nil
    hero.weapon['弹道速度'] = nil

end

