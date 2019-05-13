local mt = ac.skill['死亡之环'] 

mt{
    level = 1,
    title = "死亡之环",
    tip = [[
        被动1：每隔5秒触发，对范围600内的最近的一个敌人施放死亡之环，伤害=攻击力*3
        被动2：降低自己的三维40%
    ]],

	--施法动作
    cast_animation = 'spell',
    cast_animation_speed = 1,

    --施法前摇后摇
    -- cast_start_time = 0.35,
    cast_channel_time = 0.75,

    -- 原始伤害
    damage = function(self,hero)
        return hero:get('攻击') * 3
    end,

    -- 伤害为敌人血量的80%
    value = 80,

    -- cd
    cool = 5,
    -- 多少个死亡一指
    -- cnt = 10,
    -- 技能范围
    area = 99999,
    -- 特效
    effect = [[Abilities\Spells\Demon\DemonBoltImpact\DemonBoltImpact.mdl]]

}


function mt:on_add()
    local skill = self
    local hero = self.owner 
end

function mt:on_cast_shot()
    local skill = self
    local hero = self.owner 

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
            : is_enemy(hero)
            : is_not(ac.key_unit)
			: of_not_building()
			: sort_nearest_hero(hero) --优先选择距离英雄最近的敌人。
			: ipairs()
        do
			-- if i <= self.cnt then
                local ln = ac.lightning('TWLN', hero, u,get_hith(hero),get_hith(u))

                ln:fade(-5)
                -- u:add_effect('origin',[[AZ_SSCrow_D.mdx]]):remove()
                u:add_effect('origin',self.effect):remove()

                u:damage{
                    source = hero,
                    skill = self,
                    damage = u:get('生命上限') * self.value / 100,
                    real_damage = true
                }
            -- end    
        end
    end
    demon_bolt()

end    
function mt:on_remove()

    local hero = self.owner 

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end

