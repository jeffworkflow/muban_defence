local mt = ac.skill['多重射击']
mt{
    ['多重射'] = 2,
    ['攻击距离'] = 600,

    ['生命上限%'] = -10,
    ['护甲%'] = -10,
    ['魔抗%'] = -10,
    ['攻击%'] = -10,

}
function mt:on_add()
    local hero = self.owner

    if not hero.weapon then 
        hero.weapon = {}
    end    
    -- hero.weapon['弹道模型'] = [[Abilities\Weapons\WaterElementalMissile\WaterElementalMissile.mdl]]
    hero.weapon['弹道模型'] = [[]]
    hero.weapon['弹道速度'] = 1000

end    

