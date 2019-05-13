local mt = ac.skill['静止陷阱']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型 
	skill_type = "主动 控制",
	--耗蓝
	cost = {45,150,250,400,600},
	--冷却时间30
	cool = 10,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法范围
	area = 300,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 在一个地方放置一个静置陷阱，3S后晕眩范围300的所有人（包括友军），持续4S
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNStasisTrap.blp]],
	--特效
	effect = [[units\orc\StasisTotem\StasisTotem.mdl]],
	--持续时间
	time = 3,
	--晕眩时间
	yun_time = 4,
	--施法距离
	range = 1000,
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
	--移除特效
	hero:wait(skill.time * 1000,function()
		if self.eff then
			self.eff:remove()
			self.eff = nil
		end

		for i, u in ac.selector()
			: in_range(target,skill.area)
			-- : is_enemy(hero)
			: of_not_building()
			: ipairs()
		do
			--时停buff 无法进入移除，不知道为啥。
			u:add_buff '晕眩'
			{
				time = skill.yun_time,
				skill = skill,
				source = hero,
			}
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
