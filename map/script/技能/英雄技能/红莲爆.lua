local mt = ac.skill['红莲爆']
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
	skill_type = "主动,暴击",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
    tip = [[
        
|cff00bdec【主动施放】使用后，接下来的10/12/14/16/20次普攻必定暴击|r
    
]],
	--技能图标
	art = [[hlb.blp]],
    value = {10,12,14,16,20},
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
    self.buff = hero:add_buff('红莲爆')
    {
        value = self.value,
        source = hero,
        skill = self,
        effect = self.effect,
    }
end    
function mt:on_remove()
    local hero = self.owner
    if self.buff then
        self.buff:remove()
        self.buff = nil
    end
end
