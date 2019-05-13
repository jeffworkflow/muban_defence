local mt = ac.buff['buff-吸血光环']

mt.cover_type = 1
mt.cover_max = 20

mt.pulse = 1
mt.effect_cover = 1 
mt.effect_data = {
    ['origin'] = [[Abilities\Spells\Other\GeneralAuraTarget\GeneralAuraTarget.mdl]]
}

mt.art = [[ReplaceableTextures\PassiveButtons\PASBTNVampiricAura.blp]]
mt.title = "BOSS-吸血光环"
mt.tip = [[
增加'value'%吸血
]]
mt.value = 50 
mt.effect = [[Abilities\Spells\Undead\VampiricAura\VampiricAura.mdl]]
function mt:on_add()
	local hero = self.target
    hero:add('吸血',self.value)
    self.eff = hero:add_effect('origin',self.effect)
end

function mt:on_remove()
    local hero = self.target
    hero:add('吸血',-self.value)
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end

