local mt = ac.buff['buff-专注光环']

mt.cover_type = 1
mt.cover_max = 20

mt.pulse = 1
mt.effect_cover = 1 
mt.effect_data = {
    ['origin'] = [[Abilities\Spells\Other\GeneralAuraTarget\GeneralAuraTarget.mdl]]
}

mt.art = [[ReplaceableTextures\PassiveButtons\PASBTNDevotion.blp]]
mt.title = "BOSS-专注光环"
mt.tip = [[
增加'value'点护甲
]]
mt.value = 20 
mt.effect = [[Abilities\Spells\Human\DevotionAura\DevotionAura.mdl]]

function mt:on_add()
	local hero = self.target
    self.target:add('护甲', self.value)
    self.eff = hero:add_effect('origin',self.effect)
end

function mt:on_remove()
    self.target:add('护甲', -self.value)
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end



