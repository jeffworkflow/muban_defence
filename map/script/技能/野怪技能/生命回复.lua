local mt = ac.skill['生命回复']

mt.title = "生命回复"
mt.tip = [[
    被动1：每秒回复自己生命值5%
    被动2：降低自己的三维30%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 45

--每秒恢复
mt.life_recover = 4

mt.effect = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]


function mt:on_add()

    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    hero:add('每秒回血', self.life_recover)
    -- hero:add_effect('origin',self.effect)

    -- self.trg = hero:loop(1000,function()

    --     local max_life = hero:get('生命上限')
    --     hero:add('生命',max_life * self.life_recover/100)

    -- end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)
    hero:add('每秒回血', -self.life_recover)

    -- if self.trg then
    --     self.trg:remove()
    --     self.trg = nil
    -- end    

end

