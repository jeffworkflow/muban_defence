local mt = ac.skill['蚀魂魔舞']
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
	skill_type = "主动,全伤加深",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
    tip = [[
        
|cff00bdec【主动施放】增加 |cffffff00全伤加深+15%*Lv|r |cff00bdec持续8秒|r
    
]],
	--技能图标
    art = [[chmw.blp]],
    value = {15,30,45,60,75},
    time = 8,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    self.buff = hero:add_buff('蚀魂魔舞')
    {
        value = self.value,
        source = hero,
        time = self.time,
        skill = self,
    }

end    
function mt:on_remove()
    local hero = self.owner
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end

local mt = ac.buff['蚀魂魔舞']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('全伤加深',self.value)   
end

function mt:on_remove()
    local target = self.target 
    target:add('全伤加深',-self.value)    
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end
