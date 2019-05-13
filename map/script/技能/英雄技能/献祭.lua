local mt = ac.skill['献祭']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    max_level = 5,
	--技能类型
	skill_type = "主动",
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	area = 200,
	--介绍
    tip = [[|cff11ccff%skill_type%:|r 造成周围伤害（每秒损失 %magic_value% % 的魔法值， 对范围200码的造成 %life_value% % 的生命损失）
    ]],
	--技能图标
    art = [[ReplaceableTextures\CommandButtons\BTNImmolationOn.blp]],
    art1 = [[jineng033]],
    
	--特效
	effect = [[Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl]],
	--魔法值
	magic_value = {1,2,3,4,5},
	--生命值
	life_value = {4,6,8,10,12},
	--每秒
	pulse = 1,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_shot()
	local skill = self
	local hero = self.owner

    if hero:find_buff '献祭' then 
        hero:remove_buff '献祭'
    else
        hero:add_buff '献祭'
        {
            skill = skill,
            model = skill.effect,
            value = skill.magic_value,
            magic_value = skill.magic_value,
            life_value = skill.life_value,
            pulse = skill.pulse,
            area = skill.area
        }
    end    

end

function mt:on_remove()
    local hero = self.owner
    if hero:find_buff '献祭' then 
        hero:remove_buff '献祭'
    end    
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end


local mt = ac.buff['献祭']
mt.ref = 'origin' 
mt.cover_type = 1
mt.cover_max = 1
mt.keep = true
-- mt.cover_global = 1

function mt:on_add()
	local hero =self.target;
	self.eff = hero:add_effect(self.ref,self.model)
    self.blend = self.skill:add_blend(self.skill.art1, 'frame', 2)
    -- self.skill:set_art(self.skill.art1)
	-- hero:add('物品获取率',self.value * (1+hero:get('主动释放的增益效果')/100))

end

function mt:on_pulse()
    local hero = self.target
    local max_magic = hero:get('魔法上限') * self.magic_value /100
    for i, u in ac.selector()
        : in_range(hero,self.area)
        : is_enemy(hero)
        : of_not_building()
        : ipairs()
    do  
        u:add_effect('chest', [[Abilities\Spells\Other\BreathOfFire\BreathOfFireDamage.mdl]]):remove()
        u:damage
        {
            source = hero,
            damage = hero:get('生命上限') * self.life_value /100 ,
            skill = self.skill,
            real_damage = true
        }
    end

    hero:add('魔法',-max_magic) 
    if hero:get('魔法') < max_magic then 
        self:remove()
    end    

end
function mt:on_remove()
	if self.eff then self.eff:remove() self.eff =nil end 
	if self.trg then self.trg:remove() self.trg =nil end 
	if self.blend then self.blend:remove() self.blend =nil end 

    self.skill:set_art(self.skill.art)
	local hero =self.target;
	-- hero:add('物品获取率',- self.value * (1+hero:get('主动释放的增益效果')/100))
	
end
function mt:on_cover(new)
	return new.value > self.value
end