local mt = ac.skill['迷之领域']
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
	skill_type = "主动,攻击丢失",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
    tip = [[|cffffff00使用后周围敌人攻击有7%*Lv几率丢失，持续5秒|r
    
]],
	--技能图标
    art = [[mzly.blp]],
    value = {7,14,21,28,35},
    time = 5
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    
    for _,u in ac.selector()
        : in_range(hero,skill.area)
        : is_enemy(hero)
        : ipairs()
    do  
        u:add_buff('迷之领域')
        {
            value = self.value,
            source = hero,
            time = self.time,
            skill = self,
        }
    end


end    
function mt:on_remove()
    local hero = self.owner
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end

local mt = ac.buff['迷之领域']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('攻击丢失',self.value)   
end

function mt:on_remove()
    local target = self.target 
    target:add('攻击丢失',-self.value)    
    if self.eff then self.eff:remove() self.eff = nil end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end
