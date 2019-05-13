local mt = ac.skill['妖刀']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "主动 控制",
	--耗蓝
	cost = {30,150,270,390,500},
	--冷却时间 20
	cool = 10,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 900,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 将指定敌人变成小动物，持续%time%S
	]],
	--技能图标
	art = [[jineng\jineng004.blp]],
	--特效
	effect = [[Abilities\Spells\Human\PolyMorph\PolyMorphDoneGround.mdx]],
	--特效
	effect1 = [[Abilities\Spells\Human\PolyMorph\PolyMorphTarget.mdx]],
	--特效
	effect2 = [[babyhippo.mdx]],
	--持续时间
	time = {3,3.5,4,4.5,5},
	unit_id = '小河马'
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target

	hero:add_effect('overhead',self.effect):remove()
	target:add_effect('chest',self.effect1):remove()
	
	--变身不支持单位
	self.buff = target:add_buff '召唤物' {
		skill = self,
		time = self.time,
		model = self.effect2,
		remove_target = false,
		size = 0.1
	}
	-- self.buff = target:add_buff '变身' {
	-- 	skill = self,
	-- 	time = self.time,
	-- 	unit_id = self.unit_id,
	-- 	size = 0.1
	-- }
	target:add_restriction '缴械'
	target:add_restriction '禁魔'
	target:add('移动速度%',-50) 

	hero:wait(self.time * 1000,function()
		if target:is_alive() then 
			target:remove_restriction '缴械'
			target:remove_restriction '禁魔'
			target:add('移动速度%',50) 
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
