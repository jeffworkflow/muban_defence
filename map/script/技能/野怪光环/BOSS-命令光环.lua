local mt = ac.buff['buff-命令光环']

mt.cover_type = 1
mt.cover_max = 20

mt.pulse = 1
mt.effect_cover = 1 
mt.effect_data = {
    ['origin'] = [[Abilities\Spells\Other\GeneralAuraTarget\GeneralAuraTarget.mdl]]
}

mt.art = [[ReplaceableTextures\PassiveButtons\PASBTNGnollCommandAura.blp]]
mt.title = "BOSS-命令光环"
mt.tip = [[
增加'value'%攻击
]]
mt.value = 50 
mt.effect = [[Abilities\Spells\Orc\WarDrums\DrumsCasterHeal.mdl]]
function mt:on_add()
    local hero = self.target
    self.state = hero:get('攻击') * (self.value / 100)
    hero:add('攻击',self.state)
    self.eff = hero:add_effect('origin',self.effect)
end

function mt:on_remove()
    local hero = self.target
    hero:add('攻击',-self.state)
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end

