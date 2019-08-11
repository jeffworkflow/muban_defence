local mt = ac.skill['净化'] 

mt{
    level = 1,
    title = "净化",
    tip = [[
        被动1：受到攻击时，有30%概率降低攻击者300%的攻速和60%移速，持续0.5秒
        被动2：降低自己的三维15%
    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 5,
    -- 概率
    rate = 30,
    -- 攻速
    attack_speed = 300,
    -- 移速
    move_speed = 60,
    -- 持续时间
    time = 5,

    -- 特效
    effect = [[Abilities\Spells\Orc\Purge\PurgeBuffTarget.mdl]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('魔抗%', -self.value)
    hero:add('攻击%', -self.value)


    self.trg = hero:event '受到伤害效果' (function (_,damage)
        
        if not damage:is_common_attack()  then 
            return 
        end 
        local rand = math.random(1,100)

        if rand <= self.rate then 
            --怪物受到伤害时，伤害来源为英雄。给伤害来源添加晕眩buff，来源为怪物本身
            local source = damage.source
            if source:has_restriction '无敌' then 
                return 
            end    
            damage.source:add_buff '净化' 
            {
                source = hero,
                skill = self,
                attack_speed = self.attack_speed,
                move_speed = self.move_speed,
                effect = self.effect,
                time = self.time
            }
            
        end
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('魔抗%', self.value)
    hero:add('攻击%', self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end


local mt = ac.buff['净化']
mt.cover_type = 1
mt.cover_max = 1

function mt:on_add()
    self.eff = self.target:add_effect('origin',self.effect)
	self.target:add('攻击速度', - self.attack_speed)
	self.target:add('移动速度%', - self.move_speed)
end

function mt:on_remove()
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end    
	self.target:add('攻击速度',  self.attack_speed)
    self.target:add('移动速度%',  self.move_speed)
    
end

function mt:on_cover(new)
	if new.time > self:get_remaining() then
		self:set_remaining(new.time)
	end
	return false
end
