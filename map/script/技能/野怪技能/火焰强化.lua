local mt = ac.skill['火焰强化']
mt{
    area = 600,
    value = 5,
    rate = 50,
    effect = [[GoblinTech_R.mdx]]
}

function mt:on_add()
    local hero = self.owner
    local skill = self
    hero:event '单位-死亡' (function()
        if math.random(100)<= self.rate then 
            hero:add_effect('origin',self.effect):remove()
            for _, u in ac.selector()
                : in_range(hero, self.area)
                : is_enemy(hero)
                : ipairs()
            do	
                u:damage
                {
                    source = hero,
                    damage = u:get('生命上限') * skill.value /100,
                    skill = skill,
                    real_damage = true,
                }
            end
        end    
    end)
end   

local mt = ac.skill['冰冻强化']
mt{
    area = 600,
    value = 3,
    rate = 50,
    effect = [[IceNova.mdx]],
    --降低移速 2秒
    time = 2,
    move_speed_rate = 70
}

function mt:on_add()
    local hero = self.owner
    local skill = self
    hero:event '单位-死亡' (function()
        if math.random(100)<= self.rate then 
            hero:add_effect('chest',self.effect):remove()
            for _, u in ac.selector()
                : in_range(hero, self.area)
                : is_enemy(hero)
                : ipairs()
            do	
                u:damage
                {
                    source = hero,
                    damage = u:get('生命上限') * skill.value /100,
                    skill = skill,
                    real_damage = true,
                }
                u:add_buff '减速' {
                    time = 2,
                    move_speed_rate = skill.move_speed_rate,
                }
            end
        end    
    end)
end   

local mt = ac.skill['闪电强化']
mt{
    area = 600,
    value = 3,
    rate = 50,
    effect = [[LightningNova.mdx]],
    --降低攻速35%，持续2秒
    time = 2,
    attack_speed = 400

}

function mt:on_add()
    local hero = self.owner
    local skill = self
    hero:event '单位-死亡' (function()
        if math.random(100)<= self.rate then 
            hero:add_effect('chest',self.effect):remove()
            for _, u in ac.selector()
                : in_range(hero, self.area)
                : is_enemy(hero)
                : ipairs()
            do	
                u:damage
                {
                    source = hero,
                    damage = u:get('生命上限') * skill.value /100,
                    skill = skill,
                    real_damage = true,
                }
                u:add_buff '减攻速' {
                    time = 2,
                    attack_speed = skill.attack_speed,
                }
            end
        end    
    end)
end   











-- for i,name in ipairs({'火焰强化','冰冻强化','闪电强化'}) do 
--     local mt = ac.skill[name] 
-- end
