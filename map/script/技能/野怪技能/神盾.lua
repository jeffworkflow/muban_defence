local mt = ac.skill['神盾']

mt.title = "神盾"
mt.tip = [[
    被动1：提升自己的护甲20点，提升自己护甲200%
    被动2：降低自己的移速50%
    被动3：降低自己的三维40%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 20

--移速
mt.move_speed = 50

--护甲
mt.defence_base = 20
mt.defence_rate = 150

function mt:on_add()

    local hero = self.owner 
    
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    -- 降低自己攻击速度、移动速度
    hero:add('移动速度%', -self.move_speed)

    -- 提升自己的护甲
    hero:add('护甲', self.defence_base)
    hero:add('护甲%', self.defence_rate)
end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    -- 降低自己攻击速度、移动速度
    hero:add('移动速度%', self.move_speed)

    -- 降低自己的护甲
    hero:add('护甲', -self.defence_base)
    hero:add('护甲%', -self.defence_rate)

end

