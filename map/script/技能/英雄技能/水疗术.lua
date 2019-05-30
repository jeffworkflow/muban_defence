local mt = ac.skill['水疗术']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "主动,肉",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
    tip = [[|cff00bdec主动施放：使用回复25%生命值, 每秒回复【5%*lv】的生命值,持续3秒|r
    
]],
	--技能图标
	art = [[sls.blp]],
	--特效
    effect = [[Abilities\Spells\Human\HolyBolt\HolyBoltSpecialArt.mdl]],
    --治疗量
    heal = 25,
    stu_heal = {5,10,15,20,25},
    time = 3
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    --特效
    hero:add_effect(self.effect,'chest'):remove()
    --补血
    hero:heal
    {
        source = hero,
        skill = skill,
        -- string = '水疗术',
        size = 10,
        heal = hero:get('生命上限') * skill.heal/100,
    }	
    --加buff
    self.buff = hero:add_buff('水疗术')
    {
        value = self.stu_heal,
        source = hero,
        time = self.time,
        skill = self,
    }
end    
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end

local mt = ac.buff['水疗术']
mt.cover_type = 1
mt.cover_max = 1
mt.pulse = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    -- target:add('护甲%',-self.value)   
end
function mt:on_pulse()
    local target = self.target
    local hero = self.target
    hero:heal
    {
        source = hero,
        skill = self.skill,
        size = 10,
        heal = hero:get('生命上限') * self.value/100,
    }	
end
function mt:on_remove()
    local target = self.target 
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end