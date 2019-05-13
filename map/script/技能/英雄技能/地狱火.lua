local mt = ac.skill['地狱火']
mt{
    --必填
    is_skill = true,
    --初始等级
	level = 1,
	max_level = 5,
	--技能类型
	skill_type = "召唤 智力",
	--耗蓝
	cost = {120,240,360,480,600},
	--冷却时间
	cool = 55,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--介绍
	tip = [[|cff11ccff%skill_type%:|r 召唤1只地狱火助战
	
	|cff00bdec召唤物属性：和智力相关|r 

	|cff00bdec召唤物技能：硬化皮肤、火焰风衣|r
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNInfernal.blp]],
	--特效
	effect = [[units\demon\Infernal\Infernal.mdl]],
	--召唤物
	unit_name = "地狱火",
	--召唤物属性倍数
	attr_mul = {1.5,2,2.5,3,3.5},
	--持续时间
	time = {20,25,30,35,40},
	--数量
	cnt = 1,
}
	
function mt:on_add()
	local hero = self.owner 

end	
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	
	local cnt = (self.cnt + hero:get('召唤物')) or 1
	--多个召唤物
	for i=1,cnt do 

		local point = hero:get_point()-{hero:get_facing(),100}--在英雄附近 100 到 400 码 随机点
		local unit = hero:get_owner():create_unit(self.unit_name,point)	

		local index = ac.creep['刷怪'].index 
		if not index or index == 0 then 
			index = 1
		end	
		index = index + ac.creep['刷怪-无尽'].index 

		local life_mul, defence_mul, attack_mul = ac.get_summon_mul(index)
		local data = {}
		data.attribute={
			['生命上限'] = hero:get('智力') * life_mul,
			['护甲'] = hero:get('智力') * defence_mul,
			['攻击'] = hero:get('智力') * attack_mul,
			['魔法上限'] = 60,
			['移动速度'] = 325,
			['攻击间隔'] = 1,
			['生命恢复'] = 1.2,
			['魔法恢复'] = 0.6,
			['攻击距离'] = 150,
		}

		self.buff = unit:add_buff '召唤物' {
			time = self.time,
			attribute = data.attribute,
			attr_mul = self.attr_mul - 1,
			skill = self,
			follow = true
		}
		unit:add_skill('硬化皮肤','隐藏')
		unit:add_skill('火焰','隐藏')

	end	


end

function mt:on_remove()

    local hero = self.owner 
	--移除时将召唤物移除
    -- if self.buff then
    --     self.buff:remove()
    --     self.buff = nil
	-- end  
	
end