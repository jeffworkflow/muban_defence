local mt = ac.skill['火焰'] 

mt{
    level = 1,
    title = "火焰",
    tip = [[
        被动1：对自己150范围内的所有敌人，每0.2秒造成其2%最大生命值的伤害
        被动2：降低自己的三维30%
    ]],

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 30,

    -- 魔抗
    magic_defence = 100,

    -- 范围
    area = 300,

    -- 每几秒
    pulse = 0.2,

    -- 每几秒
    life_rate = 2,
  
    -- 特效
    effect = [[Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)


    self.eff = hero:add_effect('origin',self.effect)

    -- local unit_mark = {}
    self.trg = hero:loop(1000,function ()

        for i, u in ac.selector()
            : in_range(hero,self.area)
            : is_enemy(hero)
			: of_not_building()
			: ipairs()
        do
            u:add_buff('火焰')
			{
				source = hero,
				skill = skill,
				time =  1,
				pulse = self.pulse,
                damage = u:get('生命上限')*self.life_rate/100,
			}

        end
    end)
    --单位死亡时立马删除这个技能，不等播放死亡动画完再删
    hero:event '单位-死亡' (function()
        if self and self.owner and self.owner:is_hero() then 
            self:remove()
        end    
    end)
    
   
end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)

    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end    
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end



local mt = ac.buff['火焰']
mt.ref = 'origin' 
mt.cover_type = 1
mt.cover_max = 1

function mt:on_add()
	self.eff = self.target:add_effect('chest', [[Abilities\Spells\Other\BreathOfFire\BreathOfFireDamage.mdl]])
end

function mt:on_remove()
	self.eff:remove()
end

function mt:on_pulse()
	self.target:damage
	{
		source = self.source,
		damage = self.damage ,
        skill = self.skill,
        real_damage = true
	}
end

