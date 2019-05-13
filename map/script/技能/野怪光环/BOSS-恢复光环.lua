local mt = ac.buff['buff-恢复光环']

mt.cover_type = 1
mt.cover_max = 20

mt.pulse = 1
mt.effect_cover = 1 
mt.effect_data = {
    ['origin'] = [[Abilities\Spells\Other\GeneralAuraTarget\GeneralAuraTarget.mdl]]
}

mt.art = [[ReplaceableTextures\CommandButtons\BTNHeal.blp]]
mt.title = "BOSS-耐久光环"
mt.tip = [[
每秒恢复'value'%的生命值
]]
mt.value = 15
mt.effect = [[Abilities\Spells\Undead\UnholyAura\UnholyAura.mdl]]

function mt:on_add()
    local hero = self.target
    self.eff = hero:add_effect('origin',self.effect)
end

function mt:on_pulse()
    local hero = self.target
    hero:add('生命',hero:get('生命上限') * self.value / 100)
end


function mt:on_remove()
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 

end

