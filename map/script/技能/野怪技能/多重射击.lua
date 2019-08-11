local mt = ac.skill['多重射击']
mt{
    ['多重射'] = 2,
    ['攻击距离'] = 1000,

    ['生命上限%'] = -15,
    ['护甲%'] = -15,
    ['魔抗%'] = -15,
    ['攻击%'] = -15,

}
function mt:on_add()
    local hero = self.owner

    if not hero.weapon then 
        hero.weapon = {}
    end    
    hero.weapon['弹道模型'] = [[Abilities\Weapons\WaterElementalMissile\WaterElementalMissile.mdl]]
    hero.weapon['弹道速度'] = 1000

end    

