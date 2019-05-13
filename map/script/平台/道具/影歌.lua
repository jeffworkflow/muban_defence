local japi = require("jass.japi")
local mt = ac.skill['影歌']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[所有敌人的护甲-25%（可与魔王降临光环叠加）]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNFlakCannons.blp]],
	--特效
	effect = [[HeroSpecblue.mdx]],
	--护甲值
	value = 25,
	--物爆伤害
    physical_damage = 50,
    --影响范围
    area = 9999,
	--特效
	source_effect = [[Abilities\Spells\Undead\RegenerationAura\ObsidianRegenAura.mdl]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    if not hero:is_hero() then return end
    --改变模型
    japi.SetUnitModel(hero.handle,self.effect)

    local player = hero:get_owner()
    local name = self:get_name()
    --升级时，需要先删除下之前的计时器、特效，再添加buff.
    -- self:on_remove()
    if not self.timer then 
        self.eff = hero:add_effect('origin',self.source_effect)
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

local mt = ac.buff['影歌']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.pulse = 1
mt.cover_type = 1
mt.cover_max = 1
mt.effect = [[]]
-- mt.keep = true

function mt:on_add()
    local target = self.target
    -- self.eff = target:add_effect('origin',self.effect)
    target:add('护甲%',-self.value)

end

function mt:on_remove()
    local target = self.target
    if self.eff then self.eff:remove() end
    target:add('护甲%',self.value)
end
function mt:on_cover(new)
	return new.value > self.value
end