local mt = ac.skill['治疗守卫']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 治疗",
	--耗蓝
	cost = {45,150,250,350,500},
	--冷却时间30
	cool = 15,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 800,
	--施法范围
	area = 400,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 释放一个治疗守卫，持续回复范围400内的队友的血每秒 %life_rate% % ，持续10S
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNHealingWard.blp]],
	--特效
	effect = [[units\orc\HealingWard\HealingWard.mdl]],
	effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]],
	
	--持续时间
	time = 10,
	--每秒补一次
	pulse_time = 1,
	--生命上限比率
	life_rate = {2,3,4,5,6},
}
function mt:on_add()
    local skill = self
	local hero = self.owner
	
end

function mt:on_cast_shot()
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local target = self.target

	self.eff = ac.effect(target:get_point(),skill.effect,270,0.8,'origin')
	self.eff2 = ac.effect(target:get_point(),skill.effect1,270,0.8,'origin') 
	--计时器
	self.trg = hero:timer(self.pulse_time * 1000,math.floor(self.time/self.pulse_time),function()
		for i, u in ac.selector()
			: in_range(target,skill.area)
			: is_ally(hero)
			: of_not_building()
			: ipairs()
		do
			--时停buff 无法进入移除，不知道为啥。
			u:heal
			{
				source = hero,
				skill = self,
				size = 10,
				-- string = self.name,
				heal = hero:get('生命上限')*self.life_rate/100 *( 1 + hero:get('主动释放的增益效果')/100),
			}
		end	

	end)
	function self.trg:on_timeout()
		if skill.eff then
			skill.eff:remove()
			skill.eff = nil
		end
		if skill.eff2 then
			skill.eff2:remove()
			skill.eff2 = nil
		end
	end

end	

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
