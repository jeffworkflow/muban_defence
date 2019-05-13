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
    area = 9999,
    --值
    value = {25,35,45,55,65},
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    local name = self:get_name()
    --升级时，需要先删除下之前的计时器、特效，再添加buff.
    -- self:on_remove()
    if not self.timer then 
    -- self.eff = hero:add_effect('origin',self.effect)
        self.timer = ac.loop(1000,function ()
            for _,unit in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : ipairs()
            do 
                unit:add_buff(name)
                {
                    value = self.value,
                    time = 1,
                    source = hero,
                    skill = self,
                    effect = self.effect,
                }
            end 
        end)
    end    
 
end
function mt:on_remove()
    local hero = self.owner
    if self.timer then 
        self.timer:remove()
        self.timer = nil
    end 
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end

local mt = ac.buff['冰冷核心']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.pulse = 1
mt.cover_type = 1
mt.cover_type = 1
mt.cover_max = 1
mt.effect = [[]]
-- mt.keep = true

function mt:on_add()
    local target = self.target
    self.eff = target:add_effect('origin',self.effect)
    target:add('移动速度%',-self.value)

end

function mt:on_remove()
    local target = self.target
    if self.eff then self.eff:remove() end
    target:add('移动速度%',self.value)
end
function mt:on_cover(new)
	return new.value > self.value
end

