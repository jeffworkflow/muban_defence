local mt = ac.skill['幽灵'] 

mt{
    level = 1,
    title = "幽灵",
    tip = [[
        被动1：自己的碰撞体积调整为0
        被动2：降低自己的三维5%
    
    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 5,
    

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    hero:add_restriction '幽灵'

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)
    hero:remove_restriction '幽灵'

end

