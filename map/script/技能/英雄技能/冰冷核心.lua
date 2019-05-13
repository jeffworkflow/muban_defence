local mt = ac.skill['冰冷核心']
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
    tip = [[|cff11ccff%skill_type%:|r 所有敌人的移动速度减少%value% %
    ]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNIceShard.blp]],
	--受光环影响的特效
	effect = [[Abilities\Spells\Other\FrostDamage\FrostDamage.mdl]],
	--持有光环技能的特效
	source_effect = [[]],
    --光环影响范围
    area = 99999,
    --值
    value = {25,35,45,55,65},
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner

    self.buff = hero:add_buff '冰冷核心'
    {
        source = hero,
        skill = self,
        selector = ac.selector()
            : in_range(hero, self.area)
            : is_enemy(hero)
			: is_not(key_unit) 
            ,
        -- buff的数据，会在所有自己的子buff里共享这个数据表
        data = {
            value = self.value,
            target_effect = self.effect,
            source_effect = self.source_effect,
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

local mt = ac.aura_buff['冰冷核心']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.cover_global = 1
mt.cover_type = 1
mt.cover_max = 1
mt.effect = [[]]
mt.keep = true


function mt:on_add()
    local target = self.target
    -- print('打印受光环英雄的单位1',self.target:get_name())
    -- print('打印受光环英雄的单位2',self.source:get_name())
    if self.target ==  self.source then 
        self.source_eff = self.target:add_effect('origin', self.data.source_effect)
    else
        self.target_eff = self.target:add_effect('origin', self.data.target_effect)
        target:add('移动速度%',-self.data.value)
    end  

    
      
end

function mt:on_remove()
    local target = self.target
    if self.source_eff then self.source_eff:remove() end
    if self.target_eff then self.target_eff:remove() end
    
    if self.target ==  self.source then 
    else
        target:add('移动速度%',self.data.value)
    end  

end
