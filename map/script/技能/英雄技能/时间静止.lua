local mt = ac.skill['时间静止']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 控制",
	--耗蓝
	cost = {50,150,250,350,500},
	--冷却时间35
	cool = 20,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法距离
	range = 500,
	--施法范围
	area = 400,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 对指定区域范围400码敌人晕眩3S
	]],
	--技能图标
	art = [[jineng\jineng020.blp]],
	--特效
	effect = [[cronosphere.mdx]],
	--持续时间
	time = {3,3.5,4,4.5,5},
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

	self.eff = ac.effect(target:get_point(),skill.effect,0,0.8,'overhead')
	self.eff.unit:add_high('200')
	for i, u in ac.selector()
		: in_range(target,skill.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		--时停buff 无法进入移除，不知道为啥。
		u:add_buff '时停'
		{
			time = skill.time,
			skill = skill,
			source = hero,
		}
	end	
	--移除特效
	ac.wait(skill.time * 1000,function()
		if self.eff then
			self.eff:remove()
			self.eff = nil
		end
	end)

end	
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
