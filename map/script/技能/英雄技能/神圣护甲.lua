local mt = ac.skill['神圣护甲']
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
	skill_type = "主动,无敌",
	--耗蓝
	cost = 100,
	--冷却时间
	cool = 20,
	--介绍
	tip = [[|cff00bdec主动施放：让自己无敌
持续时间：0.5秒*Lv|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDivineIntervention.blp]],
	--特效
	effect = [[Abilities\Spells\Human\DivineShield\DivineShieldTarget.mdl]],
	--无敌时间
	stand_time = {0.5,1,1.5,2,2.5}
}
	
function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local player = hero:get_owner()
	self.buff = hero:add_buff '无敌' {
		time = self.stand_time
	}


end

function mt:on_remove()

    local hero = self.owner 
	--移除
    if self.buff then
        self.buff:remove()
        self.buff = nil
	end  
	
end