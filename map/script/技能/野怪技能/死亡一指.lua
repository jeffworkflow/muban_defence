local mt = ac.skill['死亡一指'] 

mt{
    level = 1,
    title = "死亡一指",
    tip = [[
        被动1：每隔5秒触发，对范围600内的最近的一个敌人施放死亡一指，伤害=攻击力*3
        被动2：降低自己的三维35%
    ]],

    -- 原始伤害
    damage = function(self,hero)
        return hero:get('攻击') * 3
    end,

    -- 影响三维值 (怪物为：生命上限，护甲，攻击力)
    value = 35,
    -- cd
    cool = 5,
    -- 多少个死亡一指
    cnt = 1,
    -- 技能范围
    area = 1200,
    -- 特效
    effect = [[Abilities\Spells\Demon\DemonBoltImpact\DemonBoltImpact.mdl]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
    -- 降低三维(生命上限，护甲，攻击)
    hero:add('生命上限%', -self.value)
    hero:add('护甲%', -self.value)
    hero:add('攻击%', -self.value)
    hero:add('魔抗%', -self.value)

    --计算高度
    local function get_hith(u)
        local weapon_launch = u.weapon and u.weapon['弹道出手']
        local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
        launch_z = u:get_high() + launch_z
        return launch_z
    end
    
    --死亡一指
    local function demon_bolt()

        for i, u in ac.selector()
            : in_range(hero,self.area)
            : is_not(ac.key_unit)
            : is_enemy(hero)
			: of_not_building()
			: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
			: ipairs()
        do
			if i <= self.cnt then
                local ln = ac.lightning('TWLN', hero, u,get_hith(hero),get_hith(u))

                ln:fade(-5)
                -- u:add_effect('origin',[[AZ_SSCrow_D.mdx]]):remove()
                u:add_effect('origin',self.effect):remove()

                u:damage{
                    source = hero,
                    skill = self,
                    damage = self.damage
                }
            end    
        end

    end


    self.trg = hero:loop(1 * 1000,function()
        if self:is_cooling()  then
			return
        end
        if hero:is_alive() then 
            demon_bolt()
        end    
		self:active_cd()
    end)

end


function mt:on_remove()

    local hero = self.owner 
    -- 提升三维(生命上限，护甲，攻击)
    hero:add('生命上限%', self.value)
    hero:add('护甲%', self.value)
    hero:add('攻击%', self.value)
    hero:add('魔抗%', self.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

