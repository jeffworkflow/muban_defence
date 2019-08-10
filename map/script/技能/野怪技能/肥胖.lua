local mt = ac.skill['肥胖']

mt.title = "肥胖"
mt.tip = [[
	被动1：降低自己的移速和攻速40%
    被动2：提升自己的三维20%
]]

--影响三维值 (怪物为：生命上限，护甲，攻击力)
mt.value = 15

--攻速
mt.attack_speed = 40
--移速
mt.move_speed = 40

--模型大小
mt.model_size = 1.25

function mt:on_add()

    local hero = self.owner 
    self.origin_size = hero:get_size()
    self.target_size = self.origin_size * self.model_size

    self.buff = hero:add_buff '缩放'
    {
        origin_size = self.origin_size,
        target_size = self.target_size,
        time = 2
    }
    
    
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    -- 降低自己攻击速度、移动速度
    hero:add('攻击速度', -self.attack_speed)
    hero:add('移动速度', -self.move_speed)

end


function mt:on_remove()
    if self.buff then 
        self.buff:remove()
    end 
    
    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    -- 降低自己攻击速度、移动速度
    hero:add('攻击速度', self.attack_speed)
    hero:add('移动速度', self.move_speed)

end

