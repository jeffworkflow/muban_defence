local mt = ac.skill['闪避++']

mt.title = "闪避++"
mt.tip = [[
    被动1：提升自己的闪避率70%
    被动2：降低自己的三维45%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 20

--闪避
mt.dodge = 80


function mt:on_add()

    local hero = self.owner 
    
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    -- 降低自己攻击速度、移动速度
    hero:add('闪避', self.dodge)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    -- 降低自己攻击速度、移动速度
    hero:add('闪避', -self.dodge)


end

