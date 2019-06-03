local mt = ac.skill['招架之力']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能类型
	skill_type = "主动,肉",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
    tip = [[
        
|cff00bdec【主动施放】使用增加|cffffff00【免伤几率】+10%*lv|r|cff00bdec 持续8秒|r
    
]],
	--技能图标
    art = [[zjzl.blp]],
    value = {10,20,30,40,50},
    time = 8
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner

    self.buff = hero:add_buff('招架之力')
    {
        value = self.value,
        source = hero,
        time = self.time,
        skill = self,
        effect = self.effect,
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

local mt = ac.buff['招架之力']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('免伤几率',self.value)   
end

function mt:on_remove()
    local target = self.target 
    target:add('免伤几率',-self.value)  
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end

