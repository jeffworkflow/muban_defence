local mt = ac.skill['魔免'] 

mt{
    level = 1,
    title = "魔免",
    tip = [[
        被动1：降低自己受到的法术伤害100%
        被动2：降低自己的三维40%
    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 40,

    -- 魔抗
    magic_defence = 100,
  
    -- 特效
    effect = [[]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)

    -- 提升自己的魔抗
    hero:add('法术伤害减免', self.magic_defence)


end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)

    -- 自己的魔抗
    hero:add('法术伤害减免', -self.magic_defence)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

