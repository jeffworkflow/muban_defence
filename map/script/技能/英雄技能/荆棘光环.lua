local mt = ac.skill['荆棘光环']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    max_level = 5,
	--技能类型
	skill_type = "光环",
	--被动
	passive = true,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
    tip = [[|cff11ccff%skill_type%:|r 所有友军受攻击时，将反弹%value% %伤害
    ]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNThorns.blp]],
	--特效
	effect = [[Abilities\Spells\NightElf\ThornsAura\ThornsAura.mdl]],
	--光环影响范围
	area = 9999,
	--反弹伤害值
	value = {100,200,300,400,500},
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner

	self.buff = hero:add_buff '荆棘光环'
	{
		source = hero,
        skill = self,
		selector = ac.selector()
			: in_range(hero, self.area)
			: is_ally(hero)
			,
        -- buff的数据，会在所有自己的子buff里共享这个数据表
        data = {
			value = self.value,
            target_effect = self.effect,
        },
    }
    
end
function mt:on_remove()
    local hero = self.owner
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end

local mt = ac.aura_buff['荆棘光环']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.cover_global = 1

mt.cover_type = 1
mt.cover_max = 1

mt.effect = [[]]
mt.keep = true


function mt:on_add()
	local target = self.target
	-- print('打印受光环英雄的单位',self.target:get_name())
    self.target_eff = self.target:add_effect('origin', self.data.target_effect)
    
    self.trg = target:event '受到伤害效果' (function (_,damage)
        -- if not damage:is_common_attack()  then 
        --     return 
        -- end 
        local damage1 = damage.current_damage * self.data.value /100

        --怪物受到伤害时，伤害来源为英雄。给伤害来源添加晕眩buff，来源为怪物本身
        -- print(damage.source,damage.current_damage,damage1)
        local source = damage.source
        damage.source:damage 
        {
            source = damage.target,
            skill = self.skill,
            damage = damage1,
            real_damage = true  --真伤
        }
            
    end)
	
	
end

function mt:on_remove()

	if self.source_eff then self.source_eff:remove() end
    if self.target_eff then self.target_eff:remove() end
    
    if self.trg then 
        self.trg:remove() 
        self.trg = nil
    end  
end
