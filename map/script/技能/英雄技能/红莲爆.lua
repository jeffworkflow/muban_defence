local mt = ac.skill['红莲爆']
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
	skill_type = "主动,暴击",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
    tip = [[
        
|cff00bdec【主动施放】使用后，接下来的2/3/4/5/6次普攻必定暴击|r
    
]],
	--技能图标
    art = [[hlb.blp]],
    
    wtf_cnt = {5,8,10,12,15},
	--特效
	effect = [[]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    -- self.damage_cnt = 0
    if self.trg then 
        self.trg:remove()
    end    
    self.trg = hero:event '造成伤害前效果' (function(trg, damage)
        -- print(self.wtf_cnt)
        if self.wtf_cnt>0 then 
            if hero:get('暴击几率')<100 then 
                hero:add('暴击几率',100)
            end    
            self.wtf_cnt = self.wtf_cnt -1
        else
            hero:add('暴击几率',-100)   
            self.trg:remove()
            self.trg = nil 
        end    
    end)    
    self:set('trg',self.trg)
end    
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
